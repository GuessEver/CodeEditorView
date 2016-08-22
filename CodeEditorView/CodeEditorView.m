//
//  CodeEditorView.m
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import "CodeEditorView.h"
#import "CodeEditorLayoutManager.h"

@implementation CodeEditorView

- (instancetype)initWithLanguage:(CodeEditorLanguageType)languageType andColorScheme:(CodeEditorColorSchemeType)colorScheme {
    self.languagePattern = [CodeEditorLanguagePattern initWithLanguage:languageType];
    self.colorScheme = [CodeEditorColorScheme colorSchemeWithColorSchemeType:colorScheme];
    
    NSTextStorage* textStorage = [[NSTextStorage alloc] init];
    CodeEditorLayoutManager* layoutManager = [[CodeEditorLayoutManager alloc] initWithLineNumberColor:self.colorScheme.lineNumberColor];
    NSTextContainer* textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    [textContainer setWidthTracksTextView:YES];
    [textContainer setExclusionPaths:@[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, CodeEditorLineNumberColumnWidth, CGFLOAT_MAX)]]];
    [layoutManager addTextContainer:textContainer];
    
    [textStorage removeLayoutManager:textStorage.layoutManagers.firstObject];
    [textStorage addLayoutManager:layoutManager];
    // code above for line numbers
    if(self = [super initWithFrame:CGRectZero textContainer:textContainer]) {
        [self setBackgroundColor:self.colorScheme.backgroundColor];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self setDelegate:self];
    }
    return self;
}

- (instancetype)init { // with default language type and default color scheme
    if(self = [self initWithLanguage:CodeEditorLanguagePlain andColorScheme:CodeEditorColorSchemeDefault]) {
    }
    return self;
}

- (instancetype)initWithLanguage:(CodeEditorLanguageType)languageType { // with default color scheme
    if(self = [self initWithLanguage:languageType andColorScheme:CodeEditorColorSchemeDefault]) {
    }
    return self;
}

- (void)setLanguageType:(CodeEditorLanguageType)languageType {
    self.languagePattern = [CodeEditorLanguagePattern initWithLanguage:languageType];
    [self reloadData];
}

#pragma mark override setText // DO NOT directly call setText!
- (void)loadText:(NSString*)text {
    text = [text stringByReplacingOccurrencesOfString:@"\t" withString:@"    "];
    [self setText:text];
    [self reloadData];
}

#pragma mark Attributes
- (void)setAttributes:(CodeEditorColorAttribute*)attributes andPattern:(NSArray<CodeEditorPattern*>*)patterns inRange:(NSRange)range {
    for (CodeEditorPattern* pattern in patterns) {
        // NSRegularExpressionAnchorsMatchLines: match it with every single line
        NSRegularExpressionOptions option = NSRegularExpressionAnchorsMatchLines;
        if(pattern.globalMatch) option = NSRegularExpressionDotMatchesLineSeparators;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern.pattern options:option error:nil];
        [regex enumerateMatchesInString:self.textStorage.string options:0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//            NSLog(@"(%ld, %ld) = %@ -- %@", result.range.location, result.range.length, [self.textStorage.string substringWithRange:result.range], attributes.attributesDictionary);
            [self.textStorage setAttributes:attributes.attributesDictionary range:NSMakeRange(result.range.location + pattern.leftOffset, result.range.length - pattern.leftOffset - pattern.rightOffset)];
        }];
    }
}

- (void)reloadData {
    [self reloadDataInRange:NSMakeRange(0, self.textStorage.string.length)];
}
- (void)reloadDataInRange:(NSRange)range {
    // NSRange selectedRange = self.selectedRange;
    // the order represents the priorities, so do not change it if you're not sure about it!
    [self setAttributes:self.colorScheme.normal andPattern:self.languagePattern.normal inRange:range];
    if(self.languagePattern.language == CodeEditorLanguagePlain) return; // just render normal text for normal
    [self setAttributes:self.colorScheme.grammar andPattern:self.languagePattern.grammar inRange:range];
    [self setAttributes:self.colorScheme.keyword andPattern:self.languagePattern.keyword inRange:range];
    [self setAttributes:self.colorScheme.symbol andPattern:self.languagePattern.symbol inRange:range];
    [self setAttributes:self.colorScheme.number andPattern:self.languagePattern.number inRange:range];
    [self setAttributes:self.colorScheme.character andPattern:self.languagePattern.character inRange:range];
    [self setAttributes:self.colorScheme.string andPattern:self.languagePattern.string inRange:range];
    [self setAttributes:self.colorScheme.comment andPattern:self.languagePattern.comment inRange:range];
    // [self setSelectedRange:selectedRange];
}
- (void)textViewDidChange:(UITextView *)textView {
//    NSLog(@"textChanged");
//    NSLog(@"editedRange (%ld, %ld)", self.editedRange.location, self.editedRange.length);
    NSRange paragaphRange = [self.textStorage.string paragraphRangeForRange:self.editedRange];
//    NSLog(@"paragraph - (%ld, %ld) = %@", paragaphRange.location, paragaphRange.length, [self.textStorage.string substringWithRange:paragaphRange]);
    
    [self reloadDataInRange:paragaphRange];
    
#pragma mark auto indent
    if([self paragraphWithCodeBlockEndSymbol:paragaphRange] && self.languagePattern.language != CodeEditorLanguagePlain) {
        //        NSLog(@"ended symbol!");
        if(self.lastTypedString.length == 1 && [self.lastTypedString characterAtIndex:0] == [self.languagePattern.codeBlockEndSymbol characterAtIndex:self.languagePattern.codeBlockEndSymbol.length-1]) {
            [self removeOneIndentFromParagraph:paragaphRange];
        }
    }
    // cannot use reloadDataInRange, it may make comment block (/* ..(with '\n') */) error
//    [self reloadData];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if(self.languagePattern.language == CodeEditorLanguagePlain) return YES; // just render normal text for normal
    // get the edited range, just rerender the changed part, making it faster
//    NSLog(@"shouldChangeTextInRange (%ld, %ld) with text [%@]", range.location, range.length, text);
    self.editedRange = NSMakeRange(range.location, text.length);
    self.lastTypedString = text;
    
#pragma mark auto indent
    NSRange paragraphRange = [self.textStorage.string paragraphRangeForRange:range];
    if([[self.textStorage.string substringWithRange:paragraphRange] characterAtIndex:paragraphRange.length - 1] == '\n') {
        --paragraphRange.length;
    }
//    NSLog(@"paragraph range (%ld, %ld)", paragraphRange.location, paragraphRange.length);
    NSRange paragraphRangeToSelection = paragraphRange;
    paragraphRangeToSelection.length = MIN(paragraphRange.length, range.location - paragraphRange.location + 1);
//    NSLog(@"paragraphRangeToSelection range (%ld, %ld)", paragraphRangeToSelection.location, paragraphRangeToSelection.length);
    if(range.length == 1 && [text isEqualToString:@""] && paragraphRange.length > 0
       && ![[self.textStorage.string substringWithRange:range] isEqualToString:@"\n"]) { // make delete smarter!
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s+$" options:NSRegularExpressionAnchorsMatchLines error:nil];
        __block BOOL normalDelete = YES;
        [regex enumerateMatchesInString:self.textStorage.string options:0 range:paragraphRangeToSelection usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//            NSLog(@"delete indent (%ld, %ld) [%@] ! Just delete more!", result.range.location, result.range.length, [self.textStorage.string substringWithRange:result.range]);
            NSInteger needDeleteIndentLength = result.range.length - (result.range.length - 1) / 4 * 4;
//            NSLog(@"need delete indent length = %ld", needDeleteIndentLength);
            NSRange deleteIndentRange = NSMakeRange(result.range.location + result.range.length - needDeleteIndentLength, needDeleteIndentLength);
//            NSLog(@"deleted range (%ld, %ld) = [%@]", deleteIndentRange.location, deleteIndentRange.length, [self.textStorage.string substringWithRange:deleteIndentRange]);
            [self.textStorage replaceCharactersInRange:deleteIndentRange withString:@""];
            [self setSelectedRange:NSMakeRange(deleteIndentRange.location, 0)];
            normalDelete = NO;
            *stop = YES;
        }];
//        if(!normalDelete) {
//            // will return NO, so have to call it manually
//            [self textViewDidChange:self];
//        }
        return normalDelete;
    }
    else if([text isEqualToString:@"\t"]) {
        text = @"    ";
        [self.textStorage replaceCharactersInRange:range withString:text];
        [self setSelectedRange:NSMakeRange(range.location + text.length, 0)];
        
        [self textViewDidChange:self]; // beacase of value NO returned, so have to call it manually
        return NO;
    }
    else if([text isEqualToString:@"\n"]) {
//        NSLog(@"typed ender");
//        NSLog(@"paragraphRange = (%ld, %ld)", paragraphRange.location, paragraphRange.length);
        text = [text stringByAppendingString:[self getIndentFromParagraph:paragraphRangeToSelection]];
        [self.textStorage replaceCharactersInRange:range withString:text];
        [self setSelectedRange:NSMakeRange(range.location + text.length, 0)];
        
        [self textViewDidChange:self]; // beacase of value NO returned, so have to call it manually
        return NO;
    }
    return YES;
}
- (NSString*)getIndentFromParagraph:(NSRange)range {
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s*" options:NSRegularExpressionAnchorsMatchLines error:nil];
    __block NSMutableString* indent;
    [regex enumerateMatchesInString:self.textStorage.string options:0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        indent = [[self.textStorage.string substringWithRange:result.range] mutableCopy];
        *stop = YES;
    }];
    if([self paragraphEndedWithCodeBlockBeginSymbol:(NSRange)range]) [indent appendString:@"    "];
    return indent;
}
- (BOOL)paragraphEndedWithCodeBlockBeginSymbol:(NSRange)range {
    return [[self paragraph:range endedStringWithLength:self.languagePattern.codeBlockBeginSymbol.length]
            isEqualToString:self.languagePattern.codeBlockBeginSymbol];
}
- (NSString*)paragraph:(NSRange)range endedStringWithLength:(NSInteger)length {
    for(NSInteger i = range.length - 1; i >= 0; i--) {
        NSInteger index = range.location + i;
        char character = [self.textStorage.string characterAtIndex:index];
        if(character != ' ' && character != '\n') {
            if(index - length + 1 < 0) {
                return [self.textStorage.string substringToIndex:index];
            }
            NSString* endedString = [self.textStorage.string substringWithRange:NSMakeRange(index - self.languagePattern.codeBlockBeginSymbol.length + 1, self.languagePattern.codeBlockBeginSymbol.length)];
//            NSLog(@"endedString = %@", endedString);
            return endedString;
        }
    }
    return @"";
}
- (BOOL)paragraphWithCodeBlockEndSymbol:(NSRange)range {
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s*|\\n$" options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSMutableString* str = [[self.textStorage.string substringWithRange:range] mutableCopy];
    [regex replaceMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
//    NSLog(@"str = [%@]", str);
    return [str isEqualToString:self.languagePattern.codeBlockEndSymbol];
}
- (void)removeOneIndentFromParagraph:(NSRange)range {
//    NSLog(@"remove one idnent from paragraph (%ld, %ld) = [%@]", range.location, range.length, [self.textStorage.string substringWithRange:range]);
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s{1,4}" options:NSRegularExpressionAnchorsMatchLines error:nil];
    [regex enumerateMatchesInString:self.textStorage.string options:0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        NSLog(@"remove indent: (%ld, %ld) = [%@]", result.range.location, result.range.length, [self.textStorage.string substringWithRange:result.range]);
        NSRange selectedRange = self.selectedRange;
        selectedRange.length = 0;
        selectedRange.location -= result.range.length;
//        [self loadText:[self.textStorage.string stringByReplacingCharactersInRange:result.range withString:@""]];
        [self.textStorage replaceCharactersInRange:result.range withString:@""];
        [self setSelectedRange:selectedRange];
        *stop = YES; // only once
    }];
}

@end

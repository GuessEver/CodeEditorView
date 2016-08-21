//
//  CodeEditorLanguage.m
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import "CodeEditorLanguage.h"

@implementation CodeEditorLanguage

+ (NSArray<NSString*>*)suffixesOfLanguageType:(CodeEditorLanguageType)type {
    switch (type) {
        case CodeEditorLanguageC:
            return @[@"c"];
        case CodeEditorLanguageCpp:
            return @[@"cpp", @"cxx", @"cc"];
        case CodeEditorLanguagePascal:
            return @[@"pas"];
        case CodeEditorLanguageJava:
            return @[@"java"];
        default:
            return @[];
    }
}

+ (BOOL)isSuffix:(NSString*)currentSuffix equalToType:(CodeEditorLanguageType)type {
    for(NSString* suffix in [self suffixesOfLanguageType:type]) {
        if([currentSuffix isEqualToString:suffix]) {
            return YES;
        }
    }
    return NO;
}

+ (CodeEditorLanguageType)getLanguageByFileSuffixName:(NSString*)suffix {
    suffix = [suffix lowercaseString];
    for(CodeEditorLanguageType type = 0; type < CodeEditorLanguagePlain; type++) {
        if([self isSuffix:suffix equalToType:type]) {
            return type;
        }
    }
    return CodeEditorLanguagePlain;
}

@end

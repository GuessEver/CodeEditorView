//
//  CodeEditor.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeEditorColorScheme.h"
#import "CodeEditorLanguagePattern.h"

@interface CodeEditorView : UITextView <UITextViewDelegate>

@property (nonatomic, strong) CodeEditorColorScheme* colorScheme;
@property (nonatomic, strong) CodeEditorLanguagePattern* languagePattern;

@property (nonatomic) NSRange editedRange; // for optimize range for rerender data attributes

@property (nonatomic, strong) NSString* lastTypedString; // for judge whether should remove indent


- (void)setLanguageType:(CodeEditorLanguageType)languageType;
- (instancetype)initWithLanguage:(CodeEditorLanguageType)type andColorScheme:(CodeEditorColorSchemeType)colorScheme;
- (instancetype)initWithLanguage:(CodeEditorLanguageType)type;
- (void)reloadData;
- (void)loadText:(NSString*)text;

@end

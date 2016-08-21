//
//  CodeEditorColorScheme.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeEditorColorAttribute.h"

@interface CodeEditorColorScheme : NSObject

typedef enum {
    CodeEditorColorSchemeXcode = 0,
    CodeEditorColorSchemeDefault
} CodeEditorColorSchemeType;

@property (nonatomic, strong) NSString* name;
@property (nonatomic) CodeEditorColorSchemeType colorSchemeType;
@property (nonatomic, strong) UIColor* backgroundColor;
@property (nonatomic, strong) UIColor* lineNumberColor;
@property (nonatomic, strong) CodeEditorColorAttribute* matchedPair; // for pair like () [] {} etc. when cursor stops there
// regex pattern
@property (nonatomic, strong) CodeEditorColorAttribute* normal;
@property (nonatomic, strong) CodeEditorColorAttribute* comment;
@property (nonatomic, strong) CodeEditorColorAttribute* number;
@property (nonatomic, strong) CodeEditorColorAttribute* character;
@property (nonatomic, strong) CodeEditorColorAttribute* string;
@property (nonatomic, strong) CodeEditorColorAttribute* grammar;
@property (nonatomic, strong) CodeEditorColorAttribute* keyword;
@property (nonatomic, strong) CodeEditorColorAttribute* symbol;


+ (NSArray<CodeEditorColorScheme*>*)colorSchemes;
+ (instancetype)colorSchemeWithColorSchemeType:(CodeEditorColorSchemeType)type;

@end

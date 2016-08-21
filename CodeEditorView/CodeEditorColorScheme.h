//
//  CodeEditorColorScheme.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeEditorColorAttribute.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r, g, b) RGBA(r, g, b, 1.0)
#define RGB2(rgbValue) RGB((rgbValue & 0xFF0000) >> 16, (rgbValue & 0xFF00) >> 8, rgbValue & 0xFF)

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

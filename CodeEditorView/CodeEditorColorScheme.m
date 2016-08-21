//
//  CodeEditorColorScheme.m
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import "CodeEditorColorScheme.h"

// DO NOT define in *.in to avoid bug with other project
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGB(r, g, b) RGBA(r, g, b, 1.0)
#define RGB2(rgbValue) RGB((rgbValue & 0xFF0000) >> 16, (rgbValue & 0xFF00) >> 8, rgbValue & 0xFF)

@implementation CodeEditorColorScheme

- (instancetype)initWithColorSchemeName:(NSString*)name
                        colorSchemeType:(CodeEditorColorSchemeType)type
                             Background:(UIColor*)backgroundColor
                        lineNumberColor:(UIColor*)lineNumberColor
                            matchedPair:(CodeEditorColorAttribute*)matchedPair
                     andAttributeNormal:(CodeEditorColorAttribute*)normal
                                comment:(CodeEditorColorAttribute*)comment
                                 number:(CodeEditorColorAttribute*)number
                              character:(CodeEditorColorAttribute*)character
                                 string:(CodeEditorColorAttribute*)string
                                grammar:(CodeEditorColorAttribute*)grammar
                                keyword:(CodeEditorColorAttribute*)keyword
                                 symbol:(CodeEditorColorAttribute*)symbol {
    if(self = [super init]) {
        self.name = name;
        self.colorSchemeType = type;
        self.backgroundColor = backgroundColor;
        self.lineNumberColor = lineNumberColor;
        self.matchedPair = matchedPair;
        self.normal = normal;
        self.comment = comment;
        self.number = number;
        self.character = character;
        self.string = string;
        self.grammar = grammar;
        self.keyword = keyword;
        self.symbol = symbol;
    }
    return self;
}

+ (NSArray<CodeEditorColorScheme*>*)colorSchemes {
    NSMutableArray* colorSchemes;
    for(CodeEditorColorSchemeType type = 0; type < CodeEditorColorSchemeDefault; type++) {
        [colorSchemes addObject:[self colorSchemeWithColorSchemeType:type]];
    }
    return colorSchemes;
}

+ (instancetype)colorSchemeWithColorSchemeType:(CodeEditorColorSchemeType)type {
    switch (type) {
        case CodeEditorColorSchemeXcode:
        default: // CodeEditorColorSchemeDefault
            return [[[self class] alloc] initWithColorSchemeName:@"Xcode"
                                                 colorSchemeType:CodeEditorColorSchemeXcode
                                                      Background:RGB2(0xFFFFFF)
                                                 lineNumberColor:RGB2(0x808080)
                                                     matchedPair:[CodeEditorColorAttribute initWithColor:RGB2(0x000000) backgroundColor:RGB2(0xF4C20D)]
                                              andAttributeNormal:[CodeEditorColorAttribute initWithColor:RGB2(0x000000)]
                                                         comment:[CodeEditorColorAttribute initWithColor:RGB2(0x007400)]
                                                          number:[CodeEditorColorAttribute initWithColor:RGB2(0x1C00CF)]
                                                       character:[CodeEditorColorAttribute initWithColor:RGB2(0x1C00CF)]
                                                          string:[CodeEditorColorAttribute initWithColor:RGB2(0xC41A16)]
                                                         grammar:[CodeEditorColorAttribute initWithColor:RGB2(0xAA0D91)]
                                                         keyword:[CodeEditorColorAttribute initWithColor:RGB2(0x2E0D6E)]
                                                          symbol:[CodeEditorColorAttribute initWithColor:RGB2(0x000000)]
                    ];
    }
}

@end

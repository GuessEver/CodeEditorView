//
//  CodeEditorColorAttribute.m
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import "CodeEditorColorAttribute.h"

@implementation CodeEditorColorAttribute

- (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                         size:(CGFloat)size
                    underline:(BOOL)underline
                       italic:(BOOL)italic
              backgroundColor:(UIColor*)backgroundColor {
    if(self = [super init]) {
        self.color = color;
        self.bold = bold;
        self.size = size;
        self.underline = underline;
        self.italic = italic;
        self.backgroundColor = backgroundColor;
        self.attributesDictionary = @{
                                      NSForegroundColorAttributeName: color,
                                      NSFontAttributeName:
                                          (bold ? (italic
                                                   ? [UIFont fontWithName:@"Menlo-BoldItalic" size:size]
                                                   : [UIFont fontWithName:@"Menlo-Bold" size:size])
                                           : (italic
                                              ? [UIFont fontWithName:@"Menlo-Italic" size:size]
                                              : [UIFont fontWithName:@"Menlo" size:size])),
                                      NSUnderlineStyleAttributeName: underline ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone),
                                      NSBackgroundColorAttributeName: backgroundColor
                                      };
    }
    return self;
}

+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                       italic:(BOOL)italic {
    return [[[self class] alloc] initWithColor:color
                                          bold:bold
                                          size:[UIFont systemFontSize]
                                     underline:NO
                                        italic:italic
                               backgroundColor:[UIColor clearColor]
            ];
}
+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                       italic:(BOOL)italic
              backgroundColor:(UIColor*)backgroundColor {
    return [[[self class] alloc] initWithColor:color
                                          bold:bold
                                          size:[UIFont systemFontSize]
                                     underline:NO
                                        italic:italic
                               backgroundColor:backgroundColor
            ];
}

+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold {
    return [self initWithColor:color bold:bold italic:NO];
}
+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                   background:(UIColor*)backgroundColor {
    return [self initWithColor:color bold:bold italic:NO backgroundColor:backgroundColor];
}

+ (instancetype)initWithColor:(UIColor*)color
                       italic:(BOOL)italic {
    return [self initWithColor:color bold:NO italic:italic];
}
+ (instancetype)initWithColor:(UIColor*)color
                       italic:(BOOL)italic
              backgroundColor:(UIColor*)backgroundColor {
    return [self initWithColor:color bold:NO italic:italic backgroundColor:backgroundColor];
}

+ (instancetype)initWithColor:(UIColor*)color {
    return [self initWithColor:color bold:NO];
}
+ (instancetype)initWithColor:(UIColor*)color
              backgroundColor:(UIColor*)backgroundColor {
    return [self initWithColor:color bold:NO italic:NO backgroundColor:backgroundColor];
}

@end

//
//  CodeEditorColorAttribute.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeEditorColorAttribute : NSObject

@property (nonatomic, strong) NSDictionary* attributesDictionary;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic) BOOL bold;
@property (nonatomic) CGFloat size;
@property (nonatomic) BOOL underline;
@property (nonatomic) BOOL italic;
@property (nonatomic, strong) UIColor* backgroundColor;


+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                       italic:(BOOL)italic;
+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                       italic:(BOOL)italic
              backgroundColor:(UIColor*)backgroundColor;

+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold;
+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                   background:(UIColor*)backgroundColor;

+ (instancetype)initWithColor:(UIColor*)color
                       italic:(BOOL)italic;
+ (instancetype)initWithColor:(UIColor*)color
                       italic:(BOOL)italic
              backgroundColor:(UIColor*)backgroundColor;

+ (instancetype)initWithColor:(UIColor*)color;
+ (instancetype)initWithColor:(UIColor*)color
              backgroundColor:(UIColor*)backgroundColor;

@end

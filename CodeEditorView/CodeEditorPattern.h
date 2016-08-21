//
//  CodeEditorPattern.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeEditorPattern : NSObject

@property (nonatomic, strong) NSString* pattern;
@property (nonatomic) NSInteger leftOffset;
@property (nonatomic) NSInteger rightOffset;
@property (nonatomic) BOOL globalMatch;


- (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset
                    rightOffset:(NSInteger)rightOffset
                    globalMatch:(BOOL)globalMatch;

+ (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset
                    rightOffset:(NSInteger)rightOffset;
+ (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset;
+ (instancetype)initWithPattern:(NSString*)pattern
                    rightOffset:(NSInteger)rightOffset;
+ (instancetype)initWithPattern:(NSString*)pattern;
+ (instancetype)initWithPattern:(NSString*)pattern
                    globalMatch:(BOOL)globalMatch;

@end

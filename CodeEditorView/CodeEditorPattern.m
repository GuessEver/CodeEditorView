//
//  CodeEditorPattern.m
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import "CodeEditorPattern.h"

@implementation CodeEditorPattern

- (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset
                    rightOffset:(NSInteger)rightOffset
                    globalMatch:(BOOL)globalMatch {
    if(self = [super init]) {
        self.pattern = pattern;
        self.leftOffset = leftOffset;
        self.rightOffset = rightOffset;
        self.globalMatch = globalMatch;
    }
    return self;
}

+ (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset
                    rightOffset:(NSInteger)rightOffset {
    return [[[self class] alloc] initWithPattern:pattern
                                      leftOffset:leftOffset
                                     rightOffset:rightOffset
                                     globalMatch:NO
            ];
}

+ (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset {
    return [self initWithPattern:pattern leftOffset:leftOffset rightOffset:0];
}

+ (instancetype)initWithPattern:(NSString*)pattern
                    rightOffset:(NSInteger)rightOffset {
    return [self initWithPattern:pattern leftOffset:0 rightOffset:rightOffset];
}

+ (instancetype)initWithPattern:(NSString*)pattern {
    return [self initWithPattern:pattern leftOffset:0 rightOffset:0];
}

+ (instancetype)initWithPattern:(NSString*)pattern
                    globalMatch:(BOOL)globalMatch {
    return [[[self class] alloc] initWithPattern:pattern
                                      leftOffset:0
                                     rightOffset:0
                                     globalMatch:globalMatch
            ];
}

@end

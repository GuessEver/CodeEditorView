//
//  CodeEditorLayoutManager.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/17.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CodeEditorLineNumberColumnWidth 40

@interface CodeEditorLayoutManager : NSLayoutManager

@property (nonatomic) CGFloat codeEditorLineNumberColumnWidth;
@property (nonatomic, strong) UIColor* lineNumberColor;
@property (nonatomic) NSUInteger lastParaLocation;
@property (nonatomic) NSUInteger lastParaNumber;


- (instancetype)initWithLineNumberColor:(UIColor*)lineNumberColor;

@end

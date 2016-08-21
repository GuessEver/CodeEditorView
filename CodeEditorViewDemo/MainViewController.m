//
//  MainViewController.m
//  CodeEditorView
//
//  Created by Sunnycool on 16/8/21.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (instancetype)init {
    if(self = [super init]) {
        [self setTitle:@"CodeEditorView"];
        
        self.codeView = [[CodeEditorView alloc] initWithLanguage:CodeEditorLanguageCpp];
        [self.codeView setFrame:self.view.frame];
        [self.view addSubview:self.codeView];
        [self.codeView loadText:@"#include <cstdio>\nint main() {\n\tprintf(\"hello world\");\n\treturn 0;\n}"];
    }
    return self;
}

@end

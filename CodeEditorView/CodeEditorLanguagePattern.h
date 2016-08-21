//
//  CodeEditorLanguagePattern.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeEditorLanguage.h"
#import "CodeEditorPattern.h"

@interface CodeEditorLanguagePattern : NSObject

@property CodeEditorLanguageType language;
@property (nonatomic, strong) NSString* codeBlockBeginSymbol;
@property (nonatomic, strong) NSString* codeBlockEndSymbol;
// pattern
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* normal;
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* comment;
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* number;
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* character;
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* string;
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* grammar; // system
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* keyword; // something like function name or language used variables
@property (nonatomic, strong) NSArray<CodeEditorPattern*>* symbol;

+ (instancetype)initWithLanguage:(CodeEditorLanguageType)type;

@end

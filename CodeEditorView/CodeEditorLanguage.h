//
//  CodeEditorLanguage.h
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeEditorLanguage : NSObject

typedef enum {
    CodeEditorLanguageC = 0,
    CodeEditorLanguageCpp,
    CodeEditorLanguagePascal,
    CodeEditorLanguageJava,
    CodeEditorLanguagePlain
} CodeEditorLanguageType;


+ (CodeEditorLanguageType)getLanguageByFileSuffixName:(NSString*)suffix;

@end

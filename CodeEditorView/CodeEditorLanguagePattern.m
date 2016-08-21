//
//  CodeEditorLanguagePattern.m
//  CodeEditorView
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 GuessEver. All rights reserved.
//

#import "CodeEditorLanguagePattern.h"

@implementation CodeEditorLanguagePattern

- (instancetype)initWithLanguage:(CodeEditorLanguageType)type
            codeBlockBeginSymbol:(NSString*)codeBlockBeginSymbol
              codeBlockEndSymbol:(NSString*)codeBlockEndSymbol
               withPatternNormal:(NSArray<CodeEditorPattern*>*)normal
                         comment:(NSArray<CodeEditorPattern*>*)comment
                          number:(NSArray<CodeEditorPattern*>*)number
                       character:(NSArray<CodeEditorPattern*>*)character
                          string:(NSArray<CodeEditorPattern*>*)string
                         grammar:(NSArray<CodeEditorPattern*>*)grammar
                         keyword:(NSArray<CodeEditorPattern*>*)keyword
                          symbol:(NSArray<CodeEditorPattern*>*)symbol {
    if(self = [super init]) {
        self.codeBlockBeginSymbol = codeBlockBeginSymbol;
        self.codeBlockEndSymbol = codeBlockEndSymbol;
        self.normal = normal;
        self.language = type;
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

+ (instancetype)initWithLanguage:(CodeEditorLanguageType)type
            codeBlockBeginSymbol:(NSString*)codeBlockBeginSymbol
              codeBlockEndSymbol:(NSString*)codeBlockEndSymbol
              withPatternComment:(NSArray<CodeEditorPattern*>*)comment
                          number:(NSArray<CodeEditorPattern*>*)number
                       character:(NSArray<CodeEditorPattern*>*)character
                          string:(NSArray<CodeEditorPattern*>*)string
                         grammar:(NSArray<CodeEditorPattern*>*)grammar
                         keyword:(NSArray<CodeEditorPattern*>*)keyword {
    return [[[self class] alloc] initWithLanguage:type
                             codeBlockBeginSymbol:codeBlockBeginSymbol
                               codeBlockEndSymbol:codeBlockEndSymbol
                                withPatternNormal:@[
                                                    [CodeEditorPattern initWithPattern:@"(.|\n)*" globalMatch:YES]
                                                    ]
                                          comment:comment
                                           number:number
                                        character:character
                                           string:string
                                          grammar:grammar
                                          keyword:keyword
                                           symbol:@[
                                                    [CodeEditorPattern initWithPattern:@"[^a-zA-Z0-9_\\[\\]\\(\\)\\{\\},.;#]"]
                                                    ]
            ];
}

+ (instancetype)initWithLanguage:(CodeEditorLanguageType)type
            codeBlockBeginSymbol:(NSString*)codeBlockBeginSymbol
              codeBlockEndSymbol:(NSString*)codeBlockEndSymbol
              withPatternComment:(NSArray<CodeEditorPattern*>*)comment
                          number:(NSArray<CodeEditorPattern*>*)number
                       character:(NSArray<CodeEditorPattern*>*)character
                          string:(NSArray<CodeEditorPattern*>*)string
                         grammar:(NSArray<CodeEditorPattern*>*)grammar
                         keyword:(NSArray<CodeEditorPattern*>*)keyword
                          symbol:(NSArray<CodeEditorPattern*>*)symbol {
    return [[[self class] alloc] initWithLanguage:type
                             codeBlockBeginSymbol:codeBlockBeginSymbol
                               codeBlockEndSymbol:codeBlockEndSymbol
                                withPatternNormal:@[
                                                    [CodeEditorPattern initWithPattern:@"(.|\n)*" globalMatch:YES]
                                                    ]
                                          comment:comment
                                           number:number
                                        character:character
                                           string:string
                                          grammar:grammar
                                          keyword:keyword
                                           symbol:symbol
            ];
}

+ (instancetype)initWithLanguage:(CodeEditorLanguageType)type
            codeBlockBeginSymbol:(NSString*)codeBlockBeginSymbol
              codeBlockEndSymbol:(NSString*)codeBlockEndSymbol
              withPatternComment:(NSArray<CodeEditorPattern*>*)comment
                         grammar:(NSArray<CodeEditorPattern*>*)grammar
                         keyword:(NSArray<CodeEditorPattern*>*)keyword {
    return [self initWithLanguage:type
             codeBlockBeginSymbol:codeBlockBeginSymbol
               codeBlockEndSymbol:codeBlockEndSymbol
               withPatternComment:comment
                           number:@[
                                    [CodeEditorPattern initWithPattern:@"\\b[0-9]+\\b"]
                                    ]
                        character:@[
                                    [CodeEditorPattern initWithPattern:@"'(.*?)('|$)"]
                                    ]
                           string:@[
                                    [CodeEditorPattern initWithPattern:@"\"(.*?)(\"|$)"]
                                    ]
                          grammar:grammar
                          keyword:keyword
            ];
}

+ (instancetype)initWithLanguage:(CodeEditorLanguageType)type {
    switch (type) {
        case CodeEditorLanguageC:
            return [self initWithLanguage:CodeEditorLanguageC
                     codeBlockBeginSymbol:@"{"
                       codeBlockEndSymbol:@"}"
                       withPatternComment:@[
                                            [CodeEditorPattern initWithPattern:@"//(.*)"],
                                            [CodeEditorPattern initWithPattern:@"/\\*(.*?)(\\*/|$)" globalMatch:YES]
                                            ]
                                  grammar:@[
                                            [CodeEditorPattern initWithPattern:@"\\b(void|bool|char|float|int|double|short|long|unsigned|signed|struct|union|enum|typedef|sizeof|auto|static|register|extern|const|volatile|return|continue|break|goto|if|else|switch|case|default|for|do|while)\\b"],
                                            [CodeEditorPattern initWithPattern:@"^\\s*#include"]
                                            ]
                                  keyword:@[
                                            [CodeEditorPattern initWithPattern:@"\\b([a-zA-Z_]+[a-zA-Z0-9_]*?)\\(" rightOffset:1]
                                            ]
                    ];
            
        case CodeEditorLanguageCpp:
            return [self initWithLanguage:CodeEditorLanguageCpp
                     codeBlockBeginSymbol:@"{"
                       codeBlockEndSymbol:@"}"
                       withPatternComment:@[
                                            [CodeEditorPattern initWithPattern:@"//(.*)"],
                                            [CodeEditorPattern initWithPattern:@"/\\*(.*?)(\\*/|$)" globalMatch:YES]
                                            ]
                                  grammar:@[
                                            [CodeEditorPattern initWithPattern:@"\\b(asm|auto|bool|break|case|catch|char|class|const|const_cast|continue|default|delete|do|double|dynamic_cast|else|enum|explicit|export|extern|false|float|for|friend|goto|if|inline|int|long|mutable|namespace|new|operator|private|protected|public|register|reinterpret_cast|return|short|signed|sizeof|static|static_cast|struct|switch|template|this|throw|true|try|typedef|typeid|typename|union|unsigned|using|virtual|void|volatile|wchar_t|while)\\b"],
                                            [CodeEditorPattern initWithPattern:@"^\\s*#include"]
                                            ]
                                  keyword:@[
                                            [CodeEditorPattern initWithPattern:@"\\b([a-zA-Z_]+[a-zA-Z0-9_]*?)\\(" rightOffset:1]
                                            ]
                    ];
            
        case CodeEditorLanguageJava:
            return [self initWithLanguage:CodeEditorLanguageJava
                     codeBlockBeginSymbol:@"{"
                       codeBlockEndSymbol:@"}"
                       withPatternComment:@[
                                            [CodeEditorPattern initWithPattern:@"//(.*)"],
                                            [CodeEditorPattern initWithPattern:@"/\\*(.*?)(\\*/|$)" globalMatch:YES]
                                            ]
                                  grammar:@[
                                            [CodeEditorPattern initWithPattern:@"\\b(abstract|boolean|break|byte|case|catch|char|class|continue|default|do|double|else|extends|false|final|finally|float|for|if|implements|import|instanceof|int|interface|long|native|new|null|package|private|protected|public|return|short|static|super|seitch|synchronized|this|throw|throws|transient|try|true|void|volatile|while)\\b"]
                                            ]
                                  keyword:@[
                                            [CodeEditorPattern initWithPattern:@"\\b([a-zA-Z_]+[a-zA-Z0-9_]*?)\\(" rightOffset:1]
                                            ]
                    ];
            
        case CodeEditorLanguagePascal:
            return [self initWithLanguage:CodeEditorLanguagePascal
                     codeBlockBeginSymbol:@"begin"
                       codeBlockEndSymbol:@"end"
                       withPatternComment:@[
                                            [CodeEditorPattern initWithPattern:@"//(.*)"],
                                            [CodeEditorPattern initWithPattern:@"\\{(.*?)(\\}|$)" globalMatch:YES]
                                            ]
                                  grammar:@[
                                            [CodeEditorPattern initWithPattern:@"\\b(absolute|abstract|and|array|as|asm|assembler|at|automated|begin|case|cdecl|class|const|constructor|contains|default|destructor|dispid|dispinterface|div|do|downto|dynamic|else|end|except|export|exports|external|far|file|finalization|finally|for|forward|function|goto|if|implementation|implements|in|index|inherited|initialization|inline|interface|is|label|library|message|mod|name|near|nil|nodefault|not|object|of|on|or|out|overload|override|package|packed|pascal|private|procedure|program|property|protected|public|published|raise|read|readonly|record|register|reintroduce|repeat|requires|resident|resourcestring|safecall|set|shl|shr|stdcall|stored|string|then|threadvar|to|try|type|unit|until|uses|var|virtual|while|with|write|writeonly|xor)\\b"]
                                            ]
                                  keyword:@[
                                            [CodeEditorPattern initWithPattern:@"\\b([a-zA-Z_]+[a-zA-Z0-9_]*?)\\(" rightOffset:1]
                                            ]
                    ];
            
        default:
            return [self initWithLanguage:CodeEditorLanguagePlain
                     codeBlockBeginSymbol:@""
                       codeBlockEndSymbol:@""
                       withPatternComment:@[]
                                   number:@[]
                                character:@[]
                                   string:@[]
                                  grammar:@[]
                                  keyword:@[]
                                   symbol:@[]
                    ];
    }
}


@end

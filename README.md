# CodeEditorView
[![Build Status](https://travis-ci.org/GuessEver/CodeEditorView.svg?branch=master)](https://travis-ci.org/GuessEver/CodeEditorView)
[![CocoaPods](https://img.shields.io/cocoapods/v/CodeEditorView.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/CodeEditorView.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/l/CodeEditorView.svg)]()

Code Editor UITextView


## Introduction
You can use it to edit code with highlight and auto indent

<img width="300px" src="https://raw.githubusercontent.com/GuessEver/CodeEditorView/master/screen.png">

## Useage
1. import main header `#import "CodeEditorView.h"`
2. create a view to your view
```
CodeEditorView* codeView = [[CodeEditorView alloc] initWithLanguage:CodeEditorLanguageCpp];
[codeView setFrame:self.view.frame];
[self.view addSubview:codeView];
```
3. done!
4. if you want to load code by code, use
```
[codeView loadText:@"#include <cstdio>\nint main() {\n\tprintf(\"hello world\");\n\treturn 0;\n}"];
```

## Installation
1. Simply drag folder `CodeEditorView` to your project
2. Install with pod `pod install CodeEditorView`

## Language
We support `C`, `Cpp`, `Pascal` and `Java` grammar highlight now
```
typedef enum {
CodeEditorLanguageC = 0,
CodeEditorLanguageCpp,
CodeEditorLanguagePascal,
CodeEditorLanguageJava,
CodeEditorLanguagePlain
} CodeEditorLanguageType;
```

## Theme
We just have one theme now just like `Xcode`. Hope for more in the future.

## Thanks
Module|Git|License
---|---|---
TextKit_LineNumbers|https://github.com/alldritt/TextKit_LineNumbers.git|MIT
RFKeyboardToolbar|https://github.com/ruddfawcett/RFKeyboardToolbar.git|MIT

## License
MIT
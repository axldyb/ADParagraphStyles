//
//  ADParagraphStyle.m
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "ADParagraphStyle.h"


@implementation ADParagraphStyle

- (id)initWithStartTag:(NSString *)startTag
                endTag:(NSString *)endTag
{
    self = [super init];
    if (self)
    {
        self.startTag = startTag;
        self.endTag = endTag;
    }
    return self;
}

- (id)initWithStartTag:(NSString *)startTag endTag:(NSString *)endTag andBasedOnStyle:(ADParagraphStyle *)baseStyle
{
    self = [super init];
    if (self)
    {
        self.startTag       = startTag;
        self.endTag         = endTag;
        self.fontName       = baseStyle.fontName;
        self.fontSize       = baseStyle.fontSize;
        self.color          = baseStyle.color;
        self.lineBreakMode  = baseStyle.lineBreakMode;
        self.textAlignment  = baseStyle.textAlignment;
        self.lineSpacing    = baseStyle.lineSpacing;
    }
    return self;
}

- (id)initAsParagraphStyle:(kADParagraphStyle)paragraphStyle
{
    self = [super init];
    if (self)
    {
        switch (paragraphStyle)
        {
            case kADParagraphStyleStandard:
                self = [self initWithStartTag:kADTagStartText endTag:kADTagEndText];
                break;
                
            case kADParagraphStyleBold:
                self = [self initWithStartTag:kADTagStartBold endTag:kADTagEndBold];
                self.fontName = kADFontHelveticaBold;
                break;
                
            default:
                break;
        }
        
    }
    return self;
}

#pragma mark - Standard values

- (NSString *)fontName
{
    if (_fontName)
    {
        return _fontName;
    }
    
    _fontName = kADFontHelvetica;
    return _fontName;
}

- (CGFloat)fontSize
{
    if (_fontSize)
    {
        return _fontSize;
    }
    
    _fontSize = kADParagraphStylesStandardFontSize;
    return _fontSize;
}

- (UIColor *)color
{
    if (_color)
    {
        return _color;
    }
    
    _color = [UIColor blackColor];
    return _color;
}

- (CTLineBreakMode)lineBreakMode
{
    if (_lineBreakMode)
    {
        return _lineBreakMode;
    }
    
    _lineBreakMode = kCTLineBreakByWordWrapping;
    return _lineBreakMode;
}

- (CTTextAlignment)textAlignment
{
    if (_textAlignment)
    {
        return _textAlignment;
    }
    
    _textAlignment = kCTLeftTextAlignment;
    return _textAlignment;
}

- (CGFloat)lineSpacing
{
    if (_lineSpacing)
    {
         return _lineSpacing;
    }
    
    _lineSpacing = 1.0;
    return _lineSpacing;
}

@end

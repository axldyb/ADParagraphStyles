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

- (id)initWithParagraphStyleTemplate:(kADParagraphStyle)paragraphStyle
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

- (NSDictionary *)attributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [paragraphStyle setLineSpacing:self.lineSpacing];
    [paragraphStyle setFirstLineHeadIndent:self.firstLineIndent];
    [paragraphStyle setHeadIndent:self.headIndent];
    [paragraphStyle setTailIndent:self.tailIndent];
    [paragraphStyle setParagraphSpacing:self.spacing];
    [paragraphStyle setParagraphSpacingBefore:self.spacingBefore];
    //[paragraphStyle setHyphenationFactor:1.0];
    //[paragraphStyle setBaseWritingDirection:0.0];
    
    UIFont *paragraphStyleFont = [UIFont fontWithName:self.fontName size:self.fontSize];
    NSNumber *kerning = [NSNumber numberWithFloat:self.kerning];
    
    NSMutableDictionary *paragraphStyleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     paragraphStyleFont,    NSFontAttributeName,
                                                     self.color,            NSForegroundColorAttributeName,
                                                     paragraphStyle,        NSParagraphStyleAttributeName,
                                                     kerning,               NSKernAttributeName,
                                                     nil];
    
    return paragraphStyleAttributes;
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

- (CGFloat)firstLineIndent
{
    if (_firstLineIndent)
    {
        return _firstLineIndent;
    }
    
    _firstLineIndent = 0.0;
    return _firstLineIndent;
}

- (CGFloat)headIndent
{
    if (_headIndent)
    {
        return _headIndent;
    }
    
    _headIndent = 0.0;
    return _headIndent;
}

- (CGFloat)tailIndent
{
    if (_tailIndent)
    {
        return _tailIndent;
    }
    
    _tailIndent = 0.0;
    return _tailIndent;
}

- (CGFloat)kerning
{
    if (_kerning)
    {
        return _kerning;
    }
    
    _kerning = kADParagraphStylesFontHandleKerning;
    return _kerning;
}

- (CGFloat)glyphs
{
    if (_glyphs)
    {
        return _glyphs;
    }
    
    _glyphs = 0;
    return _glyphs;
}

- (CGFloat)spacing
{
    if (_spacing)
    {
        return _spacing;
    }
    
    _spacing = 0.0;
    return _spacing;
}

- (CGFloat)spacingBefore
{
    if (_spacingBefore)
    {
        return _spacingBefore;
    }
    
    _spacingBefore = 0.0;
    return _spacingBefore;
}

@end

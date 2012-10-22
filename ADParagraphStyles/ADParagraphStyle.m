//
//  ADParagraphStyle.m
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "ADParagraphStyle.h"

static NSString *kADParagraphStylesStandardFont = @"Helvetica";
static CGFloat kADParagraphStylesStandardFontSize = 12.0f;

@implementation ADParagraphStyle

- (void)setup
{
    self.startTag       = @"<text>";
    self.endTag         = @"</text>";
    self.fontName       = kADFontHelvetica;
    self.fontSize       = kADParagraphStylesStandardFontSize;
    self.color          = [UIColor blackColor];
    self.lineBreakMode  = kCTLineBreakByWordWrapping;
    self.textAlignment  = kCTLeftTextAlignment;
    self.lineSpacing    = 1.0;
}

- (id)initWithStartTag:(NSString *)startTag
                endTag:(NSString *)endTag
                fontName:(kADFontName)fontName
              fontSize:(CGFloat)fontSize 
                 color:(UIColor *)color
         lineBreakMode:(CTLineBreakMode)lineBreakMode
         textAlignment:(CTTextAlignment)textAlignment
           lineSpacing:(CGFloat)lineSpacing
{
    self = [super init];
    if (self)
    {
        [self setup];
        
        if (startTag)
        {
            self.startTag = startTag;
        }
        
        if (endTag)
        {
            self.endTag = endTag;
        }
        
        if (fontName)
        {
            self.fontName = [self fontAsString:fontName];
        }
        
        if (fontSize)
        {
            self.fontSize = fontSize;
            
            if (self.fontSize == 0)
            {
                self.fontSize = kADParagraphStylesStandardFontSize;
            }
        }
        
        if (color)
        {
            self.color = color;
        }
        
        if (lineBreakMode)
        {
            self.lineBreakMode = lineBreakMode;
        }
        
        if (textAlignment)
        {
            self.textAlignment = textAlignment;
        }
        
        if (lineSpacing)
        {
            self.lineSpacing = lineSpacing;
        }
    }
    return self;
}

- (NSString *)fontAsString:(kADFontName)fontKey
{
    NSString *fontName = nil;
    
    switch (fontKey)
    {
        case kADFontHelvetica:
            fontName = @"Helvetica";
            break;
            
        case kADFontHelveticaBold:
            fontName = @"Helvetica-Bold";
            break;
            
        case kADFontHelveticaOblique:
            fontName = @"Helvetica-Oblique";
            break;
            
        case kADFontHelveticaBoldOblique:
            fontName = @"Helvetica-BoldOblique";
            break;
            
        case kADFontArial:
            fontName = @"ArialMT";
            break;
            
        case kADFontArialBold:
            fontName = @"Arial-BoldMT";
            break;
            
        case kADFontArialItalic:
            fontName = @"Arial-ItalicMT";
            break;
            
        case kADFontArialBoldItalic:
            fontName = @"Arial-BoldItalicMT";
            break;
            
        case kADFontAmericanTypewriter:
            fontName = @"AmericanTypewriter";
            break;
            
        case kADFontAmericanTypewriterBold:
            fontName = @"AmericanTypewriter-Bold";
            break;
            
        case kADFontMarkerFeltThin:
            fontName = @"MarkerFelt-Thin";
            break;
            
        case kADFontMarkerFeltWide:
            fontName = @"MarkerFelt-Wide";
            break;
            
        default:
            fontName = kADParagraphStylesStandardFont;
            break;
    }
    
    return fontName;
}

@end

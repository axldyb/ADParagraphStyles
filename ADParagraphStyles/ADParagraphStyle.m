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
    self.font           = [UIFont fontWithName:kADParagraphStylesStandardFont size:kADParagraphStylesStandardFontSize];
    self.color          = [UIColor blackColor];
    self.lineBreakMode  = kCTLineBreakByWordWrapping;
    self.textAlignment  = kCTLeftTextAlignment;
    self.lineSpacing    = 1.0;
}

- (id)initWithStartTag:(NSString *)startTag
                endTag:(NSString *)endTag
                  font:(UIFont *)font
                 color:(UIColor *)color
         lineBreakMode:(CTLineBreakMode)lineBreakMode
         textAlignment:(CTTextAlignment)textAlignment
           lineSpacing:(CGFloat)lineSpacing
{
    self = [super init];
    if (self)
    {
        [self setup];
        
        if (!startTag)
        {
            return self;
        }
        
        if (!endTag)
        {
            return self;
        }
        
        if (font)
        {
            self.font = font;
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
@end

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
    self.font           = [UIFont fontWithName:kADParagraphStylesStandardFont size:kADParagraphStylesStandardFontSize];
    self.startTag       = @"<text>";
    self.endTag         = @"</text>";
    self.color          = [UIColor blackColor];
    self.lineBreakMode  = kCTLineBreakByWordWrapping;
    self.textAlignment  = kCTLeftTextAlignment;
    self.lineSpacing    = 1.0f;
}

- (id)initWithStartTag:(NSString *)startTag
                endTag:(NSString *)endTag
                  font:(UIFont *)font
                 color:(UIColor *)color
         lineBreakMode:(CTLineBreakMode)lineBrakMode
         textAlignment:(CTTextAlignment)textAlignment
           lineSpacing:(CGFloat)lineSpacing
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}
@end

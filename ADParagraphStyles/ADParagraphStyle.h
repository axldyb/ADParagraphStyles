//
//  ADParagraphStyle.h
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Fonts

typedef enum {
    kADFontHelvetica,
    kADFontHelveticaBold,
    kADFontHelveticaBoldOblique,
    kADFontHelveticaOblique,
    kADFontArial,
    kADFontArialBold,
    kADFontArialItalic,
    kADFontArialBoldItalic,
    kADFontAmericanTypewriter,
    kADFontAmericanTypewriterBold,
    kADFontMarkerFeltThin,
    kADFontMarkerFeltWide
} kADFontName;


#pragma mark - Interface

@interface ADParagraphStyle : NSObject

@property (nonatomic, strong) NSString *startTag;

@property (nonatomic, strong) NSString *endTag;

// Font
@property (nonatomic, strong) NSString *fontName;

// Font size
@property (nonatomic, assign) CGFloat fontSize;

// Coloring
@property (nonatomic, strong) UIColor *color;

//Formatting
@property (nonatomic, assign) CTLineBreakMode   lineBreakMode;
@property (nonatomic, assign) CTTextAlignment   textAlignment;
@property (nonatomic, assign) CGFloat           lineSpacing;
//@property (nonatomic, assign) CGFloat           firstLineHeadIndent;

- (id)initWithStartTag:(NSString *)startTag
                endTag:(NSString *)endTag
              fontName:(kADFontName)fontName
              fontSize:(CGFloat)fontSize
                 color:(UIColor *)color
         lineBreakMode:(CTLineBreakMode)lineBrakMode
         textAlignment:(CTTextAlignment)textAlignment
           lineSpacing:(CGFloat)lineSpacing;

#warning Create a method to be able to base a new style based on another one.

#warning We want predefined paragraph styles to be able to use the most common styles fast

@end
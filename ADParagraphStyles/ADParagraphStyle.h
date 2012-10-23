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
#warning Move this to its own file.


#pragma mark - Interface

@interface ADParagraphStyle : NSObject


/// ---------------------------------
/// /** @name Apperance */
/// ---------------------------------

/**
 Start tag
 */
@property (nonatomic, strong) NSString *startTag;

/**
 End tag
 */
@property (nonatomic, strong) NSString *endTag;

/**
 Font name
 */
@property (nonatomic, assign) kADFontName fontName;

/**
 Font size
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 Color
 */
@property (nonatomic, strong) UIColor *color;


/// ---------------------------------
/// /** @name Formatting */
/// ---------------------------------

/**
 Line break mode
 */
@property (nonatomic, assign) CTLineBreakMode   lineBreakMode;

/**
 Text alignment
 */
@property (nonatomic, assign) CTTextAlignment   textAlignment;

/**
 Line spacing
 */
@property (nonatomic, assign) CGFloat           lineSpacing;

/**
 First line indent
 */
//@property (nonatomic, assign) CGFloat           firstLineHeadIndent;



- (id)initWithStartTag:(NSString *)startTag endTag:(NSString *)endTag;

- (id)initWithStartTag:(NSString *)startTag endTag:(NSString *)endTag andBasedOnStyle:(ADParagraphStyle *)baseStyle;

- (NSString *)fontAsString:(kADFontName)fontKey;

#warning Create a method to be able to base a new style based on another one.

#warning We want a set of standard tags to use. HTML based?

#warning We want predefined paragraph styles to be able to use the most common styles fast

#warning We want indents and custom placement plus plus

#warning We want kerning and letterspacing and all we can get of geeky typography

@end
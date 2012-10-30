//
//  ADParagraphStyle.h
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParagraphStyleConstants.h"


/// ---------------------------------
/// /** @name Template Paragraph Styles */
/// ---------------------------------

#pragma mark - Standard Paragraph Styles

typedef enum {
    kADParagraphStyleStandard,
    kADParagraphStyleBold
} kADParagraphStyle;

#pragma mark - Interface

@interface ADParagraphStyle : NSObject

/// ---------------------------------
/// /** @name Attributes */
/// ---------------------------------

/**
 All attributes in a dictionary.
 Used by the text view for easy access.
 */
@property (nonatomic, strong) NSDictionary *attributes;


/// ---------------------------------
/// /** @name Apperance */
/// ---------------------------------

/**
 Start tag
 Must be set
 */
@property (nonatomic, strong) NSString *startTag;

/**
 End tag
 Must be set
 */
@property (nonatomic, strong) NSString *endTag;

/**
 Font name
 Default: kADFontHelvetica
 */
@property (nonatomic, strong) NSString *fontName;

/**
 Font size
 Default: kADParagraphStylesStandardFontSize (12)
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 Color
 Default: [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *color;


/// ---------------------------------
/// /** @name Formatting */
/// ---------------------------------

/**
 Line break mode
 You hardly need to override the default in normal text.
 This might be overridden by a better hyphenation method in the future.
 Default: kCTLineBreakByWordWrapping
 */
@property (nonatomic, assign) CTLineBreakMode lineBreakMode;

/**
 Text alignment
 Default: kCTLeftTextAlignment
 */
@property (nonatomic, assign) CTTextAlignment textAlignment;

/**
 Line spacing
 Default: 1.0
 */
@property (nonatomic, assign) CGFloat lineSpacing;

/**
 First line indent
 Default: 0.0
 */
@property (nonatomic, assign) CGFloat firstLineIndent;

/**
 Head indent
 Default: 0.0
 */
@property (nonatomic, assign) CGFloat headIndent;

/**
 Tail indent
 Calculated from the beginning of the line
 Default: 0.0
 */
@property (nonatomic, assign) CGFloat tailIndent;

/**
 Kerning
 WARNING: This sets an equal kerning on every character!
 An upgrade for this would be to add an algorithm for 
 automatic kerninglinke InDesign's optical kerning. 
 
 For now this is the option we got. It acts very much like letterspacing.
 Default: 0.0
 */
@property (nonatomic, assign) CGFloat kerning;

/**
 Sets an alternative glyph
 Default: kADParagraphStylesFontHandleKerning
 */
@property (nonatomic, assign) CGFloat glyphs;

/**
 Sets the spacing
 Default: 0.0
 */
@property (nonatomic, assign) CGFloat spacing;

/**
 Sets the spacing before
 Default: 0.0
 */
@property (nonatomic, assign) CGFloat spacingBefore;


/// ---------------------------------
/// /** @name Initialization */
/// ---------------------------------

/**
 Init new style
 */
- (id)initWithStartTag:(NSString *)startTag endTag:(NSString *)endTag;

/**
 Init new style based on existing style
 */
- (id)initWithStartTag:(NSString *)startTag endTag:(NSString *)endTag andBasedOnStyle:(ADParagraphStyle *)baseStyle;

/**
 Init a template style
 
 The options are:
    kADParagraphStyleStandard (surround text with <text> and </text>)
    kADParagraphStyleBold (surround text with <bold> and </bold>)
 
 @param paragraphStyle The choosen template paragraph style
 */
- (id)initWithParagraphStyleTemplate:(kADParagraphStyle)paragraphStyle;


//#warning We want a set of standard tags to use. HTML based?

#warning We want more predefined paragraph styles to be able to use the most common styles fast

#warning We want kerning and letterspacing and all we can get of geeky typography

#warning Collumn support

@end
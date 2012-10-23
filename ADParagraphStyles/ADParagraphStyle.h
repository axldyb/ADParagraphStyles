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
/// /** @name Standard Paragraph Styles */
/// ---------------------------------

#pragma mark - Standard Paragraph Styles

typedef enum {
    kADParagraphStyleStandard,
    kADParagraphStyleBold
} kADParagraphStyle;

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
@property (nonatomic, strong) NSString *fontName;

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
 Init a standard style
 
 The options are:
    kADParagraphStyleStandard (surround text with <text> and </text>)
    kADParagraphStyleBold (surround text with <bold> and </bold>)
 
 @param paragraphStyle The choosen standard paragraph style
 */
- (id)initAsParagraphStyle:(kADParagraphStyle)paragraphStyle;


#warning We want a set of standard tags to use. HTML based?

#warning We want predefined paragraph styles to be able to use the most common styles fast

#warning We want indents and custom placement plus plus

#warning We want kerning and letterspacing and all we can get of geeky typography

@end
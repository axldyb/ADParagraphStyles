//
//  ParagraphStyleConstants.h
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/23/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#pragma mark - Fonts

/// ---------------------------------
/// /** @name Font */
/// ---------------------------------

/**
 Helvetica
 */
static NSString * const kADFontHelvetica =                  @"Helvetica";
static NSString * const kADFontHelveticaBold =              @"Helvetica-Bold";
static NSString * const kADFontHelveticaBoldOblique =       @"Helvetica-BoldOblique";
static NSString * const kADFontHelveticaOblique =           @"Helvetica-Oblique";

/**
 Arial
 */
static NSString * const kADFontArial =                      @"ArialMT";
static NSString * const kADFontArialBold =                  @"Arial-BoldMT";
static NSString * const kADFontArialItalic =                @"Arial-ItalicMT";
static NSString * const kADFontArialBoldItalic =            @"Arial-BoldItalicMT";

/**
 American Typewriter
 */
static NSString * const kADFontAmericanTypewriter =         @"AmericanTypewriter";
static NSString * const kADFontAmericanTypewriterBold =     @"AmericanTypewriter-Bold";

/**
 Marker Felt
 */
static NSString * const kADFontMarkerFeltThin =             @"MarkerFelt-Thin";
static NSString * const kADFontMarkerFeltWide =             @"MarkerFelt-Wide";

/**
 Palatino
 */
static NSString * const kADFontPalatinoRoman =              @"Palatino-Roman";
static NSString * const kADFontPalatinoBold =               @"Palatino-Bold";
static NSString * const kADFontPalatinoItalic =             @"Palatino-Italic";
static NSString * const kADFontPalatinoBoldItalic =         @"Palatino-BoldItalic";

/**
 Times New Roman
 */
static NSString * const kADFontTimesNewRoman =              @"TimesNewRomanPSMT";
static NSString * const kADFontTimesNewRomanBold =          @"TimesNewRomanPS-BoldMT";
static NSString * const kADFontTimesNewRomanItalic =        @"TimesNewRomanPS-ItalicMT";
static NSString * const kADFontTimesNewRomanBoldItalic =    @"TimesNewRomanPS-BoldItalicMT";


/// ---------------------------------
/// /** @name Font size */
/// ---------------------------------

static CGFloat const kADParagraphStylesStandardFontSize = 12.0f;


/// ---------------------------------
/// /** @name Standard tags */
/// ---------------------------------

/**
 Text tag
 */
static NSString * const kADTagStartText = @"<text>";
static NSString * const kADTagEndText = @"</text>";

/**
 Bold tag
 */
static NSString * const kADTagStartBold = @"<bold>";
static NSString * const kADTagEndBold = @"</bold>";

/**
 Paragraph tag
 */
static NSString * const kADTagStartParagraph = @"<p>";
static NSString * const kADTagEndParagraph = @"</p>";
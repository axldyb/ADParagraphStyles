//
//  HiViewController.m
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import "HiViewController.h"
#import "ADAttributedTextView.h"
#import "ADParagraphStyle.h"

@interface HiViewController ()

@end

@implementation HiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add a scrollview to hold the text view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:scrollView];
    
    // The text we want to display
    NSString *stringToDisplay = [self theText];
    
    // Our text view to display text. Can be initialized to prefered size.
    ADAttributedTextView *textView = [[ADAttributedTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 700) text:stringToDisplay padding:15.0f];
    
    // Adding background color
    textView.backgroundColor = [UIColor whiteColor];
    
    // Here we create a paragraph style. The tags is also placed in the text, but will not be displyed.
    // They are only used as references for the paragraph style to know where to apply itself.
    ADParagraphStyle *mainParagrapStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<text>" endTag:@"</text>"];
    mainParagrapStyle.fontName = kADFontPalatinoRoman;
    
    // This style is a template style and creates bold text.
    ADParagraphStyle *boldParagrapStyle = [[ADParagraphStyle alloc] initWithParagraphStyleTemplate:kADParagraphStyleBold];
    boldParagrapStyle.fontName = kADFontPalatinoBold;
    
    // This style is based on the previous style with custom color
    ADParagraphStyle *blueBoldParagraphStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<blue>" endTag:@"</blue>" andBasedOnStyle:boldParagrapStyle];
    blueBoldParagraphStyle.color = [UIColor blueColor];
    blueBoldParagraphStyle.kerning = 3.0;
    
    // This style has a first line indent
    ADParagraphStyle *lineIndentParagraphStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<in>" endTag:@"</in>" andBasedOnStyle:boldParagrapStyle];
    lineIndentParagraphStyle.firstLineIndent = 15.0f;
    lineIndentParagraphStyle.spacing = 5.0f;
    lineIndentParagraphStyle.fontSize = 18.0f;
    
    // Citation style
    ADParagraphStyle *citationParagraphStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<citation>" endTag:@"</citation>"];
    citationParagraphStyle.spacing = 10.0f;
    citationParagraphStyle.spacingBefore = 10.0f;
    citationParagraphStyle.firstLineIndent = 20.0f;
    citationParagraphStyle.headIndent = 20.0f;
    citationParagraphStyle.tailIndent = 260.0f;
    citationParagraphStyle.fontSize = 10.0f;
    citationParagraphStyle.fontName = kADFontPalatinoItalic;
    
    // Glyphs
    ADParagraphStyle *glyphParagraphStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<fi>" endTag:@"</fi>" andBasedOnStyle:mainParagrapStyle];
    glyphParagraphStyle.glyphs = 5;
    
    // Add our paragraph styles to the text view
    [textView addParagraphStyle:mainParagrapStyle];
    [textView addParagraphStyle:boldParagrapStyle];
    [textView addParagraphStyle:blueBoldParagraphStyle];
    [textView addParagraphStyle:lineIndentParagraphStyle];
    [textView addParagraphStyle:citationParagraphStyle];
    [textView addParagraphStyle:glyphParagraphStyle];
    
    // Add text view to our scroll view
    [scrollView addSubview:textView];
    scrollView.contentSize = textView.frame.size;
}

- (NSString *)theText
{
    // This is the text we want to display. It has tags similar to HTML used by the paragraph styles to know where to apply themselfs.
    return @"<text><in>The Macintosh operating system has provided sophisticated text handling and typesetting capabilities from its beginning.</in>\nIn fact, these features sparked the desktop publishing revolution. <bold>Core Text</bold> is the most modern text-handling technology on the platform. It is designed speci<fi>f</fi>ically for OS X and is written in C, so it can be called from any language in the system. \n<citation>It is positioned as a core technology to provide consistent, high-performance text services to other frameworks throughout the system.</citation>\nThe <bold>Core Text</bold> API is accessible to applications that need to use it directly. <bold>Core Text</bold> resides in the Application Services umbrella framework <blue>(ApplicationServices)</blue> so that it is callable from both Carbon and Cocoa and has all of the lower-level services it needs. <bold>Core Text</bold> is not meant to replace the Cocoa text system, although it provides the underlying implementation for many <bold>Cocoa</bold> text technologies. If you can deal with high-level constructs, such as text views, you can probably use Cocoa. For this reason, Cocoa developers typically have no need to use <bold>Core Text</bold> directly. Carbon developers, on the other hand, will find <bold>Core Text</bold> faster and easier to use, in many cases, than preexisting OS X text layout and font APIs.</text>";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

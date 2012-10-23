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
    ADAttributedTextView *textView = [[ADAttributedTextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) text:stringToDisplay padding:15.0f];
    
    // Adding background color
    textView.backgroundColor = [UIColor whiteColor];
    
    // Here we create a paragraph style. The tags is also placed in the text, but will not be displyed.
    // They are only used as references for the paragraph style to know where to apply itself.
    ADParagraphStyle *americanParagrapStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<text>" endTag:@"</text>"];
    
    // This style is a standard style and creates bold text.
    ADParagraphStyle *boldParagrapStyle = [[ADParagraphStyle alloc] initAsParagraphStyle:kADParagraphStyleBold];
    
    // This style is based on the previous style with custom color
    ADParagraphStyle *blueBoldParagraphStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<blue>" endTag:@"</blue>" andBasedOnStyle:boldParagrapStyle];
    blueBoldParagraphStyle.color = [UIColor blueColor];
    
    // Add our paragraph styles to the text view
    [textView addParagraphStyle:americanParagrapStyle];
    [textView addParagraphStyle:boldParagrapStyle];
    [textView addParagraphStyle:blueBoldParagraphStyle];
    
    // Add text view to our scroll view
    [scrollView addSubview:textView];
    scrollView.contentSize = textView.frame.size;
}

- (NSString *)theText
{
    // This is the text we want to display. It has tags similar to HTML used by the paragraph styles to know where to apply themselfs.
    return @"<text>The Macintosh operating system has provided sophisticated text handling and typesetting capabilities from its beginning. In fact, these features sparked the desktop publishing revolution. <bold>Core Text</bold> is the most modern text-handling technology on the platform. It is designed specifically for OS X and is written in C, so it can be called from any language in the system. It is positioned as a core technology to provide consistent, high-performance text services to other frameworks throughout the system, and the Core Text API is accessible to applications that need to use it directly. Core Text resides in the Application Services umbrella framework (ApplicationServices) so that it is callable from both Carbon and Cocoa and has all of the lower-level services it needs. <bold>Core Text</bold> is not meant to replace the Cocoa text system, although it provides the underlying implementation for many <bold>Cocoa</bold> text technologies. If you can deal with high-level constructs, such as text views, you can probably use Cocoa. For this reason, Cocoa developers typically have no need to use Core Text directly. <blue>Carbon developers,</blue> on the other hand, will find <bold>Core Text</bold> faster and easier to use, in many cases, than preexisting OS X text layout and font APIs.</text>";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

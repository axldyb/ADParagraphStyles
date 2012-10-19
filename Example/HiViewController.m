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
    
    ADParagraphStyle *boldParagrapStyle = [[ADParagraphStyle alloc] initWithStartTag:@"<text>"
                                                                              endTag:@"</text>"
                                                                                font:[UIFont fontWithName:@"ArialMT" size:12.0f]
                                                                               color:[UIColor redColor]
                                                                       lineBreakMode:kCTLineBreakByWordWrapping
                                                                       textAlignment:kCTTextAlignmentCenter
                                                                         lineSpacing:1.0];
    
    ADAttributedTextView *textView = [[ADAttributedTextView alloc] initWithFrame:[[UIScreen mainScreen] bounds] andText:[self theText]];
    [textView addParagraphStyle:boldParagrapStyle];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
}

- (NSString *)theText
{
    return @"<text>The Macintosh operating system has provided sophisticated text handling and typesetting capabilities from its beginning. In fact, these features sparked the desktop publishing revolution. Core Text is the most modern text-handling technology on the platform. It is designed specifically for OS X and is written in C, so it can be called from any language in the system. It is positioned as a core technology to provide consistent, high-performance text services to other frameworks throughout the system, and the Core Text API is accessible to applications that need to use it directly. Core Text resides in the Application Services umbrella framework (ApplicationServices) so that it is callable from both Carbon and Cocoa and has all of the lower-level services it needs. Core Text is not meant to replace the Cocoa text system, although it provides the underlying implementation for many Cocoa text technologies. If you can deal with high-level constructs, such as text views, you can probably use Cocoa. For this reason, Cocoa developers typically have no need to use Core Text directly. Carbon developers, on the other hand, will find Core Text faster and easier to use, in many cases, than preexisting OS X text layout and font APIs.</text>";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

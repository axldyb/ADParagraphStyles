//
//  ADTextViewDelegate.h
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/30/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADTextView;

@protocol ADTextViewDelegate <NSObject>

@required
- (void)textView:(ADTextView *)textView didUpdateSize:(CGSize)size;

@end

//
//  ADAttributedString.h
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADParagraphStyle.h"

@interface ADAttributedTextView : UIView

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSMutableArray *paragraphStyles;

- (id)initWithFrame:(CGRect)frame andText:(NSString *)text; // And paragraphstyles maybe?

- (void)addParagraphStyle:(ADParagraphStyle *)paragraphStyle;

@end

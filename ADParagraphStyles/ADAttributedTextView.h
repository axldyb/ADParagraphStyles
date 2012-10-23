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

@property (nonatomic, assign) CGFloat padding;

/**
 After text is drawn this property contains the size of the drawn text view
 */
@property (nonatomic, assign) CGSize actualSize;

- (id)initWithFrame:(CGRect)frame text:(NSString *)text; // And paragraphstyles maybe?

- (id)initWithFrame:(CGRect)frame text:(NSString *)text padding:(CGFloat)padding;

- (void)addParagraphStyle:(ADParagraphStyle *)paragraphStyle;

@end

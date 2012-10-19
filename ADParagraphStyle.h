//
//  ADParagraphStyle.h
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADParagraphStyle : NSObject

@property (nonatomic, strong) NSString *startTag;

@property (nonatomic, strong) NSString *endTag;

// Font
@property (nonatomic, strong) UIFont *font;

// Coloring
@property (nonatomic, strong) UIColor *color;

//Formatting
@property (nonatomic, assign) CTLineBreakMode   lineBreakMode;
@property (nonatomic, assign) CTTextAlignment   textAlignment;
@property (nonatomic, assign) CGFloat           lineSpacing;
//@property (nonatomic, assign) CGFloat           firstLineHeadIndent;

- (id)initWithStartTag:(NSString *)startTag
                endTag:(NSString *)endTag
                  font:(UIFont *)font
                 color:(UIColor *)color
         lineBreakMode:(CTLineBreakMode)lineBrakMode
         textAlignment:(CTTextAlignment)textAlignment
           lineSpacing:(CGFloat)lineSpacing;

@end

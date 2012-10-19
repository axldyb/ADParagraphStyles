//
//  ADAttributedString.m
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/19/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "ADAttributedTextView.h"

@implementation ADAttributedTextView

- (id)initWithFrame:(CGRect)frame andText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        self.text = text;
    }
    return self;
}

#pragma mark - Add Paragraph Style

- (void)addParagraphStyle:(ADParagraphStyle *)paragraphStyle
{
    [self.paragraphStyles addObject:paragraphStyle];
}


#pragma mark - Create Styled Text

- (CFAttributedStringRef)createStyledText
{
    // Initialize an attributed string.
    CFStringRef string = (__bridge CFStringRef)self.text;
    CFMutableAttributedStringRef styledString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (styledString, CFRangeMake(0, 0), string);
    
    // Add styles
    for (ADParagraphStyle *paragraphStyle in self.paragraphStyles)
    {
        // Calculate range for style
        CFRange paragraphRange = [self calculateRangeForParagraphStyle:paragraphStyle];
        
        // Add parameters
        CTTextAlignment paragraphAlignment = paragraphStyle.textAlignment;
        CGFloat lineSpacing = paragraphStyle.lineSpacing;
        
        // Convert to CTParagraphStyleSetting
        CTParagraphStyleSetting paragraphSettings[2] =
        {
            {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &paragraphAlignment},
            {kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpacing}
        };
        
        // Add Styles to string
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 2);
        CFAttributedStringSetAttribute(styledString, paragraphRange, kCTParagraphStyleAttributeName, paragraphStyle);
        
#warning Remove tags from text here
    }
    
    return (CFAttributedStringRef)styledString; // Does it work?
}


#pragma mark - Calculate Paragraph Style Range

- (CFRange)calculateRangeForParagraphStyle:(ADParagraphStyle *)paragraphStyle
{
    NSInteger startTag = [self.text rangeOfString:paragraphStyle.startTag].location;
    NSInteger endTag = [self.text rangeOfString:paragraphStyle.endTag].location;
    
    if (startTag == NSNotFound || endTag == NSNotFound)
    {
        NSLog(@"ERROR: Tags not proppely set");
    } else {
        NSRange range = [self.text rangeOfString:paragraphStyle.startTag];
        NSString *substring = [[self.text substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSLog(@"Paragraph style set to text: %@", substring);
    }
    return CFRangeMake(startTag, endTag);
}


#pragma mark - Draw Rect

-(void)drawRect:(CGRect)rect
{
    // Create Context
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    // Initialize a rectangular path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.frame);
    
    // Create the framesetter with the attributed string.
    CFAttributedStringRef attributedString = [self createStyledText];
    NSLog(@"%@", attributedString);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedString);
    CFRelease(attributedString);
    
    // Flip coordinates
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Create the frame and draw it into the graphics context
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(framesetter);
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CGPathRelease(path);
    
    // End context
    UIImage *textImage = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"%@", NSStringFromCGSize(textImage.size));
    
    UIImageView *image = [[UIImageView alloc] initWithImage:textImage];
    [self addSubview:image];
    
    UIGraphicsEndImageContext();
}

@end

//
//  ADTextView.m
//  ADParagraphStyles
//
//  Created by Aksel Dybdal on 10/30/12.
//  Copyright (c) 2012 ustwo. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "ADTextView.h"

@implementation ADTextView

- (id)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.rawText = text;
        self.frame = frame;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text padding:(CGFloat)padding
{
    self = [self initWithFrame:frame text:text];
    if (self)
    {
        self.padding = padding;
    }
    return self;
}


#pragma mark - Add Paragraph Style

- (void)addParagraphStyle:(ADParagraphStyle *)paragraphStyle
{
    if (!self.paragraphStyles)
    {
        self.paragraphStyles = [[NSMutableArray alloc] init];
    }
    
    [self.paragraphStyles addObject:paragraphStyle];
}


#pragma mark - Create Styled Text

- (NSAttributedString *)attributedString
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.rawText];
    
    // Add styles
    for (ADParagraphStyle *paragraphStyle in self.paragraphStyles)
    {
        // Repeats for each occurence
        NSInteger numberOfOccurrences = [self calculateNumberOfOccurrencesOfParagraphStyle:paragraphStyle];
        for (int i = 0; i < numberOfOccurrences; i++)
        {
            
            // Calculate range for style
            NSRange paragraphRange = [self calculateRangeForParagraphStyle:paragraphStyle];
            //NSLog(@"%i, %i", paragraphRange.location, paragraphRange.length);
            
            // Add styles to string
            [attributedString addAttributes:paragraphStyle.attributes range:paragraphRange];
            
            NSRange startTagRange = [self calculateDeleteRangeForTag:paragraphStyle.startTag];
            [attributedString deleteCharactersInRange:startTagRange];
            self.rawText = [self.rawText stringByReplacingCharactersInRange:startTagRange withString:@""];
            
            NSRange endTagRange = [self calculateDeleteRangeForTag:paragraphStyle.endTag];
            [attributedString deleteCharactersInRange:endTagRange];
            self.rawText = [self.rawText stringByReplacingCharactersInRange:endTagRange withString:@""];
        }
    }
    return attributedString;
}


#pragma mark - Calculate Paragraph Style Range

- (NSRange)calculateRangeForParagraphStyle:(ADParagraphStyle *)paragraphStyle
{
    NSRange startTagRange = [self.rawText rangeOfString:paragraphStyle.startTag];
    NSInteger startTag = startTagRange.location + startTagRange.length;
    
    NSRange endTagRange = [self.rawText rangeOfString:paragraphStyle.endTag];
    NSInteger endTag = endTagRange.location - startTagRange.location - endTagRange.length + 1;
    
    if (startTag == NSNotFound || endTag == NSNotFound)
    {
        NSLog(@"ERROR: Tags not proppely set (%@ and %@)", paragraphStyle.startTag, paragraphStyle.endTag);
    }
    else
    {
        //NSRange range = NSMakeRange(startTag + startTagRange.length, endTag - endTagRange.length + 1);
        //NSRange range = NSMakeRange(startTag, endTag);
        //NSLog(@"Paragraph style with tag: %@,  set to text: %@", paragraphStyle.startTag, [self.rawText substringWithRange:range]);
    }
    
    NSRange finishedRange = NSMakeRange(startTag, endTag);
    return finishedRange;
}

- (NSRange)calculateDeleteRangeForTag:(NSString *)tag
{
    NSRange startTagRange = [self.rawText rangeOfString:tag];
    
    if (startTagRange.length == 0)
    {
        NSLog(@"ERROR: Tags not found %@", tag);
    }
    else
    {
        //NSLog(@"Range for tag: %@,  is: %@", tag, NSStringFromRange(startTagRange));
    }
    return startTagRange;
}


#pragma mark - Occurences of Style

- (NSInteger)calculateNumberOfOccurrencesOfParagraphStyle:(ADParagraphStyle *)paragraphStyle
{
    NSUInteger count = 0;
    NSUInteger length = [self.rawText length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [self.rawText  rangeOfString:paragraphStyle.startTag options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    return count;
}


#pragma mark - Remove Tags for Paragraph Style

- (void)removeTagsForParagraphStyle:(ADParagraphStyle *)paragraphStyle inText:(NSMutableAttributedString *)text
{
    // Remove start tag from text
    NSRange startTagRange = [self calculateDeleteRangeForTag:paragraphStyle.startTag];
    [text deleteCharactersInRange:startTagRange];
    self.rawText = [self.rawText stringByReplacingCharactersInRange:startTagRange withString:@""];
    
    // Remove end tag from text
    NSRange endTagRange = [self calculateDeleteRangeForTag:paragraphStyle.endTag];
    [text deleteCharactersInRange:endTagRange];
    self.rawText = [self.rawText stringByReplacingCharactersInRange:endTagRange withString:@""];
}


#pragma mark - Draw Rect

-(void)drawRect:(CGRect)rect
{
    // The string we want to draw
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)[self attributedString];
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedString);
    //CFRelease(attributedString);
    
    // Set up frame
    CGRect drawingFrame;
    drawingFrame.origin.x = self.padding;
    drawingFrame.origin.y = self.padding;
    drawingFrame.size.width = self.frame.size.width - (self.padding * 2);
    drawingFrame.size.height = 0.0f;
    drawingFrame.size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, drawingFrame.size, nil);
    
    // Set calculated size
    self.actualSize = drawingFrame.size;
    
    // Create Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Initialize a rectangular path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingFrame);
    
    // Flip coordinates
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, drawingFrame.size.height + (self.padding * 2));
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Create the frame and draw it into the graphics context
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(frame, context);
    
    CFRelease(framesetter);
    CFRelease(path);
    CFRelease(frame);
    
    UIGraphicsEndImageContext();
    
    if ([self.delegate respondsToSelector:@selector(textView:didUpdateSize:)])
    {
        CGSize contentSize;
        contentSize.width = self.actualSize.width;
        contentSize.height = self.actualSize.height + (self.padding * 4);
        
        [self.delegate textView:self didUpdateSize:contentSize];
    }
}

@end

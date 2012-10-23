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

- (id)initWithFrame:(CGRect)frame text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.text = text;
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

- (CFAttributedStringRef)createStyledText
{
    // Initialize an attributed string.
    CFStringRef string = (__bridge CFStringRef)self.text;
    CFMutableAttributedStringRef styledString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (styledString, CFRangeMake(0, 0), string);
    
    // Add styles
    for (ADParagraphStyle *paragraphStyle in self.paragraphStyles)
    {
        // Repeats for each occurence
        NSInteger numberOfOccurrences = [self calculateNumberOfOccurrencesOfParagraphStyle:paragraphStyle];
        for (int i = 0; i < numberOfOccurrences; i++)
        {
            
            // Calculate range for style
            CFRange paragraphRange = [self calculateRangeForParagraphStyle:paragraphStyle];
            
            // Addig color
            UIColor *color = paragraphStyle.color;
            CFAttributedStringSetAttribute(styledString, paragraphRange, kCTForegroundColorAttributeName, color.CGColor);
            
            // Adding font
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)paragraphStyle.fontName, paragraphStyle.fontSize, NULL);
            CFAttributedStringSetAttribute(styledString, paragraphRange, kCTFontAttributeName, font);
            
            // Add parameters
            CTTextAlignment paragraphAlignment = paragraphStyle.textAlignment;
            CGFloat lineSpacing = paragraphStyle.lineSpacing;
            CGFloat firstLineIndent = paragraphStyle.firstLineIndent;
            
            // Convert to CTParagraphStyleSetting
            CTParagraphStyleSetting paragraphSettings[3] =
            {
                {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &paragraphAlignment},
                {kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &firstLineIndent},
                {kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpacing}
            };
            
            // Add Styles to string
            CTParagraphStyleRef paragraphStyleRef = CTParagraphStyleCreate(paragraphSettings, 3);
            CFAttributedStringSetAttribute(styledString, paragraphRange, kCTParagraphStyleAttributeName, paragraphStyleRef);
            
            styledString = [self removeParagraphTags:paragraphStyle fromAttributedString:styledString];
        }
    }
    return (CFAttributedStringRef)styledString;
}


#pragma mark - Calculate Paragraph Style Range

- (CFRange)calculateRangeForParagraphStyle:(ADParagraphStyle *)paragraphStyle
{   
    NSRange startTagRange = [self.text rangeOfString:paragraphStyle.startTag];
    NSInteger startTag = startTagRange.location;
    
    NSRange endTagRange = [self.text rangeOfString:paragraphStyle.endTag];
    NSInteger endTag = endTagRange.location - startTagRange.location;
    
    if (startTag == NSNotFound || endTag == NSNotFound)
    {
        NSLog(@"ERROR: Tags not proppely set (%@ and %@)", paragraphStyle.startTag, paragraphStyle.endTag);
    }
    else
    {
        NSRange range = NSMakeRange(startTag + startTagRange.length, endTag - endTagRange.length + 1);
        NSLog(@"Paragraph style set to text: %@", [self.text substringWithRange:range]);
    }
    
    CFRange finishedRange = CFRangeMake(startTag, endTag);
    return finishedRange;
}

- (NSInteger)calculateNumberOfOccurrencesOfParagraphStyle:(ADParagraphStyle *)paragraphStyle
{
    NSUInteger count = 0;
    NSUInteger length = [self.text length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [self.text  rangeOfString:paragraphStyle.startTag options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++; 
        }
    }
    return count;
}


#pragma mark - Remove tags from displaying text

- (CFMutableAttributedStringRef)removeParagraphTags:(ADParagraphStyle *)paragraphStyle fromAttributedString:(CFMutableAttributedStringRef)string
{
    NSRange startTagRange = [self.text rangeOfString:paragraphStyle.startTag];
    NSString *replacementStartString = @"";
    CFStringRef replacementStartFormattedString = (__bridge CFStringRef)replacementStartString;
    CFAttributedStringReplaceString (string, CFRangeMake(startTagRange.location, startTagRange.length), replacementStartFormattedString);
    
    NSRange endTagRange = [self.text rangeOfString:paragraphStyle.endTag];
    NSString *replacementEndString = @"";
    CFStringRef replacementEndFormattedString = (__bridge CFStringRef)replacementEndString;
    CFAttributedStringReplaceString (string, CFRangeMake(endTagRange.location - endTagRange.length + 1, endTagRange.length), replacementEndFormattedString);
    
    int startTagLocation = startTagRange.location;
    int startTagLenght = startTagRange.length;
    self.text = [self.text stringByReplacingCharactersInRange:NSMakeRange(startTagLocation, startTagLenght) withString:@""];
    
    int endTagLocation = endTagRange.location;
    int endTagLenght = endTagRange.length;
    self.text = [self.text stringByReplacingCharactersInRange:NSMakeRange(endTagLocation - endTagLenght, endTagLenght) withString:@""];
    
    return string;
}


#pragma mark - Draw Rect

-(void)drawRect:(CGRect)rect
{
    // The string we want to draw
    CFAttributedStringRef attributedString = [self createStyledText];
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attributedString);
    CFRelease(attributedString);
    
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
    CFRelease(framesetter);
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CGPathRelease(path);
    
    UIGraphicsEndImageContext();
}

@end
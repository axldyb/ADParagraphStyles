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
            CFRange paragraphRange = [self calculateCFRangeForParagraphStyle:paragraphStyle];
            
            // Addig color
            UIColor *color = paragraphStyle.color;
            CFAttributedStringSetAttribute(styledString, paragraphRange, kCTForegroundColorAttributeName, color.CGColor);
            
            // Adding font
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)paragraphStyle.fontName, paragraphStyle.fontSize, NULL);
            CFAttributedStringSetAttribute(styledString, paragraphRange, kCTFontAttributeName, font);
            
            // Adding kerning if it is set
            if (paragraphStyle.kerning != kADParagraphStylesFontHandleKerning)
            {
                NSNumber *kerning = [NSNumber numberWithFloat:paragraphStyle.kerning];
                CFAttributedStringSetAttribute(styledString, paragraphRange, kCTKernAttributeName, (__bridge CFTypeRef)(kerning));
            }
            
            // Glyphs
            NSNumber *glyphs = [NSNumber numberWithFloat:paragraphStyle.glyphs];
            CFAttributedStringSetAttribute(styledString, paragraphRange, kCTCharacterShapeAttributeName, (__bridge CFTypeRef)(glyphs));
            
            // Add parameters
            CTTextAlignment paragraphAlignment = paragraphStyle.textAlignment;
            CTLineBreakMode lineBreakMode = paragraphStyle.lineBreakMode;
            CGFloat lineSpacing = paragraphStyle.lineSpacing;
            CGFloat firstLineIndent = paragraphStyle.firstLineIndent;
            CGFloat headIndent = paragraphStyle.headIndent;
            CGFloat tailIndent = paragraphStyle.tailIndent;
            CGFloat spacing = paragraphStyle.spacing;
            CGFloat spacingBefore = paragraphStyle.spacingBefore;
            
            // Convert to CTParagraphStyleSetting
            CTParagraphStyleSetting paragraphSettings[8] =
            {
                {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &paragraphAlignment},
                {kCTParagraphStyleSpecifierLineBreakMode, sizeof(CTLineBreakMode), &lineBreakMode},
                {kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), &firstLineIndent},
                {kCTParagraphStyleSpecifierHeadIndent, sizeof(CGFloat), &headIndent},
                {kCTParagraphStyleSpecifierTailIndent, sizeof(CGFloat), &tailIndent},
                {kCTParagraphStyleSpecifierLineSpacing, sizeof(CGFloat), &lineSpacing},
                {kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &spacing},
                {kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &spacingBefore}
            };
            
            // Add Styles to string
            CTParagraphStyleRef paragraphStyleRef = CTParagraphStyleCreate(paragraphSettings, 8);
            CFAttributedStringSetAttribute(styledString, paragraphRange, kCTParagraphStyleAttributeName, paragraphStyleRef);
            
            styledString = [self removeParagraphTags:paragraphStyle fromAttributedString:styledString];
        }
    }
    return (CFAttributedStringRef)styledString;
}


#pragma mark - Calculate Paragraph Style Range

- (CFRange)calculateCFRangeForParagraphStyle:(ADParagraphStyle *)paragraphStyle
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
    //CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)[self attributedString];
    
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
    CFRelease(framesetter);
    CGPathRelease(path);
    CTFrameDraw(frame, context);
    CFRelease(frame);
    
    /*
    CFArrayRef lineArrayRef = CTFrameGetLines(frame);
    NSArray *lineArray = CFBridgingRelease(lineArrayRef);
    
    NSLog(@"%i", lineArray.count);
    
    for (int i = 0; i < lineArray.count; i++)
    {
        CTLineRef line = (__bridge CTLineRef)[lineArray objectAtIndex:i];
        NSAttributedString *attributedLine = (__bridge NSAttributedString *)line;
        
        //handle text hyphenation
        CFRange lineStringRange = CTLineGetStringRange(line);
        NSRange lineRange = NSMakeRange(lineStringRange.location, lineStringRange.length);
        NSString* lineString = [self.text substringWithRange:lineRange];
        static const unichar softHypen = 0x00AD;
        unichar lastChar = [self.text characterAtIndex:lineRange.location + lineRange.length-1];
        NSLog(@"%@ -> %i, Last: %hu", lineString, lineRange.length, lastChar);
        
        if(softHypen == lastChar) {
            NSMutableAttributedString* lineAttrString = [[attributedLine attributedSubstringFromRange:lineRange] mutableCopy];
            NSRange replaceRange = NSMakeRange(lineRange.length-1, 1);
            [lineAttrString replaceCharactersInRange:replaceRange withString:@"-"];
            
            CTLineRef hyphenLine = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)lineAttrString);
            CTLineRef justifiedLine = CTLineCreateJustifiedLine(hyphenLine, 1.0, drawingFrame.size.width);
            
            
            CTLineDraw(justifiedLine, context);
        } else {
            
            CGContextSetTextPosition(context, drawingFrame.origin.x, drawingFrame.origin.y * i);
            CTLineDraw(line, context);
        }
    }*/
    
    UIGraphicsEndImageContext();
}

@end
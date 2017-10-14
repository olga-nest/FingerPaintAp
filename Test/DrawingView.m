//
//  DrawingView.m
//  FingerPaintApp
//
//  Created by Olga on 10/13/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "DrawingView.h"
#import "LineData.h"

@interface DrawingView()

@property (nonatomic) NSMutableArray<LineData *> *line;

@end

@implementation DrawingView


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _line = [NSMutableArray new];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //Get the location of the first touch
    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];

    //Init with same start and end point, since this is starting point and there's no previous point
    LineData *segment = [[LineData alloc]initWithFirstPoint:first secondPoint:first];
    //Add to the array of the line
    [self.line addObject:segment];

    //redraw
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //get the to touch points: previous(first) and current(next)
    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];
    CGPoint next = [touch locationInView:self];

    LineData *segment = [[LineData alloc]initWithFirstPoint:first secondPoint:next];
    [self.line addObject:segment];

    [self setNeedsDisplay];

}

// Override drawRect (reason - custom drawing)
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    UIColor *gray = [UIColor grayColor];
    [gray setStroke];

    // Loop through all elements in the segment array and draw each line
    for (LineData *segment in self.line) {
        if (CGPointEqualToPoint(segment.firstPoint, segment.secondPoint)) {
            // If start/end point of line segment is the same (i.e. this is the first
            // point, then move to that point so that line is drawn starting from that
            // point
            [path moveToPoint:segment.firstPoint];
            continue;
        }
        // Draw a line from the previous line segment to the first point
        [path addLineToPoint:segment.firstPoint];
        // Draw a line from the first point to the second point
        [path addLineToPoint:segment.secondPoint];
    }
    [path stroke];

}

- (IBAction)clear {
    [self.line removeAllObjects];
    [self setNeedsDisplay];
}


@end

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

@property (nonatomic) NSMutableArray<LineData *> *whiteLine;
@property (nonatomic) NSMutableArray<LineData *> *purpleLine;
@property (nonatomic) NSMutableArray<LineData *> *orangeLine;
@property (nonatomic, weak) UIColor *color;

@end

@implementation DrawingView


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _whiteLine = [NSMutableArray new];
        _purpleLine = [NSMutableArray new];
        _orangeLine = [NSMutableArray new];
        _color = [UIColor whiteColor];
    }
    return self;
}

- (IBAction)changeStrokeColor:(UIButton *)sender {
    if (sender.tag == 0) {
        self.color = [UIColor purpleColor];
        if (sender.tag == 1) {
            self.color = [UIColor orangeColor];
        } else {
            self.color = [UIColor whiteColor];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //Get the location of the first touch
    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];

    
    //Init with same start and end point, since this is starting point and there's no previous point
    LineData *segment = [[LineData alloc]initWithFirstPoint:first secondPoint:first];
    //Add to the array of the line
    
    if (self.color == [UIColor whiteColor]) {
        [self.whiteLine addObject:segment];
    } else if (self.color == [UIColor orangeColor]) {
        [self.orangeLine addObject:segment];
    } else if (self.color == [UIColor purpleColor]){
        [self.purpleLine addObject:segment];
    } else {
        NSLog(@"Oops, s]omethong went wrong... Cannot add a stroke to correct array");
    }
    
    //redraw
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //get the to touch points: previous(first) and current(next)
    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];
    CGPoint next = [touch locationInView:self];

    LineData *segment = [[LineData alloc]initWithFirstPoint:first secondPoint:next];
   
    if (self.color == [UIColor whiteColor]) {
        [self.whiteLine addObject:segment];
    } else if (self.color == [UIColor orangeColor]) {
        [self.orangeLine addObject:segment];
    } else if (self.color == [UIColor purpleColor]){
        [self.purpleLine addObject:segment];
    } else {
        NSLog(@"Oops, s]omethong went wrong... Cannot add a stroke to correct array");
    }
    
    [self setNeedsDisplay];

}

// Override drawRect (reason - custom drawing)
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
//    UIColor *gray = [UIColor grayColor];
 //   [self.color setStroke];
    [self.color setStroke];

    // Loop through all elements in the segment array and draw each line
    for (LineData *segment in self.whiteLine) {
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
    [self.whiteLine removeAllObjects];
    [self setNeedsDisplay];
}



@end

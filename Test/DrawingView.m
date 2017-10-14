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
    NSLog(@"Checking button color via tag");
    if (sender.tag == 1) {
        NSLog(@"Setting self.color to purple");
        self.color = [UIColor purpleColor];
        if (sender.tag == 2) {
            NSLog(@"Setting self.color to orange");
            self.color = [UIColor orangeColor];
        } else if (sender.tag == 3) {
            NSLog(@"Setting self.color to white");
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
        NSLog(@"TouchBegan: Adding a segment to the white array");
        [self.whiteLine addObject:segment];
    } else if (self.color == [UIColor orangeColor]) {
        NSLog(@"TouchBegan: Adding a segment to the orange array");
        [self.orangeLine addObject:segment];
    } else if (self.color == [UIColor purpleColor]){
        NSLog(@"TouchBegan: Adding a segment to the purple array");
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
        NSLog(@"TouchMoved: Adding a segment to the white array");
        [self.whiteLine addObject:segment];
    } else if (self.color == [UIColor orangeColor]) {
        NSLog(@"TouchMoved: Adding a segment to the orange array");
        [self.orangeLine addObject:segment];
    } else if (self.color == [UIColor purpleColor]){
        NSLog(@"TouchMoved: Adding a segment to the purple array");
        [self.purpleLine addObject:segment];
    } else {
        NSLog(@"Oops, s]omethong went wrong... Cannot add a stroke to correct array");
    }
    
    [self setNeedsDisplay];

}

// Override drawRect (reason - custom drawing)
- (void)drawRect:(CGRect)rect {
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    path.lineWidth = 5.0;
//    path.lineCapStyle = kCGLineCapRound;
//    [self.color setStroke];

    if (self.color == [UIColor whiteColor]) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 5.0;
        path.lineCapStyle = kCGLineCapRound;
        
        [[UIColor whiteColor] setStroke];
        for (LineData *segment in self.whiteLine) {
            if (CGPointEqualToPoint(segment.firstPoint, segment.secondPoint)) {
                [path moveToPoint:segment.firstPoint];
                continue;
            }
            [path addLineToPoint:segment.firstPoint];
            [path addLineToPoint:segment.secondPoint];
        }
        [path stroke];
    } else if (self.color == [UIColor orangeColor]) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 5.0;
        path.lineCapStyle = kCGLineCapRound;
        
        [[UIColor orangeColor] setStroke];
        for (LineData *segment in self.orangeLine) {
            if (CGPointEqualToPoint(segment.firstPoint, segment.secondPoint)) {
                [path moveToPoint:segment.firstPoint];
                continue;
            }
            [path addLineToPoint:segment.firstPoint];
            [path addLineToPoint:segment.secondPoint];
        }
        [path stroke];
    } else if (self.color == [UIColor purpleColor]) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 5.0;
        path.lineCapStyle = kCGLineCapRound;
        
        [[UIColor purpleColor] setStroke];
        for (LineData *segment in self.purpleLine) {
            if (CGPointEqualToPoint(segment.firstPoint, segment.secondPoint)) {
                [path moveToPoint:segment.firstPoint];
                continue;
            }
            [path addLineToPoint:segment.firstPoint];
            [path addLineToPoint:segment.secondPoint];
            
        }
        [path stroke];
    }
    
}

- (IBAction)clear {
    [self.whiteLine removeAllObjects];
    [self.purpleLine removeAllObjects];
    [self.orangeLine removeAllObjects];
    [self setNeedsDisplay];
}



@end

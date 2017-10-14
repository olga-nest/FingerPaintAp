//
//  LineData.m
//  FingerPaintApp
//
//  Created by Olga on 10/13/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import "LineData.h"

@implementation LineData



- (instancetype)initWithFirstPoint:(CGPoint)first
                       secondPoint:(CGPoint)second
{
    if (self = [super init]) {
        _firstPoint = first;
        _secondPoint = second;
    }
    return self;
}

@end

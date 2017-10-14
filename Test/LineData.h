//
//  LineData.h
//  FingerPaintApp
//
//  Created by Olga on 10/13/17.
//  Copyright © 2017 Olga Nesterova. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@interface LineData : NSObject

@property (nonatomic, readonly) CGPoint firstPoint;
@property (nonatomic, readonly) CGPoint secondPoint;

- (instancetype)initWithFirstPoint:(CGPoint)first
                       secondPoint:(CGPoint)second;

@end

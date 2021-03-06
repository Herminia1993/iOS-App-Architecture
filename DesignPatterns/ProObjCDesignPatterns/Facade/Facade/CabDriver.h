//
//  CabDriver.h
//  Facade
//
//  Created by Carlo Chung on 11/15/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Car.h"
#import "Taximeter.h"

@interface CabDriver : NSObject

- (void)driveToLocation:(CGPoint)x withCompletion:(void(^)(float price))completion;

@end

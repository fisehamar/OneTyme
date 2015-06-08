//
//  BackgroundLayer.h
//  BrokerTestApp
//
//  Created by  on 2/02/12.
//  Copyright (c) 2012 AFG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface BackgroundLayer : NSObject

+(CAGradientLayer*) greyGradient;
+(CAGradientLayer*) blueGradient;
+(CAGradientLayer*) redGradient;

@end

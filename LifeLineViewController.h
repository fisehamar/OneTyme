//
//  LifeLineViewController.h
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LIFELINE_OBJECTS_KEY @"Lifeline Objects Key"

@protocol LifeLineViewControllerDelegate <NSObject>

-(void)didUpdateLifeLine;

@end

@interface LifeLineViewController : UIViewController

@property (weak, nonatomic) id <LifeLineViewControllerDelegate> delegate;
- (IBAction)addLifeline:(id)sender;
@end

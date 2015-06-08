//
//  ViewController.h
//  OneTyme
//
//  Created by Joffrey Mann on 1/27/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *attorneyString;
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic, strong) UILabel *alertLabel;
@property (nonatomic,readwrite) int currentCount;
@property (nonatomic, retain) NSTimer *timerAlert;

@end


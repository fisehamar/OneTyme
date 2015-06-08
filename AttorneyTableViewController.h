//
//  AttorneyTableViewController.h
//  OneTyme
//
//  Created by Joffrey Mann on 3/1/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@protocol AttorneyTableViewControllerDelegate <NSObject>

-(IBAction)addSearchLocation:(id)sender;
-(IBAction)addSearchName:(id)sender;
-(IBAction)addSearchZip:(id)sender;

@end

@interface AttorneyTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *paidAttorneys;
@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSString *searchQuery;
@property (strong, nonatomic) NSString *preQuery;
@property (assign, nonatomic) BOOL zipClicked;
@property (assign, nonatomic) BOOL nameClicked;
@property (assign, nonatomic) BOOL locationClicked;
@property (weak, nonatomic) id <AttorneyTableViewControllerDelegate> delegate;

@end

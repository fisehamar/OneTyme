//
//  BailBondsTableViewController.h
//  OneTyme
//
//  Created by Joffrey Mann on 3/1/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@protocol BailBondsTableViewControllerDelegate <NSObject>

-(IBAction)addSearchLocation:(id)sender;
-(IBAction)addSearchName:(id)sender;
-(IBAction)addSearchZip:(id)sender;

@end

@interface BailBondsTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *paidBondsmen;
@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSString *searchQuery;
@property (strong, nonatomic) NSString *preQuery;
@property (weak, nonatomic) id <BailBondsTableViewControllerDelegate> delegate;

@end

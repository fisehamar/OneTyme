//
//  LifeLineTableViewCell.h
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeLineTableViewCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *zipLabel;

@end

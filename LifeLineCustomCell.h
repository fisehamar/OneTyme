#import <UIKit/UIKit.h>

@interface LifeLineCustomCell : UITableViewCell
{
    
}


@property (nonatomic,retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *zipLabel;

@property (nonatomic,retain) IBOutlet UIButton *editButton;

@end

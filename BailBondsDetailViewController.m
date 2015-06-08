//
//  BailBondsDetailViewController.m
//  onetyme
//
//  Created by Joffrey Mann on 4/13/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "BailBondsDetailViewController.h"
#import "BackgroundLayer.h"

@interface BailBondsDetailViewController ()

@end

@implementation BailBondsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", _bondsmen[@"Name"]];
    self.addressLabel.text = [NSString stringWithFormat:@"Address: %@", _bondsmen[@"Address"]];
    self.cityLabel.text = [NSString stringWithFormat:@"City: %@", _bondsmen[@"City"]];
    self.stateLabel.text = [NSString stringWithFormat:@"State: %@", _bondsmen[@"State"]];
    self.zipLabel.text = [NSString stringWithFormat:@"Zip :%@", _bondsmen[@"Zip"]];
    self.phoneLabel.text = [NSString stringWithFormat:@"Phone: %@" ,_bondsmen[@"Phone"]];
    self.emailLabel.text = [NSString stringWithFormat:@"E-mail: %@", _bondsmen[@"Email"]];
    PFFile *picFile = _bondsmen[@"Logo"];
    NSData *imgData = [picFile getData];
    UIImage *profileImg = [UIImage imageWithData:imgData];
    UIImage *resizedProfileImg = [self resizeImage:profileImg];
    self.attorneyImgView.image = resizedProfileImg;
    self.navigationItem.title = _bondsmen[@"Name"];
    
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

-(UIImage *)resizeImage:(UIImage *)image
{
    CGRect rect = CGRectMake(0, 0, 100, 100);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *transformedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imgData = UIImagePNGRepresentation(transformedImage);
    UIImage *finalImage = [UIImage imageWithData:imgData];
    
    return finalImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

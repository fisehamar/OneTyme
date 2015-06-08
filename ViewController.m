//
//  ViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 1/27/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import "Attorney.h"
#import "BailBonds.h"
#import "LifeLine.h"
#import "AppDelegate.h"
#import "AttorneyViewController.h"
#import "BailBondsViewController.h"
#import "LifeLineViewController.h"
#import <Mailgun.h>
#import <TwilioClient.h>

@interface ViewController ()<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate,NSURLConnectionDelegate, NSURLSessionDelegate>

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSArray *attorneysAsPropertyLists;
@property (strong, nonatomic) NSArray *bailBondsAsPropertyLists;
@property (strong, nonatomic) NSArray *lifelineAsPropertyLists;

@end

@implementation ViewController
NSArray *toRecipients;
id <NSURLConnectionDelegate> delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *oneTymeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rsz_bghomenonretina.png"]];
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) oneTymeImage.frame = CGRectMake(0, 0, self.view.frame.size.width, 1107);
    else oneTymeImage.frame = CGRectMake(0, 0, self.view.frame.size.width, 1007);
    
    [self.view addSubview:oneTymeImage];
    UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) alertButton.frame = CGRectMake(127, 60, 200, 200);
    else alertButton.frame = CGRectMake(127, 77, 200, 200);
    [alertButton addTarget:self action:@selector(prepareToMail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertButton];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    CGRect tabBounds = CGRectMake(0, 0, self.view.frame.size.width, 44);
    self.tabBarController.tabBar.bounds = tabBounds;
    
    CALayer * bgGradientLayer = [self gradientBGLayerForBounds:tabBounds];
    UIGraphicsBeginImageContext(bgGradientLayer.bounds.size);
    [bgGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * bgAsImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (bgAsImage != nil)
    {
        [self.tabBarController.tabBar setBackgroundImage:bgAsImage];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) {
       shareButton.frame = CGRectMake(0, 620, self.view.frame.size.width/3, 69);
    }
    else {
        shareButton.frame = CGRectMake(0, self.view.frame.size.height-83, self.view.frame.size.width/3, 39);
    }
    [shareButton setBackgroundImage:[UIImage imageNamed:@"Share.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
    UIButton *addProfileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"])
    addProfileButton.frame = CGRectMake(138.5, 620, self.view.frame.size.width/3, 69);
    else addProfileButton.frame = CGRectMake(106.67, self.view.frame.size.height-83, self.view.frame.size.width/3, 39);
    [addProfileButton setBackgroundImage:[UIImage imageNamed:@"AddProfile.png"] forState:UIControlStateNormal];
    [addProfileButton addTarget:self action:@selector(goToProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addProfileButton];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"])
    infoButton.frame = CGRectMake(277, 620, self.view.frame.size.width/3, 69);
    else infoButton.frame = CGRectMake(213.33, self.view.frame.size.height-83, self.view.frame.size.width/3, 39);
    [infoButton setBackgroundImage:[UIImage imageNamed:@"Information.png"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(showAppInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    
    self.tabBarController.tabBar.opaque = NO;
    
    NSArray *items = self.tabBarController.tabBar.items;
    
    for (UITabBarItem *tbi in items) {
        UIImage *image = tbi.image;
        tbi.selectedImage = image;
        tbi.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    _attorneysAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ATTORNEY_OBJECTS_KEY];
    _bailBondsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:BAILBONDS_OBJECTS_KEY];
    _lifelineAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:LIFELINE_OBJECTS_KEY];
    
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _attorneyString = @"Joffrey";
    
}

-(void)drawAlertTimer
{
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.alertView =  [[UIView alloc]initWithFrame:CGRectMake(47, 435, 320, 130)];
    else self.alertView =  [[UIView alloc]initWithFrame:CGRectMake(0, 355, 320, 130)];
    UIImageView *alertImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AlertBG.png"]];
    [self.alertView addSubview:alertImgView];
    self.alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 28, 42, 21)];
    self.alertLabel.textColor = [UIColor whiteColor];
    UIButton *cancelAlertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelAlertButton.frame = CGRectMake(131, 73, 98, 31);
    [cancelAlertButton addTarget:self action:@selector(removeAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.alertView addSubview:cancelAlertButton];
    [self.alertView addSubview:self.alertLabel];
    [self.view addSubview:self.alertView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CALayer *)gradientBGLayerForBounds:(CGRect)bounds
{
    CAGradientLayer * gradientBG = [CAGradientLayer layer];
    gradientBG.frame = bounds;
    gradientBG.colors = [NSArray arrayWithObjects:
                         (id)[[UIColor colorWithRed:252.0f / 255.0f green:22.0f / 255.0f blue:22.0f / 255.0f alpha:1.0f] CGColor],
                         (id)[[UIColor colorWithRed:101.0f / 255.0f green:11.0f / 255.0f blue:11.0f / 255.0f alpha:1.0f] CGColor],
                         nil];
    return gradientBG;
}

-(void)prepareToMail
{
    [self drawAlertTimer];
    self.alertLabel.text = @"10";
    _currentCount = 9;
    _timerAlert = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(changeText) userInfo:nil repeats:YES];
}

-(void)sendMailgunEmail
{
    NSString *email;
    NSMutableDictionary *tempAttorney = [[NSUserDefaults standardUserDefaults] valueForKey:@"AttorneyProfile"];
    NSMutableDictionary *tempBonds = [[NSUserDefaults standardUserDefaults] valueForKey:@"BondsProfile"];
    NSMutableDictionary *tempUser = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserProfile"];
    NSDictionary *dictOne;
    NSDictionary *dictTwo;
    NSDictionary *dictThree;
    NSDictionary *dictFour;
    NSDictionary *dictFive;
    
    NSString *emailOne;
    NSString *emailTwo;
    NSString *emailThree;
    NSString *emailFour;
    NSString *emailFive;
    
    NSString *locationString = [NSString stringWithFormat:@"I am currently located at %@ %@, %@, %@, %@.", _appDelegate.placemark.subThoroughfare, _appDelegate.placemark.thoroughfare, _appDelegate.placemark.locality, _appDelegate.placemark.administrativeArea, _appDelegate.placemark.postalCode];
    NSString *emailBody = [NSString stringWithFormat:@"%@ %@", tempUser[@"message"], locationString];
    Mailgun *mailgun;
    NSString *formattedRecipients;
    NSArray *textRecipientArray;
    if(tempUser && tempAttorney && tempBonds && [_lifelineAsPropertyLists count] > 0) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You must add a message, attorney, bail bondsman, and at least one lifeline to send an alert." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alertView show];
    
    //for(int i = 0; i < [_lifelineAsPropertyLists count]; i++){
        
//        if([_lifelineAsPropertyLists count] == 0)
//        {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You must have entered at least one lifeline." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alertView show];
//        }
        
        if([_lifelineAsPropertyLists count] == 1)
        {
            dictOne = _lifelineAsPropertyLists[0];
            emailOne = dictOne[EMAIL];
            formattedRecipients = [NSString stringWithFormat:@"%@, %@, %@", [tempAttorney valueForKey:@"email"], [tempBonds valueForKey:@"email"], emailOne];
            textRecipientArray = @[[tempAttorney valueForKey:@"phone"], [tempBonds valueForKey:@"phone"], dictOne[PHONE_NO]];
        }
        
        else if([_lifelineAsPropertyLists count] == 2)
        {
            dictOne = _lifelineAsPropertyLists[0];
            emailOne = dictOne[EMAIL];
            dictTwo = _lifelineAsPropertyLists[1];
            emailTwo = dictTwo[EMAIL];
            formattedRecipients = [NSString stringWithFormat:@"%@, %@, %@, %@", [tempAttorney valueForKey:@"email"], [tempBonds valueForKey:@"email"], emailOne, emailTwo];
            textRecipientArray = @[[tempAttorney valueForKey:@"phone"], [tempBonds valueForKey:@"phone"], dictOne[PHONE_NO], dictTwo[PHONE_NO]];
        }
        
        else if([_lifelineAsPropertyLists count] == 3)
        {
            dictOne = _lifelineAsPropertyLists[0];
            emailOne = dictOne[EMAIL];
            dictTwo = _lifelineAsPropertyLists[1];
            emailTwo = dictTwo[EMAIL];
            dictThree = _lifelineAsPropertyLists[2];
            emailThree = dictThree[EMAIL];
            formattedRecipients = [NSString stringWithFormat:@"%@, %@, %@, %@, %@", [tempAttorney valueForKey:@"email"], [tempBonds valueForKey:@"email"], emailOne, emailTwo, emailThree];
            textRecipientArray = @[[tempAttorney valueForKey:@"phone"], [tempBonds valueForKey:@"phone"], dictOne[PHONE_NO], dictTwo[PHONE_NO], dictThree[PHONE_NO]];
        }
        
        else if([_lifelineAsPropertyLists count] == 4)
        {
            dictOne = _lifelineAsPropertyLists[0];
            emailOne = dictOne[EMAIL];
            dictTwo = _lifelineAsPropertyLists[1];
            emailTwo = dictTwo[EMAIL];
            dictThree = _lifelineAsPropertyLists[2];
            emailThree = dictThree[EMAIL];
            dictFour = _lifelineAsPropertyLists[3];
            emailFour = dictFour[EMAIL];
            formattedRecipients = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@", [tempAttorney valueForKey:@"email"], [tempBonds valueForKey:@"email"], emailOne, emailTwo, emailThree, emailFour];
            textRecipientArray = @[[tempAttorney valueForKey:@"phone"], [tempBonds valueForKey:@"phone"], dictOne[PHONE_NO], dictTwo[PHONE_NO], dictThree[PHONE_NO], dictFour[PHONE_NO]];
        }
        
        else if([_lifelineAsPropertyLists count] == 5)
        {
            dictOne = _lifelineAsPropertyLists[0];
            emailOne = dictOne[EMAIL];
            dictTwo = _lifelineAsPropertyLists[1];
            emailTwo = dictTwo[EMAIL];
            dictThree = _lifelineAsPropertyLists[2];
            emailThree = dictThree[EMAIL];
            dictFour = _lifelineAsPropertyLists[3];
            emailFour = dictFour[EMAIL];
            dictFive = _lifelineAsPropertyLists[4];
            emailFive = dictFive[EMAIL];
            formattedRecipients = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@", [tempAttorney valueForKey:@"email"], [tempBonds valueForKey:@"email"], emailOne, emailTwo, emailThree, emailFour, emailFive];
            textRecipientArray = @[[tempAttorney valueForKey:@"phone"], [tempBonds valueForKey:@"phone"], dictOne[PHONE_NO], dictTwo[PHONE_NO], dictThree[PHONE_NO], dictFour[PHONE_NO], dictFive[PHONE_NO]];
        }
        mailgun = [Mailgun clientWithDomain:@"sandbox56d3af57c3ae4227a46762cf7f67d726.mailgun.org" apiKey:@"key-a84fe8abec64b12d0ca050406a95b4c1"];
        [mailgun sendMessageTo:formattedRecipients
                          from:tempUser[@"email"]
                       subject:@"A Message from One Tyme"
                          body:emailBody];
        [self textAlertWithArray:textRecipientArray andText:emailBody];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You have sent a successful alert to your attorney, bail bondsman, and lifelines." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
    
    else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You must add a message, attorney, bail bondsman, and at least one lifeline to send an alert." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)changeText
{
    if(_currentCount == 0)
    {
        [self removeAlertView];
        [self sendMailgunEmail];
    }
    else
    {
        _alertLabel.text = [NSString stringWithFormat:@"%d",_currentCount];
        _currentCount = _currentCount - 1;
    }
}
- (void)removeAlertView
{
    [_timerAlert invalidate];
    _timerAlert = nil;
    
    [self.alertView removeFromSuperview];
    
}

-(void)shareOneTyme
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailerTwo = [[MFMailComposeViewController alloc] init];
        
        mailerTwo.mailComposeDelegate = self;
        
        [mailerTwo setSubject:@"Sharing OneTyme App"];
        [mailerTwo setMessageBody:@"Sharing OneTyme App:\nwww.onetyme.com" isHTML:NO];
        [self presentViewController:mailerTwo animated:YES completion:nil];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

-(void)failureAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                 message:@"Your device doesn't support the composer sheet"
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles: nil];
    [alert show];
}

-(void)successAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"Your email has been successfully sent."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            [self successAlert];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            [self failureAlert];
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(Attorney *)attorneyObjectForDictionary:(NSDictionary *)dictionary
{
    Attorney *attorneyObject = [[Attorney alloc] initWithAttorney:dictionary];
    return attorneyObject;
}

-(BailBonds *)bailBondsObjectForDictionary:(NSDictionary *)dictionary
{
    BailBonds *bailBondsObject = [[BailBonds alloc] initWithBailBonds:dictionary];
    return bailBondsObject;
}

-(LifeLine *)lifelineObjectForDictionary:(NSDictionary *)dictionary
{
    LifeLine *lifelineObject = [[LifeLine alloc] initWithLifeLine:dictionary];
    return lifelineObject;
}

-(void)goToProfile
{
    [self performSegueWithIdentifier:@"toProfile" sender:nil];
}

-(void)showAppInfo
{
    [self performSegueWithIdentifier:@"toInformation" sender:nil];
}

-(void)postToFacebook
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebookSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [self presentViewController:facebookSheet animated:YES completion:nil];
    }
    else if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        UIAlertView *facebookAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You cannot post to Facebook at this time" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [facebookAlert show];
    }
    
    
    else
    {
        UIAlertView *facebookAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You cannot post to Facebook at this time" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [facebookAlert show];
    }
    
}

-(void)shareText
{
    [self showSMS];
}

-(void)postToTwitter
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *twitterSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [self presentViewController:twitterSheet animated:YES completion:nil];
    }
    else if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        UIAlertView *facebookAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You cannot post to Twitter at this time" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [facebookAlert show];
    }
    
    
    else
    {
        UIAlertView *facebookAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You cannot post to Twitter at this time" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [facebookAlert show];
    }
    
}

-(void)showAction
{
    NSString *actionSheetTitle = @"Menu Options"; //Action Sheet Title
    NSString *shareByEmail = @"Share via e-mail";
    NSString *shareByText = @"Share via text";
    NSString *facebook = @"Post to Facebook";
    NSString *twitter = @"Post to Twitter";
    NSString *cancelTitle = @"Cancel Button";
    
    UIActionSheet *menuActionSheet = [[UIActionSheet alloc]
                        initWithTitle:actionSheetTitle
                        delegate:self
                        cancelButtonTitle:cancelTitle
                        destructiveButtonTitle:shareByEmail
                                      otherButtonTitles:shareByText, facebook, twitter, nil];
    [menuActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self shareOneTyme];
    }
    
    else if(buttonIndex == 1)
    {
        [self shareText];
    }
    
    else if(buttonIndex == 2)
    {
        [self postToFacebook];
    }
        
    else if(buttonIndex == 3)
    {
        [self postToTwitter];
    }
}

-(void)textAlertWithArray:(NSArray *)recipients andText:(NSString *)text
{
    for(int i = 0; i < [recipients count]; i++)
    {
        [PFCloud callFunctionInBackground:@"sendText" withParameters:@{@"to" : recipients[i], @"from" : @"+16788258982", @"body" : text} block:^(id object, NSError *error) {
            if(error == nil)
            {
                NSLog(@"Success");
            }
        }];
    }
}

- (void)showSMS{
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:nil];
    [messageController setBody:@"Sharing OneTyme App:\nwww.onetyme.com"];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self setNeedsStatusBarAppearanceUpdate];
        [messageController setNeedsStatusBarAppearanceUpdate];
        
    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

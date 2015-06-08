//
//  BailBondsViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#define kOFFSET_FOR_KEYBOARD 140.0
#import "BailBondsViewController.h"
#import "BailBondsTableViewController.h"

@interface BailBondsViewController ()<UITextFieldDelegate,UIScrollViewDelegate>{
    UIView *bbds;
    UIView *search;
    UIView *searchName;
    BOOL isZipClicked;
    BOOL isNameClicked;
    BOOL isBailBondsClicked;
    UITextField *txtFullName;
    UITextField *txtAddress;
    UITextField *txtCity;
    UITextField *txtState;
    UITextField *txtZip;
    UITextField *txtPhone;
    UITextField *txtSecondaryPhone;
    UITextField *txtEmail;
    BOOL bailIsAdded;
    CGRect locationFrame;
    CGRect zipFrame;
    CGRect nameFrame;
    NSInteger timesClicked;
    BOOL isLocationClicked;
    UITextField *txtSearch;
    UIButton *btnRight;
    UIButton *btnLeft;
    UIButton *nameButton;
    UIButton *zipButton;
    UIButton *locationButton;
    UILabel *lblTitle;
}

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *searchString;
@property (nonatomic, strong) UIScrollView *scrollView;

//@property (strong, nonatomic) NSMutableArray *bailBondsArray;

@end

@implementation BailBondsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    txtFullName.delegate = self;
    txtAddress.delegate = self;
    txtCity.delegate = self;
    txtState.delegate = self;
    txtZip.delegate = self;
    txtPhone.delegate = self;
    txtSecondaryPhone.delegate = self;
    txtEmail.delegate = self;
    txtSearch.delegate = self;
    
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    isZipClicked = NO;
    isNameClicked = NO;
    isBailBondsClicked = NO;
    isLocationClicked = NO;
    
    UIImageView *oneTymeImage;
    oneTymeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AttorneyBackground.png"]];
    if(![[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]){
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.15);
        oneTymeImage.frame = CGRectMake(0, 0, self.view.frame.size.width, 663);
        [self.scrollView addSubview:oneTymeImage];
    }
    
    else {
        oneTymeImage.frame = CGRectMake(0, 64, self.view.frame.size.width, 663);
        [self.view addSubview:oneTymeImage];
    }
    
    locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setTitle:@"Search By City" forState:UIControlStateNormal];
    CALayer *locationLayer;
    if ([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) {
        locationButton.frame = CGRectMake(70.5, 128, 273, 79);
        [self.view addSubview:locationButton];
    }
    else {
        locationButton.frame = CGRectMake(58.5, 96, 203, 40);
        [self.scrollView addSubview:locationButton];
    }
    
    [locationButton addTarget:self action:@selector(addSearchLocation:) forControlEvents:UIControlEventTouchUpInside];
    locationLayer = locationButton.layer;
    locationLayer = [self gradientBGLayerForBounds:locationButton.bounds];
    locationLayer.cornerRadius = 10;
    UIGraphicsBeginImageContext(locationLayer.bounds.size);
    [locationLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *locationImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (locationImage != nil)
    {
        [locationButton setBackgroundImage:locationImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    
    zipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zipButton setTitle:@"Search By Zip" forState:UIControlStateNormal];
    CALayer *zipLayer;
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) {
        zipButton.frame = CGRectMake(70.5, 261, 273, 79);
        [self.view addSubview:zipButton];
    }
    else {
        zipButton.frame = CGRectMake(58.5, 196, 203, 40);
        [self.scrollView addSubview:zipButton];
    }
    
    zipLayer = zipButton.layer;
    zipLayer = [self gradientBGLayerForBounds:zipButton.bounds];
    [zipButton addTarget:self action:@selector(addSearchZip:) forControlEvents:UIControlEventTouchUpInside];
    zipLayer.cornerRadius = 10;
    
    UIGraphicsBeginImageContext(zipLayer.bounds.size);
    [zipLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *zipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (zipImage != nil)
    {
        [zipButton setBackgroundImage:zipImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    
    nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nameButton setTitle:@"Search By Name" forState:UIControlStateNormal];
    CALayer *nameLayer;
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) {
        nameButton.frame = CGRectMake(70.5, 404, 273, 79);
        [self.view addSubview:nameButton];
    }
    else {
        nameButton.frame = CGRectMake(58.5, 296, 203, 40);
        [self.scrollView addSubview:nameButton];
    }
    
    nameLayer = nameButton.layer;
    nameLayer = [self gradientBGLayerForBounds:nameButton.bounds];
    [nameButton addTarget:self action:@selector(addSearchName:) forControlEvents:UIControlEventTouchUpInside];
    nameLayer.cornerRadius = 10;
    
    UIGraphicsBeginImageContext(nameLayer.bounds.size);
    [nameLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *nameImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (nameImage != nil)
    {
        [nameButton setBackgroundImage:nameImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    
    UIButton *addEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addEditButton setTitle:@"Add/edit my attorney" forState:UIControlStateNormal];
    CALayer *addEditLayer;
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) {
        addEditButton.frame = CGRectMake(70.5, 547, 273, 79);
        [self.view addSubview:addEditButton];
    }
    else {
        addEditButton.frame = CGRectMake(58.5, 396, 203, 40);
        [self.scrollView addSubview:addEditButton];
        [self.view addSubview:self.scrollView];
    }
    
    addEditLayer = addEditButton.layer;
    [addEditButton addTarget:self action:@selector(addBailBonds) forControlEvents:UIControlEventTouchUpInside];
    addEditLayer = [self gradientBGLayerForBounds:addEditButton.bounds];
    addEditLayer.cornerRadius = 10;
    
    UIGraphicsBeginImageContext(addEditLayer.bounds.size);
    [addEditLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *addEditImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (addEditImage != nil)
    {
        [addEditButton setBackgroundImage:addEditImage forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"Failded to create gradient bg image, user will see standard tint color gradient.");
    }
    
    locationFrame = CGRectMake(68, 164, 273, 109);
    zipFrame = CGRectMake(68, 282, 273, 109);
    nameFrame = CGRectMake(68, 425, 273, 109);
    timesClicked = 0;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [txtSearch resignFirstResponder];
    [search removeFromSuperview];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self setViewMovedUp:NO];
    [btnRight setHidden:NO];
    [btnLeft setHidden:NO];
    return YES;
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    [btnRight setHidden:YES];
    [btnLeft setHidden:YES];
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

- (CALayer *)gradientBGLayerForBounds:(CGRect)bounds
{
    CAGradientLayer * gradientBG = [CAGradientLayer layer];
    gradientBG.frame = bounds;
    gradientBG.colors = [NSArray arrayWithObjects:
                         (id)[[UIColor blackColor] CGColor],
                         (id)[[UIColor darkGrayColor] CGColor],
                         nil];
    return gradientBG;
}

-(void) addBailBondDetailSubview{
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]){
        bbds = [[UIView alloc] initWithFrame:CGRectMake(70.5, 283, 273, 354)];
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 263, 21)];
        txtFullName = [[UITextField alloc] initWithFrame:CGRectMake(5, 36, 263, 30)];
        txtAddress = [[UITextField alloc] initWithFrame:CGRectMake(5, 73, 263, 30)];
        txtCity = [[UITextField alloc]initWithFrame:CGRectMake(5, 109, 263, 30)];
        txtState = [[UITextField alloc]initWithFrame:CGRectMake(5, 145, 263, 30)];
        txtZip = [[UITextField alloc]initWithFrame:CGRectMake(5, 181, 263, 30)];
        txtPhone = [[UITextField alloc] initWithFrame:CGRectMake(10, 217, 263, 30)];
        txtSecondaryPhone = [[UITextField alloc] initWithFrame:CGRectMake(10, 253, 263, 30)];
        txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(10, 289, 263, 30)];
        btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(6, 325, 125.5, 30)];
        btnRight = [[UIButton alloc] initWithFrame:CGRectMake(141.5, 325, 125.5, 30)];
    }
    
    else{
        bbds = [[UIView alloc] initWithFrame:CGRectMake(58.5, 219, 203, 270)];
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 163, 21)];
        txtFullName = [[UITextField alloc] initWithFrame:CGRectMake(20, 36, 163, 20)];
        txtAddress = [[UITextField alloc] initWithFrame:CGRectMake(20, 61, 163, 20)];
        txtCity = [[UITextField alloc]initWithFrame:CGRectMake(20, 86, 163, 20)];
        txtState = [[UITextField alloc]initWithFrame:CGRectMake(20, 111, 163, 20)];
        txtZip = [[UITextField alloc]initWithFrame:CGRectMake(20, 136, 163, 20)];
        txtPhone = [[UITextField alloc] initWithFrame:CGRectMake(20, 161, 163, 20)];
        txtSecondaryPhone = [[UITextField alloc] initWithFrame:CGRectMake(20, 186, 163, 20)];
        txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(20, 211, 163, 20)];
        btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(11, 241, 90, 20)];
        btnRight = [[UIButton alloc] initWithFrame:CGRectMake(111, 241, 90, 20)];
    }
    bbds.backgroundColor = [UIColor darkGrayColor];
    lblTitle.text = @"Bail Bonds Details";
    [bbds addSubview:lblTitle];
    
    txtFullName.backgroundColor = [UIColor blackColor];
    txtFullName.layer.cornerRadius = 10;
    txtFullName.textColor = [UIColor whiteColor];
    txtFullName.placeholder = @"Full Name";
    [txtFullName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtFullName.textAlignment = NSTextAlignmentCenter;
    txtFullName.delegate = self;
    [bbds addSubview:txtFullName];
    
    txtAddress.backgroundColor = [UIColor blackColor];
    txtAddress.layer.cornerRadius = 10;
    txtAddress.textColor = [UIColor whiteColor];
    txtAddress.placeholder = @"Address";
    [txtAddress setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtAddress.textAlignment = NSTextAlignmentCenter;
    txtAddress.delegate = self;
    [bbds addSubview:txtAddress];
    
    txtCity.backgroundColor = [UIColor blackColor];
    txtCity.layer.cornerRadius = 10;
    txtCity.textColor = [UIColor whiteColor];
    txtCity.placeholder = @"City";
    [txtCity setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtCity.textAlignment = NSTextAlignmentCenter;
    txtCity.delegate = self;
    [bbds addSubview:txtCity];
    
    txtState.backgroundColor = [UIColor blackColor];
    txtState.layer.cornerRadius = 10;
    txtState.textColor = [UIColor whiteColor];
    txtState.placeholder = @"State";
    [txtState setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtState.textAlignment = NSTextAlignmentCenter;
    txtState.delegate = self;
    [bbds addSubview:txtState];
    
    txtZip.backgroundColor = [UIColor blackColor];
    txtZip.layer.cornerRadius = 10;
    txtZip.textColor = [UIColor whiteColor];
    txtZip.placeholder = @"Zip Code";
    [txtZip setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtZip.textAlignment = NSTextAlignmentCenter;
    txtZip.delegate = self;
    [bbds addSubview:txtZip];
    
    txtPhone.backgroundColor = [UIColor blackColor];
    txtPhone.layer.cornerRadius = 10;
    txtPhone.textColor = [UIColor whiteColor];
    txtPhone.placeholder = @"Mobile/Landline";
    [txtPhone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtPhone.textAlignment = NSTextAlignmentCenter;
    txtPhone.delegate = self;
    [bbds addSubview:txtPhone];
    
    txtSecondaryPhone.backgroundColor = [UIColor blackColor];
    txtSecondaryPhone.layer.cornerRadius = 10;
    txtSecondaryPhone.textColor = [UIColor whiteColor];
    txtSecondaryPhone.placeholder = @"Mobile/Landline";
    [txtSecondaryPhone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtSecondaryPhone.textAlignment = NSTextAlignmentCenter;
    txtSecondaryPhone.delegate = self;
    [bbds addSubview:txtSecondaryPhone];
    
    txtEmail.backgroundColor = [UIColor blackColor];
    txtEmail.layer.cornerRadius = 10;
    txtEmail.textColor = [UIColor whiteColor];
    txtEmail.placeholder = @"Email";
    [txtEmail setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtEmail.textAlignment = NSTextAlignmentCenter;
    txtEmail.delegate = self;
    [bbds addSubview:txtEmail];
    
    [btnLeft setTitle:@"Submit" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(addBailBonds) forControlEvents:UIControlEventTouchUpInside];
    [bbds addSubview:btnLeft];
    
    [btnRight setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(removeSearchSuperview) forControlEvents:UIControlEventTouchUpInside];
    [bbds addSubview:btnRight];
    
    [self.view addSubview:bbds];
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"BondsProfile"] != nil)
    {
        NSMutableDictionary *temp = [[NSUserDefaults standardUserDefaults] valueForKey:@"BondsProfile"];
        
        
        txtFullName.text = [temp valueForKey:@"name"];
        txtAddress.text = [temp valueForKey:@"address"];
        txtCity.text = [temp valueForKey:@"city"];
        txtState.text = [temp valueForKey:@"state"];
        txtZip.text = [temp valueForKey:@"zip"];
        txtEmail.text = [temp valueForKey:@"email"];
        txtPhone.text = [temp valueForKey:@"phone"];
        txtSecondaryPhone.text = [temp valueForKey:@"secondaryPhone"];
    }
}

-(void)formBondsDict
{
    if([txtFullName.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([txtAddress.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([txtCity.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide your city" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([txtState.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide state" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([txtZip.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide zip" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([txtEmail.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([txtPhone.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide your Phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([txtSecondaryPhone.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide your Secondary Phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        
        [temp setValue:txtFullName.text forKey:@"name"];
        [temp setValue:txtAddress.text forKey:@"address"];
        [temp setValue:txtCity.text forKey:@"city"];
        [temp setValue:txtState.text forKey:@"state"];
        [temp setValue:txtZip.text forKey:@"zip"];
        [temp setValue:txtEmail.text forKey:@"email"];
        [temp setValue:txtPhone.text forKey:@"phone"];
        [temp setValue:txtSecondaryPhone.text forKey:@"secondaryPhone"];
        
        [[NSUserDefaults standardUserDefaults]setObject:temp forKey:@"BondsProfile"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

-(void)addBailBonds
{
    if(isBailBondsClicked == NO)
    {
        [self addBailBondDetailSubview];
        isBailBondsClicked = YES;
    }
    
    else if(isBailBondsClicked == YES && (txtAddress.isEditing || txtCity.isEditing || txtEmail.isEditing || txtFullName.isEditing || txtPhone.isEditing || txtSecondaryPhone.isEditing || txtState.isEditing))
    {
        [bbds removeFromSuperview];
        [self formBondsDict];
        
        isBailBondsClicked = NO;
    }
    
    else {
        [bbds removeFromSuperview];
        [self formBondsDict];
        isBailBondsClicked = NO;
    }
}

-(void)removeSearchSuperview
{
    [bbds removeFromSuperview];
    isBailBondsClicked = NO;
    if(txtFullName.isEditing || txtAddress.isEditing || txtCity.isEditing || txtState.isEditing || txtPhone.isEditing || txtSecondaryPhone.isEditing || txtEmail.isEditing) [self setViewMovedUp:NO];
}
//
//-(void)addSearchLocation
//{
//    if(isLocationClicked == NO)
//    {
//        [self addSearchView:@"Search By Location" withFrame:locationFrame];
//        _searchString = @"City";
//        isLocationClicked = YES;
//    }
//    
//    else
//    {
//        [search removeFromSuperview];
//        isLocationClicked = NO;
//    }
//}
//
//-(void)addSearchName{
//    if(isNameClicked == NO)
//    {
//        [self addSearchView:@"Search By Name" withFrame:nameFrame];
//        _searchString = @"Name";
//        isNameClicked = YES;
//    }
//    
//    else
//    {
//        [search removeFromSuperview];
//        isNameClicked = NO;
//    }
//}
//
//-(void)addSearchZip{
//    if(isZipClicked == NO)
//    {
//        [self addSearchView:@"Search By Zip" withFrame:zipFrame];
//        _searchString = @"Zip";
//        isZipClicked = YES;
//    }
//    
//    else
//    {
//        [search removeFromSuperview];
//        isZipClicked = NO;
//    }
//}

-(void)addSearchView:(NSString *)searchType withFrame:(CGRect)searchFrame{
    //isZipClicked = YES;
    //isNameClicked = YES;
    search = [[UIView alloc] initWithFrame:searchFrame];
    
    search.backgroundColor = [UIColor darkGrayColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 263, 21)];
    lblTitle.text = searchType;
    [search addSubview:lblTitle];
    
    txtSearch = [[UITextField alloc] initWithFrame:CGRectMake(5, 41, 263, 30)];
    txtSearch.backgroundColor = [UIColor blackColor];
    txtSearch.layer.cornerRadius = 10;
    txtSearch.textColor = [UIColor whiteColor];
    txtSearch.placeholder = searchType;
    [txtSearch setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtSearch.textAlignment = NSTextAlignmentCenter;
    txtSearch.delegate = self;
    [search addSubview:txtSearch];
    
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(20, 77, 82, 30)];
    [btnLeft setTitle:@"Submit" forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(transitionToAttorneyList) forControlEvents:UIControlEventTouchUpInside];
    [search addSubview:btnLeft];
    
    btnRight = [[UIButton alloc] initWithFrame:CGRectMake(171, 77, 82, 30)];
    [btnRight setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [search addSubview:btnRight];
    
    [self.view addSubview:search];
    timesClicked++;
}

-(void)transitionToAttorneyList
{
    [self performSegueWithIdentifier:@"toBondsList" sender:nil];
}

-(void)dismissView
{
    [search removeFromSuperview];
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidChange
{
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[BailBondsTableViewController class]])
    {
        BailBondsTableViewController *tController = segue.destinationViewController;
        if([[segue identifier] isEqualToString:@"toBondsListByCity"]){
            _searchString = @"City";
            tController.preQuery = _appDelegate.placemark.locality;
        }
        
        else if([[segue identifier] isEqualToString:@"toBondsListByZip"]){
            _searchString = @"Zip";
            tController.preQuery = _appDelegate.placemark.postalCode;
        }
        
        else if([[segue identifier] isEqualToString:@"toBondsListByName"]){
            _searchString = @"Name";
            
        }
        tController.searchString = _searchString;
    }
}

-(void)transitionToAttorneyListByCity
{
    [self performSegueWithIdentifier:@"toBondsListByCity" sender:nil];
}

-(void)transitionToAttorneyListByName
{
    [self performSegueWithIdentifier:@"toBondsListByName" sender:nil];
}

-(void)transitionToAttorneyListByZip
{
    [self performSegueWithIdentifier:@"toBondsListByZip" sender:nil];
}

-(IBAction)addSearchLocation:(id)sender
{
    [self transitionToAttorneyListByCity];
    _searchString = locationButton.titleLabel.text;
    isLocationClicked = YES;
    isNameClicked = NO;
    isZipClicked = NO;
}

-(IBAction)addSearchName:(id)sender
{
    [self transitionToAttorneyListByName];
    _searchString = nameButton.titleLabel.text;
    isNameClicked = YES;
    isZipClicked = NO;
    isLocationClicked = NO;
}

-(IBAction)addSearchZip:(id)sender
{
    [self transitionToAttorneyListByZip];
    _searchString = zipButton.titleLabel.text;
    isZipClicked = YES;
    isLocationClicked = NO;
    isNameClicked = NO;
}

@end

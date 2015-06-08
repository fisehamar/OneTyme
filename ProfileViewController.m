//
//  ProfileViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 3/3/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"

@interface ProfileViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *addressField;
@property (nonatomic, strong) UITextField *cityField;
@property (nonatomic, strong) UITextField *stateField;
@property (nonatomic, strong) UITextField *zipField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *secondaryPhoneField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextView *messageTextView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) AppDelegate *appDelegate;

- (IBAction)saveProfile:(id)sender;
- (IBAction)backHome:(id)sender;
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIImageView *oneTymeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AttorneyBackground.png"]];
    oneTymeImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:oneTymeImage];
    
    UIColor *textfieldPlaceholderColor = [UIColor lightGrayColor];
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]){
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.8);
        self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(57, 128, 300, 30)];
    }
    else {
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2.6);
    }
    
    if(![[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(50, 96, 220, 30)];
    self.nameField.layer.cornerRadius = 10;
    self.nameField.backgroundColor = [UIColor blackColor];
    self.nameField.textColor = textfieldPlaceholderColor;
    self.nameField.placeholder = @"Name";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(57, 228, 300, 30)];
    else self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(50, 196, 220, 30)];
    self.addressField.layer.cornerRadius = 10;
    self.addressField.backgroundColor = [UIColor blackColor];
    self.addressField.textColor = textfieldPlaceholderColor;
    self.addressField.placeholder = @"Address";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.cityField = [[UITextField alloc]initWithFrame:CGRectMake(57, 328, 300, 30)];
    else self.cityField = [[UITextField alloc]initWithFrame:CGRectMake(50, 296, 220, 30)];
    self.cityField.layer.cornerRadius = 10;
    self.cityField.backgroundColor = [UIColor blackColor];
    self.cityField.textColor = textfieldPlaceholderColor;
    self.cityField.placeholder = @"City";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.stateField = [[UITextField alloc]initWithFrame:CGRectMake(57, 428, 300, 30)];
    else self.stateField = [[UITextField alloc]initWithFrame:CGRectMake(50, 396, 220, 30)];
    self.stateField.layer.cornerRadius = 10;
    self.stateField.backgroundColor = [UIColor blackColor];
    self.stateField.textColor = textfieldPlaceholderColor;
    self.stateField.placeholder = @"State";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.zipField = [[UITextField alloc]initWithFrame:CGRectMake(57, 528, 300, 30)];
    else self.zipField = [[UITextField alloc]initWithFrame:CGRectMake(50, 496, 220, 30)];
    self.zipField.layer.cornerRadius = 10;
    self.zipField.backgroundColor = [UIColor blackColor];
    self.zipField.textColor = textfieldPlaceholderColor;
    self.zipField.placeholder = @"Zip Code";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(57, 628, 300, 30)];
    else self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(50, 596, 220, 30)];
    self.phoneField.layer.cornerRadius = 10;
    self.phoneField.backgroundColor = [UIColor blackColor];
    self.phoneField.textColor = textfieldPlaceholderColor;
    self.phoneField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.phoneField.placeholder = @"Phone";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.secondaryPhoneField = [[UITextField alloc]initWithFrame:CGRectMake(57, 728, 300, 30)];
    else self.secondaryPhoneField = [[UITextField alloc]initWithFrame:CGRectMake(50, 696, 220, 30)];
    self.secondaryPhoneField.layer.cornerRadius = 10;
    self.secondaryPhoneField.backgroundColor = [UIColor blackColor];
    self.secondaryPhoneField.textColor = textfieldPlaceholderColor;
    self.secondaryPhoneField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.secondaryPhoneField.placeholder = @"Secondary Phone";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.emailField = [[UITextField alloc]initWithFrame:CGRectMake(57, 828, 300, 30)];
    else self.emailField = [[UITextField alloc]initWithFrame:CGRectMake(50, 796, 220, 30)];
    self.emailField.layer.cornerRadius = 10;
    self.emailField.backgroundColor = [UIColor blackColor];
    self.emailField.textColor = textfieldPlaceholderColor;
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.placeholder = @"E-mail";
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.messageTextView = [[UITextView alloc]initWithFrame:CGRectMake(57, 928, 300, 100)];
    else self.messageTextView = [[UITextView alloc]initWithFrame:CGRectMake(50, 896, 220, 100)];
    self.messageTextView.layer.cornerRadius = 15;
    self.messageTextView.backgroundColor = [UIColor blackColor];
    self.messageTextView.font = [UIFont fontWithName:@"Helvetica" size:20];
    self.messageTextView.textColor = textfieldPlaceholderColor;
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]) self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 1078, 300, self.datePicker.frame.size.height)];
    else self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 1046, 300, self.datePicker.frame.size.height)];
    
    [self.nameField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.addressField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.cityField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.stateField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.zipField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.secondaryPhoneField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.emailField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    self.nameField.textAlignment = NSTextAlignmentCenter;
    self.addressField.textAlignment = NSTextAlignmentCenter;
    self.cityField.textAlignment = NSTextAlignmentCenter;
    self.stateField.textAlignment = NSTextAlignmentCenter;
    self.zipField.textAlignment = NSTextAlignmentCenter;
    self.phoneField.textAlignment = NSTextAlignmentCenter;
    self.secondaryPhoneField.textAlignment = NSTextAlignmentCenter;
    self.emailField.textAlignment = NSTextAlignmentCenter;
    
    self.nameField.delegate = self;
    self.addressField.delegate = self;
    self.cityField.delegate = self;
    self.stateField.delegate = self;
    self.zipField.delegate = self;
    self.phoneField.delegate = self;
    self.secondaryPhoneField.delegate = self;
    self.emailField.delegate = self;
    self.messageTextView.delegate = self;
    
    [self.scrollView addSubview:self.nameField];
    [self.scrollView addSubview:self.addressField];
    [self.scrollView addSubview:self.cityField];
    [self.scrollView addSubview:self.stateField];
    [self.scrollView addSubview:self.zipField];
    [self.scrollView addSubview:self.phoneField];
    [self.scrollView addSubview:self.secondaryPhoneField];
    [self.scrollView addSubview:self.emailField];
    [self.scrollView addSubview:self.datePicker];
    [self.scrollView addSubview:self.messageTextView];
    [self.view addSubview:self.scrollView];
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"UserProfile"] != nil)
    {
        NSMutableDictionary *temp = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserProfile"];
        
        
        self.nameField.text = [temp valueForKey:@"name"];
        self.addressField.text = [temp valueForKey:@"address"];
        self.cityField.text = [temp valueForKey:@"city"];
        self.stateField.text = [temp valueForKey:@"state"];
        self.zipField.text = [temp valueForKey:@"zip"];
        self.emailField.text = [temp valueForKey:@"email"];
        self.phoneField.text = [temp valueForKey:@"phone"];
        self.secondaryPhoneField.text = [temp valueForKey:@"secondaryPhone"];
        self.formatter.dateFormat = @"dd-MMM-yyyy";
        self.datePicker.date = [temp valueForKey:@"date"];
        
        if(![[temp valueForKey:@"message"] isEqualToString:@""])
        {
            self.messageTextView.text = [temp valueForKey:@"message"];
        }
        else
        {
            self.messageTextView.text = @"Type Your Distress Message";
            self.messageTextView.textColor = [UIColor whiteColor];
        }
    }
    
    else {
        self.messageTextView.text = @"Type your message here";
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/* UITextView Delegate method. This method is triggered when the user types a new character in the textView. */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    /* Test if the entered text is a return. If it is we tell textView to dismiss the keyboard and then we stop the textView from entering in additional information as text. This is not a perfect solution because users cannot enter returns in their text and if they paste text with a return items after the return will not be added. For the functionality required in this project this solution works just fine. */
    if ([text isEqualToString:@"\n"]){
        [self.messageTextView resignFirstResponder];
        return NO;
    }
    else return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (IBAction)saveProfile:(id)sender
{
    if([self.nameField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.addressField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.cityField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide your city" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.stateField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide state" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.zipField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide zip code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.emailField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    else if ([self.phoneField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide your Phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([self.secondaryPhoneField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Provide your Phone number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        
        [temp setValue:self.nameField.text forKey:@"name"];
        [temp setValue:self.addressField.text forKey:@"address"];
        [temp setValue:self.cityField.text forKey:@"city"];
        [temp setValue:self.stateField.text forKey:@"state"];
        [temp setValue:self.zipField.text forKey:@"zip"];
        [temp setValue:self.emailField.text forKey:@"email"];
        [temp setValue:self.phoneField.text forKey:@"phone"];
        [temp setValue:self.secondaryPhoneField.text forKey:@"secondaryPhone"];
        [temp setValue:self.datePicker.date forKey:@"date"];
        
        
        if([self.messageTextView.text isEqualToString:@""])
        {
            [temp setValue:@"" forKey:@"message"];
        }
        else
        {
            [temp setValue:self.messageTextView.text forKey:@"message"];
            
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:temp forKey:@"UserProfile"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self showAlert];
        
    }
}

- (IBAction)backHome:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) showAlert
{
    [UIView beginAnimations:nil context:NULL];
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 0.0);
    [self.scrollView setTransform:myTransform];
    [UIView commitAnimations];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"User Profile has been saved succesfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end

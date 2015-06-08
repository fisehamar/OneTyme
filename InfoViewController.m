#import "InfoViewController.h"
#import "AppDelegate.h"

@interface InfoViewController ()
@property (strong, nonatomic) AppDelegate *appDelegate;
@end

@implementation InfoViewController

#pragma mark
#pragma mark - View load methods

- (void)viewDidLoad
{
    //[self loadWebView];
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UILabel *featureLabel;
    UILabel *disclaimerLabel;
    self.textView.textContainerInset = UIEdgeInsetsMake(20, 5, 0, 0);
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    if([[_appDelegate platformString]isEqualToString:@"iPhone 6 Plus"]){
        self.textView.text = [self getInfoString];
        self.textView.font = [UIFont fontWithName:@"Helvetica" size:14];
        featureLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 110, self.view.frame.size.width, 30)];
        disclaimerLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 320, self.view.frame.size.width, 30)];
    }
    else {
        self.textView.text = [self getOtherInfoString];
        featureLabel = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 130, self.view.frame.size.width, 40)];
        disclaimerLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 350, self.view.frame.size.width, 30)];
    }
    featureLabel.numberOfLines = 0;
    featureLabel.font = [UIFont fontWithName:@"Helvetica" size:8];
    featureLabel.text = @"Onetyme Legal Directory is packed with these features:";
    
    disclaimerLabel.text = @"General Disclaimer";
    [self.textView addSubview:featureLabel];
    [self.textView addSubview:disclaimerLabel];
    featureLabel.font = [UIFont boldSystemFontOfSize:14];
    disclaimerLabel.font = [UIFont boldSystemFontOfSize:14];
    self.textView.editable = NO;
    [self.view addSubview:_textView];
}

#pragma mark -
#pragma mark -  Button click methods

-(IBAction)backButton_Clicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)getInfoString
{
    NSString *infoString = @"     Going out tonight, not without Onetyme. Onetyme Legal\n Directory is the simple and ultimate way to help you plan for\n the unexpected situation of getting arrested. Instantly inform\n your family or friends of your location, connect to your\n attorney and bail bondsman providing them with the critical\n information they need to get you released from jail quickly.\n\n     \n\n   * Search attorney by GPS location, zip code, name     or add your own attorney\n   * Search bail bonds companies by GPS location, zip code,\n     name or add your own bail bond company\n   * Add up to 5 Life Lines to notify using your address book\n   * Instantly send an urgent message\n   * Notify your attorney, bail bonds company, and Life Line\n    instantly\n   * Send your GPS location\n   * All with just one push of Onetyme\n\n\n\n     Selecting or contacting an attorney or bail bond company\n does not form an attorney, client, or bail bondsman\n relationship. Service and information provided by Onetyme\n is not legal advice. For complete disclaimer or privacy policy\nlog on to onetyme.com";
    return infoString;
}

-(NSString *)getOtherInfoString
{
    NSString *infoString = @"     Going out tonight, not without Onetyme.\n Onetyme Legal Directory is the simple\n and ultimate way to help you plan for\n the unexpected situation of getting arrested.\n Instantly inform your family or friends of your\n location, connect to your attorney and bail\n bondsman providing them with the critical\n information they need to get you released\n from jail quickly.\n\n     \n\n   * Search attorney by GPS location, zip code,\n name or add your own attorney\n   * Search bail bonds companies by GPS\n location, zip code, name or add your own bail\n bond company\n   * Add up to 5 Life Lines to notify using your\n address book\n   * Instantly send an urgent message\n   * Notify your attorney, bail bonds company,\n and Life Line instantly\n   * Send your GPS location\n   * All with just one push of Onetyme\n\n\n\n     Selecting or contacting an attorney or bail\n bonds company does not form an attorney,\n client, or bail bondsman relationship. Service\n and information provided by Onetyme is not\n legal advice. For complete disclaimer or\n privacy policy log on to onetyme.com";
    return infoString;
}

#pragma mark
#pragma mark - View extra methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
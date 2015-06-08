#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *infoWebView;
    IBOutlet UIButton *backButton;
}

//@property (nonatomic,retain) IBOutlet UIWebView *infoWebView;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) UITextView *textView;

-(IBAction)backButton_Clicked:(id)sender;

-(void)loadWebView;

@end

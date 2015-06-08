//
//  BailBondsTableViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 3/1/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "BailBondsTableViewController.h"
#import "BailBondsDetailViewController.h"

@implementation BailBondsTableViewController

MBProgressHUD *hud;
UIAlertView *searchByNameAlert;
UIAlertView *searchByLocationAlert;
UIAlertView *searchByZipAlert;
UIAlertView *alertView;

-(NSMutableArray *)paidBondsmen
{
    if(!_paidBondsmen) _paidBondsmen = [NSMutableArray array]; return _paidBondsmen;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self retrieveBonds];
    self.navigationItem.title =[NSString stringWithFormat:@"Bail Bondsmen By %@", _searchString];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField =  [alertView textFieldAtIndex: 0];
    
    if(buttonIndex == 1 ){
        if (textField.text.length > 0)
        {
            NSLog(@"textfield = %@", textField.text);
            self.searchQuery = textField.text;
            [self retrieveBondsBySearch];
            [self loadingOverlay];
        }
        
        else
        {
            NSLog(@"textfield = %@", textField.text);
            self.searchQuery = _preQuery;
            [self retrieveBondsBySearch];
            [self loadingOverlay];
        }
    }
}

-(void)loadingOverlay
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
}

-(void) retrieveBondsBySearch{
    PFQuery *retrieveAttorney = [PFQuery queryWithClassName:@"BailBonds"];
    [retrieveAttorney whereKey:_searchString equalTo:_searchQuery];
    [retrieveAttorney findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            _paidBondsmen = [objects mutableCopy];
            if([objects count] == 0){
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No results found" message:@"Please search again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertView show];
            }
            NSLog(@"%@", objects);
            [self.tableView reloadData];
            [hud hide:YES];
        }
        else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void) retrieveBonds{
    PFQuery *retrieveAttorney = [PFQuery queryWithClassName:@"BailBonds"];
    [retrieveAttorney findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            _paidBondsmen = [objects mutableCopy];
            NSLog(@"%@", objects);
            [self.tableView reloadData];
            [hud hide:YES];
        }
        else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_paidBondsmen count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *bondsmen = _paidBondsmen[indexPath.row];
    
    PFFile *file = bondsmen[@"Logo"];
    NSData *imageData = [file getData];
    UIImage *image = [UIImage imageWithData:imageData];
    UIImage *finalImage = [self resizeImage:image];
    cell.imageView.image = finalImage;
    cell.textLabel.text = bondsmen[@"Name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@, %@", bondsmen[@"Address"], bondsmen[@"City"], bondsmen[@"State"], bondsmen[@"Zip"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toBondsDetail" sender:indexPath];
}

-(UIImage *)resizeImage:(UIImage *)image
{
    CGRect rect = CGRectMake(0, 0, 75, 75);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *transformedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imgData = UIImagePNGRepresentation(transformedImage);
    UIImage *finalImage = [UIImage imageWithData:imgData];
    
    return finalImage;
}

- (IBAction)searchAttorneys:(id)sender
{
    if([_searchString isEqualToString:@"Name"]){
        searchByNameAlert = [[UIAlertView alloc] initWithTitle:@"Search By Name"
                                                       message:@"Please search for an attorney by name"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"OK",nil];
        searchByNameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [searchByNameAlert show];
    }
    
    else if([_searchString isEqualToString:@"City"]){
        NSString *titleMessage = [NSString stringWithFormat:@"You are currently located in %@", _preQuery];
        searchByLocationAlert = [[UIAlertView alloc] initWithTitle:titleMessage
                                                           message:@"If you would like to search another city, please enter one."
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"OK",nil];
        searchByLocationAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [searchByLocationAlert show];
    }
    
    else if([_searchString isEqualToString:@"Zip"]){
        NSString *titleMessage = [NSString stringWithFormat:@"You are currently located in %@", _preQuery];
        searchByZipAlert = [[UIAlertView alloc] initWithTitle:titleMessage
                                                      message:@"If you would like to search another zip code, please enter one."
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"OK",nil];
        searchByZipAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [searchByZipAlert show];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[BailBondsDetailViewController class]])
    {
        BailBondsDetailViewController *detailController = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        PFObject *bondsmen = self.paidBondsmen[indexPath.row];
        detailController.bondsmen = bondsmen;
    }
}

@end

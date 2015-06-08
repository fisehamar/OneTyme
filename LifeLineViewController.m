//
//  LifeLineViewController.m
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "LifeLineViewController.h"
#import "AppDelegate.h"
#import "LifeLineTableViewCell.h"
#import "LifeLine.h"
#import "LifelineAddViewController.h"

@interface LifeLineViewController ()<UITableViewDelegate,UITableViewDataSource,LifelineAddViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (assign, nonatomic) BOOL editingMode;

@end

@implementation LifeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    /* Access NSUserDefaults for the array containing the task's saved as NSDictionary objects. */
    NSArray *lifelinesAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:LIFELINE_OBJECTS_KEY];
    
    /* Iterate over the returned array with fast enumeration. Convert each dictionary into a FitnessGoal object using the helper method goalObjectForDictionary. Add the returned goal objects to the goalObjectsArray */
    for (NSDictionary *dictionary in lifelinesAsPropertyLists){
        LifeLine *lifelineObject = [self lifelineObjectForDictionary:dictionary];
            [_appDelegate.LifeLineDataArray addObject:lifelineObject];
    }
    _editingMode = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_appDelegate.LifeLineDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LifeLineTableViewCell";
    
    LifeLineTableViewCell *cell = (LifeLineTableViewCell *) [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    LifeLine *lifeline = [_appDelegate.LifeLineDataArray objectAtIndex:indexPath.row];
    
    
    cell.nameLabel.text = lifeline.name;
    cell.addressLabel.text = lifeline.address;
    cell.zipLabel.text = [NSString stringWithFormat:@"%@, %@ %@", lifeline.city, lifeline.state, lifeline.zipCode];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toEditLifeline" sender:indexPath];
}

/* Allow the user to edit tableViewCells for deletion */
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/* Method called when the users swipes and presses the delete key */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        /* If a user deletes the row remove the task at that row from the tasksArray */
        [_appDelegate.LifeLineDataArray removeObjectAtIndex:indexPath.row];
    }
    
    NSMutableArray *newLifelineObjectsData = [[NSMutableArray alloc] init];
    
    for (LifeLine *lifeline in _appDelegate.LifeLineDataArray){
        [newLifelineObjectsData addObject:[self lifelineObjectsAsAPropertyList:lifeline]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:newLifelineObjectsData forKey:LIFELINE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    /* Animate the deletion of the cell */
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)didAddLifeline:(LifeLine *)lifeline
{
    [_appDelegate.LifeLineDataArray addObject:lifeline];
    
    /* Use NSUserDefaults to access all previously saved tasks. If there were not saved tasks we allocate and initialize the NSMutableArray named taskObjectsAsPropertyLists. */
    NSMutableArray *lifelineObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:LIFELINE_OBJECTS_KEY] mutableCopy];
    if (!lifelineObjectsAsPropertyLists) lifelineObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    /* First convert the task object to a property list using the method taskObjectAsAPropertyList. Then add the propertylist (dictionary) to the taskObjectsAsPropertyLists NSMutableArray. Synchronize will save the added array to NSUserDefaults.*/
    [lifelineObjectsAsPropertyLists addObject:[self lifelineObjectsAsAPropertyList:lifeline]];
    [[NSUserDefaults standardUserDefaults] setObject:lifelineObjectsAsPropertyLists forKey:LIFELINE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

/* Convert and return an NSDictionary of the taskObject */
-(NSDictionary *)lifelineObjectsAsAPropertyList:(LifeLine *)lifelineObject
{
    NSDictionary *dictionary = @{NAME : lifelineObject.name, ADDRESS : lifelineObject.address, CITY : lifelineObject.city, STATE : lifelineObject.state, ZIP_CODE : lifelineObject.zipCode, PHONE_NO : lifelineObject.phone, SECONDARY_PHONE_NO : lifelineObject.secondaryPhone, EMAIL : lifelineObject.email };
    return dictionary;
}


-(LifeLine *)lifelineObjectForDictionary:(NSDictionary *)dictionary
{
    LifeLine *lifelineObject = [[LifeLine alloc] initWithLifeLine:dictionary];
    return lifelineObject;
}

-(void)saveLifeline:(LifeLine *)lifeline
{
    /* Create a NSMutableArray that we will NSDictionaries returned from the method taskObjectAsAPropertyList. */
    NSMutableArray *lifelineObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [_appDelegate.LifeLineDataArray count]; x ++){
            [lifelineObjectsAsPropertyLists addObject:[self lifelineObjectsAsAPropertyList:_appDelegate.LifeLineDataArray[x]]];
        }
    /* Save the updated array to NSUserDefaults. */
    [[NSUserDefaults standardUserDefaults] setObject:lifelineObjectsAsPropertyLists forKey:LIFELINE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //[self.delegate didUpdateLifeLine];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    LifeLine *lifelineObject = [[LifeLine alloc]init];
    NSIndexPath *path = sender;
    if ([segue.destinationViewController isKindOfClass:[LifelineAddViewController class]]){
        LifelineAddViewController *addViewController = segue.destinationViewController;
        addViewController.delegate = self;

        if([[segue identifier]isEqualToString:@"toEditLifeline"]){
            lifelineObject = _appDelegate.LifeLineDataArray[path.row];
            _editingMode = YES;
            addViewController.isEdit = _editingMode;
            NSLog(@"%i", _editingMode);
            addViewController.localLifeline = lifelineObject;
            NSLog(@"%@",lifelineObject.name);
            
            }
    }
}


- (IBAction)addLifeline:(id)sender {
    if(_appDelegate.LifeLineDataArray.count < 5) {
        [self performSegueWithIdentifier:@"toAddLifeline" sender:self];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Limit Reached" message:@"You have reached your limit of 5 lifelines. You may replace lifelines with different ones." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}
@end

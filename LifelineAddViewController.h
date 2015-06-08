//
//  LifelineAddViewController.h
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeLine.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "LifeLineViewController.h"

@protocol LifelineAddViewControllerDelegate <NSObject>

-(void)didAddLifeline:(LifeLine *)lifeline;
-(void)saveLifeline:(LifeLine *)lifeline;

@end

@interface LifelineAddViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate,LifeLineViewControllerDelegate>

-(IBAction)saveButton_Clicked:(id)sender;
-(IBAction)backButton_Clicked:(id)sender;
-(IBAction)selectFromContacts:(id)sender;

-(void)fillEditDetails;

-(void)saveLifeLine;
-(void)editLifeLine;

-(void)showPeoplePickerController;
- (IBAction)showContacts:(id)sender;

@property(nonatomic,readwrite) BOOL isEdit;
@property(nonatomic,readwrite) int editIndex;
/* A delegate property which will allow us to call the protocol methods. */
@property (retain, nonatomic) id <LifelineAddViewControllerDelegate> delegate;
@property (strong, nonatomic) LifeLine *localLifeline;
@property (strong, nonatomic) LifeLineViewController *controller;

@end

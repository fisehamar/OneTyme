//
//  Attorney.h
//  OneTyme
//
//  Created by Joffrey Mann on 1/29/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NAME @"Name"
#define ADDRESS @"Address"
#define CITY @"City"
#define STATE @"State"
#define ZIP_CODE @"ZipCode"
#define EMAIL @"E-mail"
#define PHONE_NO @"Phone"
#define SECONDARY_PHONE_NO @"SecondaryPhone"

@interface Attorney : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *secondaryPhone;

/* Custom Initializer which has a single parameter of class NSDictionary. */
-(id)initWithAttorney:(NSDictionary *)attorney;

@end

//
//  BailBonds.m
//  OneTyme
//
//  Created by Nutech Systems on 1/29/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "BailBonds.h"

@implementation BailBonds

/* Designated Initializer */
-(id)initWithBailBonds:(NSDictionary *)bailBonds
{
    /* Designated Initializer must call the super classes initialization method */
    self = [super init];
    
    /* Setup the object with values from the NSDictionary */
    if (self){
        self.name = bailBonds[NAME];
        self.address = bailBonds[ADDRESS];
        self.city = bailBonds[CITY];
        self.state = bailBonds[STATE];
        self.zipCode = bailBonds[ZIP_CODE];
        self.phone = bailBonds[PHONE_NO];
        self.secondaryPhone = bailBonds[SECONDARY_PHONE_NO];
        self.email = bailBonds[EMAIL];
    }
    
    return self;
}

/* Default initializer calls the new designated initializer initWithData */
-(id)init
{
    self = [self initWithBailBonds:nil];
    return self;
}

@end
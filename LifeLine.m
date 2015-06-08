//
//  LifeLine.m
//  OneTyme
//
//  Created by Joffrey Mann on 1/28/15.
//  Copyright (c) 2015 Nutech. All rights reserved.
//

#import "LifeLine.h"

@implementation LifeLine

/* Designated Initializer */
-(id)initWithLifeLine:(NSDictionary *)lifeline
{
    /* Designated Initializer must call the super classes initialization method */
    self = [super init];
    
    /* Setup the object with values from the NSDictionary */
    if (self){
        self.name = lifeline[NAME];
        self.address = lifeline[ADDRESS];
        self.city = lifeline[CITY];
        self.state = lifeline[STATE];
        self.zipCode = lifeline[ZIP_CODE];
        self.phone = lifeline[PHONE_NO];
        self.secondaryPhone = lifeline[SECONDARY_PHONE_NO];
        self.email = lifeline[EMAIL];
    }
    
    return self;
}

/* Default initializer calls the new designated initializer initWithData */
-(id)init
{
    self = [self initWithLifeLine:nil];
    return self;
}

+ (id) lifeLineWithDict:( NSDictionary *)dictionary{
    return [[self alloc]initWithLifeLine:dictionary];
}

@end

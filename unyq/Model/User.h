//
//  User.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * idUser;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSString * clinic_name;
@property (nonatomic, retain) NSString * bill_street;
@property (nonatomic, retain) NSString * bill_city;
@property (nonatomic, retain) NSString * bill_country;
@property (nonatomic, retain) NSString * bill_zipcode;
@property (nonatomic, retain) NSString * bill_contact;
@property (nonatomic, retain) NSString * bill_phone;
@property (nonatomic, retain) NSString * ship_street;
@property (nonatomic, retain) NSString * ship_city;
@property (nonatomic, retain) NSString * ship_country;
@property (nonatomic, retain) NSString * ship_zipcode;
@property (nonatomic, retain) NSString * ship_contact;
@property (nonatomic, retain) NSString * ship_phone;
@property (nonatomic, retain) NSString * vat;
@property (nonatomic, retain) NSString * cpo_name;
@property (nonatomic, retain) NSString * cpo_email;
@property (nonatomic, retain) NSString * admin_name;
@property (nonatomic, retain) NSString * admin_email;

@end

//
//  Order.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 2/10/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Order : NSManagedObject

@property (nonatomic, retain) NSString * amp_side;
@property (nonatomic, retain) NSString * colour1;
@property (nonatomic, retain) NSString * colour2;
@property (nonatomic, retain) NSString * colour3;
@property (nonatomic, retain) NSString * cover;
@property (nonatomic, retain) NSString * cpo_name;
@property (nonatomic, retain) NSString * hub;
@property (nonatomic, retain) NSString * idOrder;
@property (nonatomic, retain) NSString * knee_ankle_axis;
@property (nonatomic, retain) NSString * low_calf;
@property (nonatomic, retain) NSString * max_calf;
@property (nonatomic, retain) NSString * mid_calf;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * order_date;
@property (nonatomic, retain) NSString * patient;
@property (nonatomic, retain) NSString * recept_date;
@property (nonatomic, retain) NSString * serialnumber;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * top_calf;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * estimated_date;

@end

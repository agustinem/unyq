//
//  BDService.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@class Order,SDZUserWS,User;


@interface BDService : NSObject

@property   NSManagedObjectContext *context;

+(BDService *)instance;

-(User *)getUSer:(NSString *)idUser;

-(Order *)getOrder:(NSString *)idOrder;

-(NSArray *)getOrders;

-(void)addUser:(SDZUserWS *)user;

-(void)addOrders:(NSArray *)orders;

-(void)addPhotos;

-(NSArray *)getModelsBySection:(NSString *)section;

-(NSArray *)getColorsByModel:(NSString *)section model:(NSString *)model;

@end

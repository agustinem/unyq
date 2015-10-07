//
//  WSService.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@class SDZUserWS;

@interface WSService : NSObject

+(WSService *)instance;

-(void)editOrder:(id)object;

-(void)editUser:(id)object user:(User *)user;

-(void)getAllOrder:(id)object;

-(void)getAllOrderByUser:(id)object;

-(void)getOrderById:(id)object;

-(void)getUserById:(id)object;

-(void)login:(id)object;

-(void)registerDevice:(id)object;

@end

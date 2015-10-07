//
//  WSService.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 19/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "WSService.h"
#import "SDZWsclassService.h"
#import "Constants.h"
#import "SDZOrderrWS.h"
#import "User.h"
#import "BDService.h"

@interface WSService()

@property id currentController;

@end

@implementation WSService

static SDZWsclassService *service;

+(WSService *)instance{
    static WSService * wsservice = nil;
    if(wsservice== nil){
        wsservice = [[WSService alloc] init];
        service =  [SDZWsclassService service];
#ifdef DEBUG
        service.logging = YES;
#endif
    }
    return wsservice;
}

-(void)editOrder:(id)object{
    //current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"es"]];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    _currentController = object;
    SDZOrderrWS *order=[[Util loadObjects:fileObjects] objectAtIndex:0];
    if([UtilConnection checkConnection]){
        [service editOrderr:object action:@selector(editOrderrHandler:) email:[Util loadKey:kIdUser]  password: kPass id: @"" type: [Util loadKey:kMode] hub: order.hub patient: order.patient cpo_name: order.cpo_name order_date: stringFromDate recept_date: @"" cover: order.cover model: order.model colour1: order.colour1 colour2: order.colour2 colour3: order.colour3 amp_side: order.amp_side top_calf: order.top_calf max_calf: order.max_calf mid_calf: order.mid_calf low_calf: order.low_calf knee_ankle_axis: order.knee_ankle_axis];
    }
}

// Returns SDZUserWS*
/*  */
-(void)editUser:(id)object user:(User *)user{
    _currentController = object;
    if([UtilConnection checkConnection]){
        [service editUser:object action:@selector(editUserHandler:) id: user.idUser password: kPass user: user.user clinic_name: user.clinic_name bill_street: user.bill_street bill_city: user.bill_city bill_country: user.bill_country bill_zipcode: user.bill_zipcode bill_contact: user.bill_contact bill_phone: user.bill_phone ship_street: user.ship_street ship_city: user.ship_city ship_country: user.ship_country ship_zipcode: user.ship_zipcode ship_contact: user.ship_contact ship_phone: user.ship_phone vat: user.vat cpo_name: user.cpo_name cpo_email: user.cpo_email admin_name: nil admin_email: nil];
    }
}

// Returns SDZArrayOfOrderr*
/*  */
-(void)getAllOrder:(id)object{
    if([UtilConnection checkConnection]){
        [service getAllOrderr:self action:@selector(getAllOrderrHandler:) email: [Util loadKey:kIdUser] password: kPass fechaUltComp: @""];
    }
}

// Returns SDZArrayOfOrderr*
/*  */
-(void)getAllOrderByUser:(id)object{
    _currentController = object;
    if([UtilConnection checkConnection]){
        [service getAllOrderrByIduser:_currentController action:@selector(getAllOrderrByIduserHandler:) email: [Util loadKey:kIdUser] password: kPass fechaUltComp: @""];
    }
}

// Returns SDZOrderrWS*
/*  */
-(void)getOrderById:(id)object{
    _currentController = object;
    if([UtilConnection checkConnection]){
        [service getOrderrById:self action:@selector(getOrderrByIdHandler:) email: [Util loadKey:kIdUser] password: kPass idOrderr: @""];
    }
}

// Returns SDZUserWS*
/*  */
-(void)getUserById:(id)object{
    _currentController = object;
    if([UtilConnection checkConnection]){
        [service getUserById:object action:@selector(getUserByIdHandler:) email: [Util loadKey:kIdUser] password: kPass idUser: @""];
    }
}
// Returns NSString*
/*  */
-(void)login:(id)object{
    _currentController = object;
    if([UtilConnection checkConnection]){
        [service login:self action:@selector(loginHandler:) email: [Util loadKey:kIdUser] password: @""];
    }
}
// Returns NSString*
/* Datos necesarios para enviar notificacion
 */
-(void)registerDevice:(id)object{
    _currentController = object;    
    if([UtilConnection checkConnection]){
        NSString *deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        [service registerDevice:object action:@selector(registerDeviceHandler:) email: @"" password: kPass deviceId: deviceID sistema: @"ios" idioma: @"en" version: @"v0"];
    }
}

-(bool)checkErrors:(id)value{
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        [JTProgressHUD hide];
        [Util alertErrorRecibiendo:_currentController];
        return true;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        [JTProgressHUD hide];
        [Util  alertErrorConexion:_currentController];
        return true;
    }
    return false;
    
}

@end

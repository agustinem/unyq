/*
	SDZWsclassService.h
	The interface definition of classes and methods for the WsclassService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				
#import "SDZArrayOfOrderrws.h"
#import "SDZArrayOfOrderr.h"
#import "SDZArrayOfOrderstatews.h"
#import "SDZArrayOfOrderstate.h"
#import "SDZArrayOfUserws.h"
#import "SDZArrayOfUser.h"
#import "SDZUserWS.h"
#import "SDZOrderrWS.h"
#import "SDZOrderstateWS.h"

/* Interface for the service */
				
@interface SDZWsclassService : SoapService
		
	// Returns NSString*
	/*  */
	-(SoapRequest*)login:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password;
	-(SoapRequest*)login:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password;
	-(SoapRequest*)loginWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns SDZArrayOfOrderr*
	/*  */
	-(SoapRequest*)getAllOrderr:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password fechaUltComp: (NSString*) fechaUltComp;
	-(SoapRequest*)getAllOrderr:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password fechaUltComp: (NSString*) fechaUltComp;
	-(SoapRequest*)getAllOrderrWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password fechaUltComp: (NSString*) fechaUltComp completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns SDZOrderrWS*
	/*  */
	-(SoapRequest*)getOrderrById:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password idOrderr: (NSString*) idOrderr;
	-(SoapRequest*)getOrderrById:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password idOrderr: (NSString*) idOrderr;
	-(SoapRequest*)getOrderrByIdWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password idOrderr: (NSString*) idOrderr completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns SDZOrderrWS*
	/*  */
	-(SoapRequest*)editOrderr:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password id: (NSString*) _id type: (NSString*) type hub: (NSString*) hub patient: (NSString*) patient cpo_name: (NSString*) cpo_name order_date: (NSString*) order_date recept_date: (NSString*) recept_date cover: (NSString*) cover model: (NSString*) model colour1: (NSString*) colour1 colour2: (NSString*) colour2 colour3: (NSString*) colour3 amp_side: (NSString*) amp_side top_calf: (NSString*) top_calf max_calf: (NSString*) max_calf mid_calf: (NSString*) mid_calf low_calf: (NSString*) low_calf knee_ankle_axis: (NSString*) knee_ankle_axis;
	-(SoapRequest*)editOrderr:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password id: (NSString*) _id type: (NSString*) type hub: (NSString*) hub patient: (NSString*) patient cpo_name: (NSString*) cpo_name order_date: (NSString*) order_date recept_date: (NSString*) recept_date cover: (NSString*) cover model: (NSString*) model colour1: (NSString*) colour1 colour2: (NSString*) colour2 colour3: (NSString*) colour3 amp_side: (NSString*) amp_side top_calf: (NSString*) top_calf max_calf: (NSString*) max_calf mid_calf: (NSString*) mid_calf low_calf: (NSString*) low_calf knee_ankle_axis: (NSString*) knee_ankle_axis;
	-(SoapRequest*)editOrderrWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password id: (NSString*) _id type: (NSString*) type hub: (NSString*) hub patient: (NSString*) patient cpo_name: (NSString*) cpo_name order_date: (NSString*) order_date recept_date: (NSString*) recept_date cover: (NSString*) cover model: (NSString*) model colour1: (NSString*) colour1 colour2: (NSString*) colour2 colour3: (NSString*) colour3 amp_side: (NSString*) amp_side top_calf: (NSString*) top_calf max_calf: (NSString*) max_calf mid_calf: (NSString*) mid_calf low_calf: (NSString*) low_calf knee_ankle_axis: (NSString*) knee_ankle_axis completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns SDZArrayOfOrderr*
	/*  */
	-(SoapRequest*)getAllOrderrByIduser:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password fechaUltComp: (NSString*) fechaUltComp;
	-(SoapRequest*)getAllOrderrByIduser:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password fechaUltComp: (NSString*) fechaUltComp;
	-(SoapRequest*)getAllOrderrByIduserWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password fechaUltComp: (NSString*) fechaUltComp completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns NSString*
	/*  */
	-(SoapRequest*)sendPhoto:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password idorder: (NSString*) idorder nombre: (NSString*) nombre image: (NSString*) image;
	-(SoapRequest*)sendPhoto:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password idorder: (NSString*) idorder nombre: (NSString*) nombre image: (NSString*) image;
	-(SoapRequest*)sendPhotoWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password idorder: (NSString*) idorder nombre: (NSString*) nombre image: (NSString*) image completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns SDZUserWS*
	/*  */
	-(SoapRequest*)getUserById:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password idUser: (NSString*) idUser;
	-(SoapRequest*)getUserById:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password idUser: (NSString*) idUser;
	-(SoapRequest*)getUserByIdWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password idUser: (NSString*) idUser completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns SDZUserWS*
	/*  */
	-(SoapRequest*)editUser:(id<SoapDelegate>)handler id: (NSString*) _id password: (NSString*) password user: (NSString*) user clinic_name: (NSString*) clinic_name bill_street: (NSString*) bill_street bill_city: (NSString*) bill_city bill_country: (NSString*) bill_country bill_zipcode: (NSString*) bill_zipcode bill_contact: (NSString*) bill_contact bill_phone: (NSString*) bill_phone ship_street: (NSString*) ship_street ship_city: (NSString*) ship_city ship_country: (NSString*) ship_country ship_zipcode: (NSString*) ship_zipcode ship_contact: (NSString*) ship_contact ship_phone: (NSString*) ship_phone vat: (NSString*) vat cpo_name: (NSString*) cpo_name cpo_email: (NSString*) cpo_email admin_name: (NSString*) admin_name admin_email: (NSString*) admin_email;
	-(SoapRequest*)editUser:(id)target action:(SEL)action id: (NSString*) _id password: (NSString*) password user: (NSString*) user clinic_name: (NSString*) clinic_name bill_street: (NSString*) bill_street bill_city: (NSString*) bill_city bill_country: (NSString*) bill_country bill_zipcode: (NSString*) bill_zipcode bill_contact: (NSString*) bill_contact bill_phone: (NSString*) bill_phone ship_street: (NSString*) ship_street ship_city: (NSString*) ship_city ship_country: (NSString*) ship_country ship_zipcode: (NSString*) ship_zipcode ship_contact: (NSString*) ship_contact ship_phone: (NSString*) ship_phone vat: (NSString*) vat cpo_name: (NSString*) cpo_name cpo_email: (NSString*) cpo_email admin_name: (NSString*) admin_name admin_email: (NSString*) admin_email;
	-(SoapRequest*)editUserWithProgress:(SoapRequestProgressBlock)progressBlock id: (NSString*) _id password: (NSString*) password user: (NSString*) user clinic_name: (NSString*) clinic_name bill_street: (NSString*) bill_street bill_city: (NSString*) bill_city bill_country: (NSString*) bill_country bill_zipcode: (NSString*) bill_zipcode bill_contact: (NSString*) bill_contact bill_phone: (NSString*) bill_phone ship_street: (NSString*) ship_street ship_city: (NSString*) ship_city ship_country: (NSString*) ship_country ship_zipcode: (NSString*) ship_zipcode ship_contact: (NSString*) ship_contact ship_phone: (NSString*) ship_phone vat: (NSString*) vat cpo_name: (NSString*) cpo_name cpo_email: (NSString*) cpo_email admin_name: (NSString*) admin_name admin_email: (NSString*) admin_email completion:(SoapRequestCompletionBlock)completionBlock;

	// Returns NSString*
	/* Datos necesarios para enviar notificacion
			 */
	-(SoapRequest*)registerDevice:(id<SoapDelegate>)handler email: (NSString*) email password: (NSString*) password deviceId: (NSString*) deviceId sistema: (NSString*) sistema idioma: (NSString*) idioma version: (NSString*) version;
	-(SoapRequest*)registerDevice:(id)target action:(SEL)action email: (NSString*) email password: (NSString*) password deviceId: (NSString*) deviceId sistema: (NSString*) sistema idioma: (NSString*) idioma version: (NSString*) version;
	-(SoapRequest*)registerDeviceWithProgress:(SoapRequestProgressBlock)progressBlock email: (NSString*) email password: (NSString*) password deviceId: (NSString*) deviceId sistema: (NSString*) sistema idioma: (NSString*) idioma version: (NSString*) version completion:(SoapRequestCompletionBlock)completionBlock;

		
	+ (SDZWsclassService*) service;
	+ (SDZWsclassService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	
//
//  Constants.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JTProgressHUD/JTProgressHUD.h>
#import "UtilConnection.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface Constants : NSObject


#pragma mark - constantes para almacenar datos en memoria del teléfono
extern NSString * const kUser;
extern NSString * const kPass;
extern NSString * const kIsFirstLogin;
extern NSString * const kRegisterDevice;
extern NSString * const kSelectForm;
extern NSString * const kMode;
extern NSString * const kLeg;
extern NSString * const kIdUser;
extern NSString * const kMeas;



#pragma mark - constantes para identeficar las aristas que unen las pantallas
extern NSString * const segueSelectDemo;
extern NSString * const segueSelectMeasure;
extern NSString * const segueSelectLeg;
extern NSString * const segueStep1;
extern NSString * const segueStep1Detail;
extern NSString * const segueStep2;
extern NSString * const segueStep3;
extern NSString * const segueStep4;


#pragma mark - constantes para identeficar los controllers que unen las pantallas
extern NSString * const controllerRegister;


#pragma mark - constantes para identeficar notificaciones


#pragma mark - memoria local para objetos
extern NSString * const fileObjects;

#pragma mark - Varios
extern NSString * const serviceURL;
extern NSString * const URLVideo;
extern NSString * const URLGuide;
extern NSString * const modeDemo;
extern NSString * const modePatient;
extern NSString * const leftLeg;
extern NSString * const rightLeg;
extern NSString * const measCM;
extern NSString * const measIN;
extern NSString * const URLDolars;
extern NSString * const URLEuros ;
extern NSString * const URLVideoAK ;
extern NSString * const URLGuideAK;
extern NSString * const URLVideo;
extern NSString * const URLGuide;
extern NSString * const URLGuideBKMini;
extern NSString * const URLVideoBKMini;



@end

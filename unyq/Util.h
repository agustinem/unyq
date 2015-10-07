//
//  Util.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Photos;
@class UIView;
@interface Util : NSObject



#pragma mark - almacena y carga en memoria local
+(void)saveKey:(NSString *)key value:(id)value;
+(id)loadKey:(NSString *)key;
#pragma mark - almacena y carga en memoria local un objeto custom (necesitará implementar decoder, coder)
+(void)saveObject:(id)object file:(NSString *)file;
+(NSArray *)loadObjects:(NSString *)file;

#pragma mark -alerts
+(void)alertInfo:(id)controller title:(NSString *)title text:(NSString *)text;
+(void)alertErrorConexion:(id)controller;
+(void)alertErrorRecibiendo:(id)controller;

+(NSArray *)getRenders;


#pragma mark -views effets
+(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;

#pragma mark -propios de la app
+(NSString *)convertCover:(NSString *)cover;

+(void)sendLocalNotification:(NSString *)state;

#pragma mark - files (read/write/remove)
+(void)removeImage:(NSString *)imageFile;
+(NSData *)readImageFromFile:(NSString *)imageFile;
+(void) writeImageToFile:(NSString *)imageFile image:(NSData *)data;
@end

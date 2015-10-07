//
//  Util.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "Util.h"


@import UIKit;
@implementation Util


+(void)saveKey:(NSString *)key value:(id)value{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+(id)loadKey:(NSString *)key{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//el objeto es decoder o encoder
+(void)saveObject:(id)object file:(NSString *)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:file];
    NSMutableArray *myObject=[NSMutableArray array];
    [myObject addObject:object];
    [NSKeyedArchiver archiveRootObject:myObject toFile:appFile];

}

+(NSArray *)loadObjects:(NSString *)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:file];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:appFile];
}


#pragma mark -alerts
+(void)alertInfo:(id)controller title:(NSString *)title text:(NSString *)text{
    UIAlertController *alertController =    [UIAlertController
                                             alertControllerWithTitle:title
                                             message:text
                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    [alertController addAction:cancelAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void)alertErrorConexion:(id)controller{
    UIAlertController *alertController =    [UIAlertController
                                             alertControllerWithTitle:@"Oops!"
                                             message:@"Connection error, try again please."
                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    [alertController addAction:cancelAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void)alertErrorRecibiendo:(id)controller{
    UIAlertController *alertController =    [UIAlertController
                                             alertControllerWithTitle:@"Oops!"
                                             message:@"Server conexion error"
                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    [alertController addAction:cancelAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(NSString *)convertCover:(NSString *)cover{
    if([cover isEqualToString:@"AK"])
        return @"ak";
    if([cover isEqualToString:@"BK"])
        return @"bk";
    if([cover isEqualToString:@"BK mini"])
        return @"bkmini";
    return @"";
}

+(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0 -2;
    roundedView.clipsToBounds= YES;
    roundedView.center = saveCenter;
}

+(void)sendLocalNotification:(NSString *)state{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendEnd" object:nil];
    NSString *text;
    if([state isEqualToString:@"OK"]){
        text = @"photo upload completed successfully";
    }else{
        text = @"photo upload completed with errors";
    }
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    localNotification.alertBody = text;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];                
}


+(void) writeImageToFile:(NSString *)imageFile image:(NSData *)data{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:[imageFile stringByAppendingString:@".txt"]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:appFile]) {
        [[NSFileManager defaultManager] createFileAtPath:appFile contents:nil attributes:nil];
    }
    bool isOK = [data writeToFile:appFile atomically:YES];

}


+(NSData *)readImageFromFile:(NSString *)imageFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:[imageFile stringByAppendingString:@".txt"]];
    NSData *data = [NSData dataWithContentsOfFile:appFile];
    return data;
}

+ (void)removeImage:(NSString *)imageFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:[imageFile stringByAppendingString:@".txt"]];
    NSError *error;
    bool isOk=[fileManager removeItemAtPath:appFile error:&error];
}

@end

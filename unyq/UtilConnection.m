//
//  UtilConnection.m
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import "UtilConnection.h"
#import <FXReachability/FXReachability.h>
#import "AppDelegate.h"
#import "Constants.h"
@interface UtilConnection()

@property NSMutableDictionary *responsesData;
@property int max ;
@end

@implementation UtilConnection

static UIImagePickerController *picker;

+(UtilConnection *)instance{
    static UtilConnection *connection = nil;
    if(connection ==nil){
        connection = [UtilConnection new];
        connection.responsesData = [NSMutableDictionary new];
        connection.session = [connection backgroundSession];
        connection.max = 0;
    }
    return connection;
}


+(UIImagePickerController *)getPicker{
    
    if(picker ==nil){
        picker = [[UIImagePickerController alloc] init];
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        picker.showsCameraControls = NO;        
    }
    return picker;
}

+(bool)checkConnection{
    if([FXReachability isReachable])
        return true;
    else{
        [[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"No internet reachability" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return false;
    }
}

- (NSURLSession *)backgroundSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.unyq.singecast.BackgroundSession"];
        session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    });
    return session;
}

- (void)sendPhoto:(NSString *)email pass:(NSString *)pass idorder:(NSString *)idOrder nombre:(NSString *)nombre imagen:(NSData *)imagen{
    if(imagen!=nil){
    NSMutableDictionary *photoJson = [[NSMutableDictionary alloc] init];
    [photoJson setObject:email forKey:@"email"];
    [photoJson setObject:pass forKey:@"pass"];
    [photoJson setObject:idOrder forKey:@"idorder"];
    [photoJson setObject:nombre forKey:@"nombre"];
    
    NSMutableDictionary *registroJson = [[NSMutableDictionary alloc] init];
    [registroJson setObject:@"sendPhoto" forKey:@"service"];
    [registroJson setObject:photoJson forKey:@"args"];
    //NSLog(@"login json : %@",loginJson);
    NSMutableDictionary *finalJson = [[NSMutableDictionary alloc] init];
    [finalJson setObject:registroJson forKey:@"data"];
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:registroJson options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    [self doPostWithJson:json andImage:imagen nombreImagen:nombre];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendEnd" object:nil];
          [Util sendLocalNotification:@"KO"];
    }
}

- (void) doPostWithJson:(NSString *)textos andImage:(NSData *)data nombreImagen:(NSString*)nombreImg
{
    NSString *urlString = @"http://unyq.kometadev.com/main/sendPhoto";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"imagen%d\"; filename=\"%@\"\r\n", 0, nombreImg] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n",textos] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    NSURLSessionTask *task = [self.session uploadTaskWithRequest:request fromFile:nil];
    [task resume];
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if(data == nil){
          [[NSNotificationCenter defaultCenter] postNotificationName:@"sendEnd" object:nil];
      [Util sendLocalNotification:@"KO"];
    } else{
    NSMutableData *responseData = self.responsesData[@(dataTask.taskIdentifier)];
    if (!responseData) {
        responseData = [NSMutableData dataWithData:data];
        self.responsesData[@(dataTask.taskIdentifier)] = responseData;
    } else {
        [responseData appendData:data];
    }
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        [Util sendLocalNotification:@"KO"];
        NSLog(@"%@ failed: %@", task.originalRequest.URL, error);
    }
    NSMutableData *responseData =  self.responsesData[@(task.taskIdentifier)];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    if (response) {
        NSLog(@"response = %@", response);
    } else {
        NSString *responseDataS =[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData = %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        //número de pedido es la respuesta del WS es que TODO OK y envío la siguiente
        //aviso de que ya se ha enviado para actualizar el progressbar
        //compruebo si es la última
        //vacío el directorio de la foto que se ha subido
        //actualizo valores
        //envío
        if([responseDataS isEqualToString:[Util loadKey:@"order_photoSend"]] ){
           
            NSString *currentPhoto = [Util loadKey:@"currentFoto"];
            if ([currentPhoto isEqualToString:[Util loadKey:@"totalFotos"]]) {
                
                [Util sendLocalNotification:@"OK"];
            }else{
                NSString *nextPhoto = [NSString stringWithFormat:@"%d",[currentPhoto intValue]+1];
                [Util saveKey:@"currentFoto" value:nextPhoto];
                
                //                [self sendPhoto:[Util loadKey:kIdUser] pass:@"lacasita" idorder:[Util loadKey:@"order_photoSend"] nombre:nextPhoto imagen:[Util readImageFromFile:nextPhoto]];

                
                PHAsset *asset = [_assetsFetchResult objectAtIndex:[currentPhoto intValue]+1];
                PHImageManager * imageManager = [[PHCachingImageManager alloc] init];
                [imageManager requestImageDataForAsset:asset options:PHImageRequestOptionsVersionCurrent resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                    [[UtilConnection instance ]sendPhoto:[Util loadKey:kIdUser]  pass:@"lacasita" idorder:[Util loadKey:@"order_photoSend"] nombre:nextPhoto imagen:imageData];
                }];

                
            }
        }
    }
    [self.responsesData removeObjectForKey:@(task.taskIdentifier)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"sendOK" object:nil];
    });
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    AppDelegate *appDelegate =    (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.sessionCompletionHandler) {
        void (^completionHandler)() =
            appDelegate.sessionCompletionHandler;
            appDelegate.sessionCompletionHandler = nil;
            completionHandler();
    }
    NSLog(@"Task complete");
}

@end

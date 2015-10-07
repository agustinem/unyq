//
//  UtilConnection.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 18/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//


@import Foundation;
#import "Util.h"
@import Photos;
typedef void (^CompletionHandlerType)();

@interface UtilConnection : Util <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (strong, nonatomic) NSURLSession *session;
@property  PHFetchResult *assetsFetchResult ;
+(UtilConnection *)instance;

+(UIImagePickerController *)getPicker;


- (void)sendPhoto:(NSString *)email pass:(NSString *)pass idorder:(NSString *)idOrder nombre:(NSString *)nombre imagen:(NSData *)imagen;

+(bool)checkConnection;
@end

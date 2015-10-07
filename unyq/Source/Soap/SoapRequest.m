/*
 SoapRequest.m
 Implementation of the request object used to manage asynchronous requests.
 Author:	Jason Kichline, Mechanicsburg, Pennsylvania USA
 */

#import "SoapRequest.h"
#import "SoapArray.h"
#import "SoapFault.h"
#import "Soap.h"
#import <objc/message.h>

NSString* const SoapRequestDidStartNotification = @"SoapRequestDidStartNotification";
NSString* const SoapRequestDidUpdateProgressNotification = @"SoapRequestDidUpdateProgressNotification";
NSString* const SoapRequestDidFinishNotification = @"SoapRequestDidFinishNotification";
NSString* const SoapRequestDidFailNotification = @"SoapRequestDidFailNotification";
NSString* const SoapRequestProgressKey = @"progress";

#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

@implementation SoapRequest

@synthesize handler, url, soapAction, postData, receivedData, username, password, deserializeTo, action, logging, defaultHandler, completionBlock, progressBlock;

// Creates a request to submit from discrete values.

+(SoapRequest*)createWithURL:(NSURL*)url soapAction:(NSString*)soapAction postData:(NSString*)postData deserializeTo:(id)deserializeTo completionBlock:(SoapRequestCompletionBlock)completionBlock {
	SoapRequest* request = [[SoapRequest alloc] init];
	request.url = url;
	request.soapAction = soapAction;
	request.postData = postData;
	request.completionBlock = completionBlock;
	request.deserializeTo = deserializeTo;
	request.handler = nil;
	request.action = nil;
	request.defaultHandler = nil;
	return request;
}

+(SoapRequest*)createWithService:(SoapService*)service soapAction:(NSString*)soapAction postData:(NSString*)postData deserializeTo:(id) deserializeTo completionBlock:(SoapRequestCompletionBlock)completionBlock {
	SoapRequest* request = [SoapRequest createWithURL:[NSURL URLWithString:service.serviceUrl] soapAction:soapAction postData:postData deserializeTo:deserializeTo completionBlock:completionBlock];
	request.defaultHandler = service.defaultHandler;
	request.logging = service.logging;
	request.username = service.username;
	request.password = service.password;
	return request;
}

+(SoapRequest*)create:(SoapHandler*)handler urlString:(NSString*)urlString soapAction:(NSString*)soapAction postData:(NSString*)postData deserializeTo:(id)deserializeTo {
	return [SoapRequest create:handler action:nil urlString:urlString soapAction:soapAction postData:postData deserializeTo:deserializeTo];
}

+(SoapRequest*)create:(SoapHandler*)handler action:(SEL)action urlString:(NSString*)urlString soapAction:(NSString*)soapAction postData:(NSString*)postData deserializeTo:(id)deserializeTo {
	SoapRequest* request = [[SoapRequest alloc] init];
	request.url = [NSURL URLWithString: urlString];
	request.soapAction = soapAction;
	request.postData = postData;
	request.handler = handler;
	request.deserializeTo = deserializeTo;
	request.action = action;
	request.defaultHandler = nil;
	return request;
}

+(SoapRequest*)create:(SoapHandler*)handler action:(SEL)action service:(SoapService*)service soapAction:(NSString*)soapAction postData:(NSString*)postData deserializeTo:(id)deserializeTo {
	SoapRequest* request = [SoapRequest create:handler action:action urlString:service.serviceUrl soapAction:soapAction postData:postData deserializeTo:deserializeTo];
	request.defaultHandler = service.defaultHandler;
	request.logging = service.logging;
	request.username = service.username;
	request.password = service.password;
	return request;
}

// Sends the request via HTTP.
- (void) send {
	
	// If we don't have a handler, create a default one
	if(handler == nil) {
		handler = [[SoapHandler alloc] init];
	}
	
	// Make sure the network is available
	if([SoapReachability connectedToNetwork] == NO) {
		NSError* error = [NSError errorWithDomain:@"SudzC" code:400 userInfo:[NSDictionary dictionaryWithObject:@"The network is not available" forKey:NSLocalizedDescriptionKey]];
		[self handleError: error];
	}
	
	// Make sure we can reach the host
	if([SoapReachability hostAvailable:url.host] == NO) {
		NSError* error = [NSError errorWithDomain:@"SudzC" code:410 userInfo:[NSDictionary dictionaryWithObject:@"The host is not available" forKey:NSLocalizedDescriptionKey]];
		[self handleError: error];
	}
	
	// Output the URL if logging is enabled
	if(logging) {
		NSLog(@"Loading: %@", url.absoluteString);
	}
	
	// Create the request
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
	if(soapAction != nil) {
		[request addValue: soapAction forHTTPHeaderField: @"SOAPAction"];
	}
	if(postData != nil) {
		[request setHTTPMethod: @"POST"];
		[request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField: @"Content-Type"];
		[request setHTTPBody: [postData dataUsingEncoding: NSUTF8StringEncoding]];
		if(self.logging) {
			NSLog(@"%@", postData);
		}
	}
	
	// Create the connection
	conn = [[NSURLConnection alloc] initWithRequest: request delegate: self];
	if(conn) {
		receivedData = [NSMutableData data];
	} else {
		// We will want to call the onerror method selector here...
		if(self.handler != nil) {
			NSError* error = [NSError errorWithDomain:@"SoapRequest" code:404 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"Could not create connection", NSLocalizedDescriptionKey,nil]];
			[self handleError: error];
		}
	}
}

-(void)handleError:(NSError*)error {
	// If we've registered a block, use that
	if(completionBlock) {
		completionBlock(NO, nil, nil, error); return;
	}

	SEL onerror = @selector(onerror:);
	if(self.action != nil) { onerror = self.action; }
	if([self.handler respondsToSelector: onerror]) {
		SuppressPerformSelectorLeakWarning([self.handler performSelector:onerror withObject:error]);
	} else {
		if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:onerror]) {
			SuppressPerformSelectorLeakWarning([self.defaultHandler performSelector:onerror withObject:error]);
		}
	}
	if(self.logging) {
		NSLog(@"Error: %@", error.localizedDescription);
	}
}

-(void)handleFault:(SoapFault*)fault {
	
	// If we've registered a block, use that
	if(completionBlock) {
		completionBlock(NO, nil, fault, nil); return;
	}

	if([self.handler respondsToSelector:@selector(onfault:)]) {
		[self.handler onfault: fault];
	} else if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:@selector(onfault:)]) {
		[self.defaultHandler onfault:fault];
	}
	if(self.logging) {
		NSLog(@"Fault: %@", fault);
	}
}

-(void)handleSuccess:(id)output {

	// If we've registered a block, use that
	if(completionBlock) {
		completionBlock(YES, output, nil, nil); return;
	}

	if(self.action == nil) { self.action = @selector(onload:); }
	if(self.handler != nil && [self.handler respondsToSelector: self.action]) {
		SuppressPerformSelectorLeakWarning([self.handler performSelector:self.action withObject:output]);
	} else if(self.defaultHandler != nil && [self.defaultHandler respondsToSelector:@selector(onload:)]) {
		[self.defaultHandler onload:output];
	}
}

// Called when the HTTP socket gets a response.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.receivedData setLength:0];
	if([response isKindOfClass:[NSHTTPURLResponse class]]) {
		expectedContentLength = [(NSHTTPURLResponse*)response expectedContentLength];
	} else {
		expectedContentLength = 0;
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:SoapRequestDidStartNotification object:self userInfo:nil];
	if(expectedContentLength > 0) {
		[[NSNotificationCenter defaultCenter] postNotificationName:SoapRequestDidUpdateProgressNotification object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0], SoapRequestProgressKey, nil]];
	}
}

// Called when the HTTP socket received data.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)value {
    [self.receivedData appendData:value];
	if(expectedContentLength > 0) {
		float progress = ((float)expectedContentLength / (float)self.receivedData.length);
		if(progressBlock) {
			progressBlock(progress);
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:SoapRequestDidUpdateProgressNotification object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:progress], SoapRequestProgressKey, nil]];
	}
}

// Called when the HTTP request fails.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	conn = nil;
	[self handleError:error];
	[[NSNotificationCenter defaultCenter] postNotificationName:SoapRequestDidFailNotification object:self];
}

// Called when the connection has finished loading.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	// Send notifications that we are done
	[[NSNotificationCenter defaultCenter] postNotificationName:SoapRequestDidUpdateProgressNotification object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1], SoapRequestProgressKey, nil]];
	[[NSNotificationCenter defaultCenter] postNotificationName:SoapRequestDidFinishNotification object:self userInfo:nil];
	
	NSError* error;
	if(self.logging == YES) {
		NSString* response = [[NSString alloc] initWithData: self.receivedData encoding: NSUTF8StringEncoding];
		NSLog(@"%@", response);
	}
	
	CXMLDocument* doc = [[CXMLDocument alloc] initWithData: self.receivedData options: 0 error: &error];
	if(doc == nil) {
		[self handleError:error];
		return;
	}
	
	id output = nil;
	SoapFault* fault = [SoapFault faultWithXMLDocument: doc];
	
	if([fault hasFault]) {
		if(self.action == nil) {
			[self handleFault: fault];
		} else {
			if(self.handler != nil && [self.handler respondsToSelector: self.action]) {
				SuppressPerformSelectorLeakWarning([self.handler performSelector:self.action withObject:fault]);
			} else {
				NSLog(@"SOAP Fault: %@", fault);
			}
		}
	} else {
		CXMLNode* element = [[Soap getNode: [doc rootElement] withName: @"Body"] childAtIndex:0];
		if(deserializeTo == nil) {
			output = [Soap deserialize:element];
		} else {
			if([deserializeTo respondsToSelector: @selector(initWithNode:)]) {
				element = [element childAtIndex:0];
				output = [deserializeTo initWithNode: element];
			} else {
				NSString* value = [[[element childAtIndex:0] childAtIndex:0] stringValue];
				output = [Soap convert: value toType: deserializeTo];
			}
		}
		[self handleSuccess:output];
	}
	conn = nil;
}

// Called if the HTTP request receives an authentication challenge.
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if([challenge previousFailureCount] == 0) {
		NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:self.username password:self.password persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
		NSError* error = [NSError errorWithDomain:@"SoapRequest" code:403 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"Could not authenticate this request", NSLocalizedDescriptionKey,nil]];
		[self handleError:error];
    }
}

// Cancels the HTTP request.
- (BOOL) cancel {
	if(conn == nil) { return NO; }
	[conn cancel];
	conn = nil;
	return YES;
}

@end
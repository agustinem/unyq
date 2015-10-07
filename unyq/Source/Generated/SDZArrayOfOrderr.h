/*
	SDZArrayOfOrderr.h
	The interface definition of properties and methods for the SDZArrayOfOrderr object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class SDZArrayOfOrderrws;

@interface SDZArrayOfOrderr : SoapObject
{
	NSMutableArray* _orderrs;
	
}
		
	@property (retain, nonatomic) NSMutableArray* orderrs;

	+ (SDZArrayOfOrderr*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
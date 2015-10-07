/*
	SDZArrayOfOrderrws.h
	The implementation of properties and methods for the SDZArrayOfOrderrws array.
	Generated by SudzC.com
*/
#import "SDZArrayOfOrderrws.h"

#import "SDZOrderrWS.h"
@implementation SDZArrayOfOrderrws

	+ (id) createWithNode: (CXMLNode*) node
	{
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZOrderrWS* value = [[SDZOrderrWS createWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"OrderrWS"]];
		}
		return s;
	}
@end
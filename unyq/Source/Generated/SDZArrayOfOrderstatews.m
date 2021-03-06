/*
	SDZArrayOfOrderstatews.h
	The implementation of properties and methods for the SDZArrayOfOrderstatews array.
	Generated by SudzC.com
*/
#import "SDZArrayOfOrderstatews.h"

#import "SDZOrderstateWS.h"
@implementation SDZArrayOfOrderstatews

	+ (id) createWithNode: (CXMLNode*) node
	{
		return [[self alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZOrderstateWS* value = [[SDZOrderstateWS createWithNode: child] object];
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
			[s appendString: [item serialize: @"OrderstateWS"]];
		}
		return s;
	}
@end

/*
	SDZOrderrWS.h
	The interface definition of properties and methods for the SDZOrderrWS object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface SDZOrderrWS : SoapObject
{
	NSString* __id;
	NSString* _iduser;
	NSString* _type;
	NSString* _hub;
	NSString* _patient;
	NSString* _cpo_name;
	NSString* _order_date;
	NSString* _serial_number;
	NSString* _price;
	NSString* _status;
	NSString* _recept_date;
	NSString* _cover;
	NSString* _order_number;
	NSString* _model;
	NSString* _colour1;
	NSString* _colour2;
	NSString* _colour3;
	NSString* _amp_side;
	NSString* _top_calf;
	NSString* _max_calf;
	NSString* _mid_calf;
	NSString* _low_calf;
	NSString* _knee_ankle_axis;
	NSString* _pictures;
	NSString* _tracking;
	NSString* _shipping;
	NSString* _estimated_date;
	NSString* _int_observations;
	NSString* _ext_observations;
	
}
		
	@property (retain, nonatomic) NSString* _id;
	@property (retain, nonatomic) NSString* iduser;
	@property (retain, nonatomic) NSString* type;
	@property (retain, nonatomic) NSString* hub;
	@property (retain, nonatomic) NSString* patient;
	@property (retain, nonatomic) NSString* cpo_name;
	@property (retain, nonatomic) NSString* order_date;
	@property (retain, nonatomic) NSString* serial_number;
	@property (retain, nonatomic) NSString* price;
	@property (retain, nonatomic) NSString* status;
	@property (retain, nonatomic) NSString* recept_date;
	@property (retain, nonatomic) NSString* cover;
	@property (retain, nonatomic) NSString* order_number;
	@property (retain, nonatomic) NSString* model;
	@property (retain, nonatomic) NSString* colour1;
	@property (retain, nonatomic) NSString* colour2;
	@property (retain, nonatomic) NSString* colour3;
	@property (retain, nonatomic) NSString* amp_side;
	@property (retain, nonatomic) NSString* top_calf;
	@property (retain, nonatomic) NSString* max_calf;
	@property (retain, nonatomic) NSString* mid_calf;
	@property (retain, nonatomic) NSString* low_calf;
	@property (retain, nonatomic) NSString* knee_ankle_axis;
	@property (retain, nonatomic) NSString* pictures;
	@property (retain, nonatomic) NSString* tracking;
	@property (retain, nonatomic) NSString* shipping;
	@property (retain, nonatomic) NSString* estimated_date;
	@property (retain, nonatomic) NSString* int_observations;
	@property (retain, nonatomic) NSString* ext_observations;

	+ (SDZOrderrWS*) createWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
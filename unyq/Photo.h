//
//  Photo.h
//  unyq
//
//  Created by Agustín Embuena Majúa on 25/9/15.
//  Copyright (c) 2015 UNYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * color1;
@property (nonatomic, retain) NSString * color2;
@property (nonatomic, retain) NSString * color3;

@end

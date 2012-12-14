//
//  Person.h
//  TCDB2
//
//  Created by Colin Tremblay on 12/13/12.
//  Copyright (c) 2012 GrinnellAppDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *profilePic;
@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSMutableArray *attributeVals;
@property (nonatomic, strong) NSMutableArray *upcomingShifts;
@property (nonatomic, strong) NSMutableArray *upcomingShiftLocations;
@end

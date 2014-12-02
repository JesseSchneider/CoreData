//
//  CoreProducts.h
//  HardestCore
//
//  Created by JESSE SCHNEIDER on 10/24/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreProducts : NSManagedObject

@property (nonatomic, retain) NSString * productImage;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * productURL;
@property (nonatomic, retain) NSString * companyKey;

@end

//
//  CoreCompanies.h
//  HardestCore
//
//  Created by JESSE SCHNEIDER on 10/24/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreCompanies : NSManagedObject

@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSNumber * companyStockPrice;
@property (nonatomic, retain) NSString * primaryKey;
@property (nonatomic, retain) NSString * companyImage;

@end

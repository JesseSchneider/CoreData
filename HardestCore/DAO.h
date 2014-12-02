//
//  DAO.h
//  NavCtrl
//
//  Created by JESSE SCHNEIDER on 9/29/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"
#import "CoreCompanies.h"
#import "CoreProducts.h"
#import "AppDelegate.h"

@class AppDelegate;
@interface DAO : NSObject<NSURLConnectionDelegate>
{

}

@property (strong, nonatomic) NSMutableData *responseData;

@property (nonatomic, retain) NSMutableArray *companyList;

@property (nonatomic, retain) NSMutableArray *productList;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong,nonatomic) AppDelegate *appDelegate;


- (void) saveCompaniesToCoreData;

- (void) saveProductsToCoreData;

- (void) matchProductsToCompanies;

- (void) getData;

- (void)deleteData:(NSString *)productName;

@end

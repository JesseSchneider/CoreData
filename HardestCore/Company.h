//
//  Company.h
//  NavCtrl
//
//  Created by JESSE SCHNEIDER on 9/24/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface Company : UIViewController

@property (strong, nonatomic) NSString *companyId;
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSMutableArray *companyProducts;
@property (strong, nonatomic) NSString *companyImage;
@property (strong, nonatomic) NSNumber *companyStockPrice;

@end

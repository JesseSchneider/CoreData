//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by JESSE SCHNEIDER on 9/23/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#import "ChildViewController.h"

@class DAO;
@class ChildViewController;
@interface qcdDemoViewController : UITableViewController


@property (nonatomic, retain) NSMutableArray *companyList;

@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) NSString *companyStockPrice;

@property (nonatomic, retain) IBOutlet ChildViewController * childVC;

@property (strong, nonatomic) DAO * fileDAO;

@end

//
//  ChildViewController.h
//  NavCtrl
//
//  Created by JESSE SCHNEIDER on 9/23/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "Company.h"
#import "DAO.h"

@class DAO;
@interface ChildViewController : UITableViewController

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) WebViewController * webVC;

@property (nonatomic, strong) Company *company;

@property (strong, nonatomic) DAO * theDAO;

@end

//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by JESSE SCHNEIDER on 9/23/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import "qcdDemoViewController.h"
#import "ChildViewController.h"
#import "DAO.h"

@interface qcdDemoViewController ()

@property (nonatomic, retain) NSArray *images;

@end

@implementation qcdDemoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    //THIS IS WHERE MY DAO FILE IS BEING INSTANTIATED***********************************
}


// HERE IS WHERE WE ARE PULLING THE STOCK PRICES *************************

- (void)viewWillAppear:(BOOL)animated
{
// Create the request.
NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://finance.yahoo.com/d/quotes.csv?s=AAPL+SSNLF+AMZN+GOOG&f=l1"]];

// Create url connection and fire request
NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"%@",conn);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created so that we can append data to it in the didReceiveData method. Furthermore, this method is called each time there is a redirect so reinitializing it also serves to clear it.
    self.responseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.responseData appendData:data];
    
}

//Callback method that gets called when all of the data is recieved.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   //Coverting the NSData to a string.
    NSString *stockPrices = [[NSString alloc]
                            initWithData: self.responseData
                            encoding:NSUTF8StringEncoding];
    NSLog(@"%@", stockPrices);
    
   //Converting the NSString to an array.
    NSArray *newArray = [[NSArray alloc]init];
    newArray = [stockPrices componentsSeparatedByString:@"\n"];
    
   //Loop through the array at each index.
    NSInteger count = [newArray count] -1;
    for (int i = 0; i < count; i++) {
       [newArray objectAtIndex:i];
    
    //Created a new instance of the Company class called company and we set it equal to the companyList in our DAO file.
//    Company *company = [[Company alloc] init];
//       company = [self.fileDAO.companyList objectAtIndex:i];

    
    // Now we want to set the stock price for each company at index i. (ex. company at index 0 set equal to stock price at index 0) So we set our companyStockPrice property equal to newArray because that's where all of our stock prices are.
        [[self.fileDAO.companyList objectAtIndex:i] setCompanyStockPrice:[newArray objectAtIndex:i]];
        [self.tableView reloadData];
    }
    
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.fileDAO.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
//    Company *selectedCompany = [[Company alloc] init];
//    selectedCompany = [self.fileDAO.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.fileDAO.companyList objectAtIndex:[indexPath row]] companyName]];
    cell.imageView.image = [UIImage imageNamed:[[self.fileDAO.companyList objectAtIndex:[indexPath row]] companyImage]];
    cell.detailTextLabel.text = [[self.fileDAO.companyList objectAtIndex:[indexPath row]] companyStockPrice];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.childVC.company = [self.fileDAO.companyList objectAtIndex: indexPath.row];
    
//We have two references of our DAO. fileDAO in the parentVC and theDAO in our childVC. The problem is, we don't want 2 copies, but rather we want these two references to refer to the same instance. Now, instead of 2 copies, we have one DAO just with two different names (fileDAO and theDAO). To do this, we write the line of code on line 198...
    self.childVC.theDAO = self.fileDAO;
    
    
    [self.navigationController
     pushViewController:self.childVC
     animated:YES];
}

@end

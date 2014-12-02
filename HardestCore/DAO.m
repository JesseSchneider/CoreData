//
//  DAO.m
//  NavCtrl
//
//  Created by JESSE SCHNEIDER on 9/29/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import "DAO.h"

@interface DAO ()
{
}
@end

@implementation DAO

- (id) init

{
    return self;
}

-(void)getData{
    
//FETCH FOR COMPANIES FROM CORE DATA
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoreCompanies" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"primaryKey" ascending:YES];
    NSArray *sortDescriptor = [[NSArray alloc]initWithObjects:sort, nil];
    [fetchRequest setSortDescriptors:sortDescriptor];
    
    NSError * error;
    NSArray *coreCompanyArray = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];

//FETCH FOR PRODUCTS FROM CORE DATA
    NSFetchRequest *fetchRequestProd = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityProd = [NSEntityDescription entityForName:@"CoreProducts" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequestProd setEntity:entityProd];
    
    NSError * errorProd;
    NSArray *coreProductArray = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequestProd error:&errorProd];

// Using fast enumeration, we iterated through our Core Data companies and converted them back into regular companies.
    self.companyList = [[NSMutableArray alloc]init];
    for (CoreCompanies *coreComp in coreCompanyArray) {
        Company *comp = [[Company alloc]init];
        comp.companyName = coreComp.companyName;
        comp.companyImage = coreComp.companyImage;
        comp.companyStockPrice = coreComp.companyStockPrice;
        comp.companyId = coreComp.primaryKey;
        comp.companyProducts = [[NSMutableArray alloc]init];
        [self.companyList addObject:comp];
        
// Just testing..............................
        NSLog(@"%@", comp.companyName);
   
        [comp release];
    }
    
// Using fast enumeration, we iterated through our Core Data products and converted them back into regular products.
    self.productList = [[NSMutableArray alloc]init];
    for (CoreProducts *coreProd in coreProductArray) {
        Product *prod = [[Product alloc] init];
        prod.productName = coreProd.productName;
        prod.productImage = coreProd.productImage;
        prod.productURL = coreProd.productURL;
        prod.companyKey = coreProd.companyKey;
        [self.productList addObject:prod];
        
// Just testing..............................
        NSLog(@"%@", prod.productName);
        
        [prod release];
    }
    
    if (coreCompanyArray.count > 0 && coreProductArray.count > 0) {
        
        [self matchProductsToCompanies];
    }
    
   else
   {
    // APPLE
    
    Company *apple = [[Company alloc] init];
    apple.companyName = @"Apple";
    apple.companyImage = @"12.jpg";
    apple.companyId = @"1";
    apple.companyProducts = [[NSMutableArray alloc] init];
    
    Product *iPad = [[Product alloc]init];
    iPad.productName = @"iPad";
    iPad.productImage = @"0.jpg";
    iPad.companyKey = @"1";
    iPad.productURL = @"https://www.apple.com/ipad/";
    
    Product *iPodTouch = [[Product alloc]init];
    iPodTouch.productName = @"iPod Touch";
    iPodTouch.productImage = @"1.jpg";
    iPodTouch.companyKey = @"1";
    iPodTouch.productURL = @"http://www.apple.com/ipod/";
    
    Product *iPhone = [[Product alloc]init];
    iPhone.productName = @"iPhone";
    iPhone.productImage = @"2.jpg";
    iPhone.companyKey = @"1";
    iPhone.productURL = @"http://www.apple.com/iphone/";
    
    [apple.companyProducts addObject: iPad];
    [apple.companyProducts addObject: iPodTouch];
    [apple.companyProducts addObject: iPhone];
    
    // SAMSUNG
    
    Company *samsung = [[Company alloc] init];
    samsung.companyName = @"Samsung";
    samsung.companyImage = @"13.jpg";
    samsung.companyId = @"2";
    samsung.companyProducts = [[NSMutableArray alloc] init];
    
    Product *galaxyS4 = [[Product alloc] init];
    galaxyS4.productName = @"Galaxy S4";
    galaxyS4.productImage = @"3.jpg";
    galaxyS4.companyKey = @"2";
    galaxyS4.productURL = @"http://www.samsung.com/galaxys4/";
    
    Product *galaxyNote = [[Product alloc] init];
    galaxyNote.productName = @"Galaxy Note";
    galaxyNote.productImage = @"4.jpg";
    galaxyNote.companyKey = @"2";
    galaxyNote.productURL = @"http://www.samsung.com/galaxynote";
    
    Product *galaxyTab = [[Product alloc] init];
    galaxyTab.productName = @"Galaxy Tab";
    galaxyTab.productImage = @"5.jpg";
    galaxyTab.companyKey = @"2";
    galaxyTab.productURL = @"http://www.samsung.com/TabS";
    
    [samsung.companyProducts addObject: galaxyS4];
    [samsung.companyProducts addObject: galaxyNote];
    [samsung.companyProducts addObject: galaxyTab];
    
    // AMAZON
    
    Company *amazon = [[Company alloc] init];
    amazon.companyName = @"Amazon";
    amazon.companyImage = @"14.jpg";
    amazon.companyId = @"3";
    amazon.companyProducts = [[NSMutableArray alloc] init];
    
    Product *kindle = [[Product alloc] init];
    kindle.productName = @"Kindle";
    kindle.productImage = @"6.jpg";
    kindle.companyKey = @"3";
    kindle.productURL = @"https://kindle.amazon.com/";
    
    Product *firePhone = [[Product alloc] init];
    firePhone.productName = @"Fire Phone";
    firePhone.productImage = @"7.jpg";
    firePhone.companyKey = @"3";
    firePhone.productURL = @"https://www.amazon.com/Fire-Phone";
    
    Product *amazonTablet = [[Product alloc] init];
    amazonTablet.productName = @"Amazon Tablet";
    amazonTablet.productImage = @"8.jpg";
    amazonTablet.companyKey = @"3";
    amazonTablet.productURL = @"http://www.amazon.com/dp/B00HCNHDN0/ref=fs_fs";
    
    [amazon.companyProducts addObject: kindle];
    [amazon.companyProducts addObject: firePhone];
    [amazon.companyProducts addObject: amazonTablet];
    
    // GOOGLE
    
    Company *google = [[Company alloc] init];
    google.companyName = @"Google";
    google.companyImage = @"15.jpg";
    google.companyId = @"4";
    google.companyProducts = [[NSMutableArray alloc] init];
    
    Product *googlePhone = [[Product alloc] init];
    googlePhone.productName = @"Nexus";
    googlePhone.productImage = @"9.jpg";
    googlePhone.companyKey = @"4";
    googlePhone.productURL = @"http://www.google.com/nexus/";
    
    Product *chromeBook = [[Product alloc] init];
    chromeBook.productName = @"Chrome Book";
    chromeBook.productImage = @"10.jpg";
    chromeBook.companyKey = @"4";
    chromeBook.productURL = @"http://www.google.com/chrome/devices/";
    
    Product *chromeCast = [[Product alloc] init];
    chromeCast.productName = @"Chrome Cast";
    chromeCast.productImage = @"11.jpg";
    chromeCast.companyKey = @"4";
    chromeCast.productURL = @"http://www.google.com/chrome/devices/chromecast/";
    
    
    [google.companyProducts addObject: googlePhone];
    [google.companyProducts addObject: chromeBook];
    [google.companyProducts addObject: chromeCast];
    
    
    
    self.companyList = [[NSMutableArray alloc]
                        initWithObjects: apple, samsung, amazon, google, nil];
    
    [self saveCompaniesToCoreData];
    [self saveProductsToCoreData];
   }
    
}

- (void) saveCompaniesToCoreData
{
    for (int i = 0; i < self.companyList.count; i++) {
        CoreCompanies *coreCompany = (CoreCompanies*)[NSEntityDescription
                                        insertNewObjectForEntityForName:@"CoreCompanies"
                                        inManagedObjectContext:self.appDelegate.managedObjectContext];
        coreCompany.companyName = [self.companyList[i] companyName];
        coreCompany.companyImage = [self.companyList[i] companyImage];
        coreCompany.companyStockPrice = [self.companyList[i] companyStockPrice];
        coreCompany.primaryKey = [self.companyList[i] companyId];
    }
    //This is where we are saving the above to Core Data. We are calling this method: *** - (void)saveContext *** from our AppDelegate.m file.
    [self saveTheContext];
}


- (void) saveProductsToCoreData
{
    for (int i = 0; i < self.companyList.count; i++) {
        Company *company = self.companyList[i];
        for (int j = 0; j < [[self.companyList[i] companyProducts] count]; j++) {
            Product * product = company.companyProducts[j];
            CoreProducts *coreProduct = (CoreProducts*)[NSEntityDescription
                                         insertNewObjectForEntityForName:@"CoreProducts"
                                         inManagedObjectContext:self.appDelegate.managedObjectContext];
            coreProduct.productName = product.productName;
            coreProduct.productImage = product.productImage;
            coreProduct.productURL = product.productURL;
            coreProduct.companyKey = product.companyKey;
        }
    }
    
    //This is where we are saving the above to Core Data. We are calling this method: *** - (void)saveContext *** from our AppDelegate.m file.
    [self saveTheContext];
    
}

-(void)saveTheContext {
    //Save the context
    NSError *error = nil;
    if ([self.appDelegate.managedObjectContext hasChanges] && ![self.appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


- (void) matchProductsToCompanies
{
    for (int i = 0; i < self.productList.count; i++) {
//        Product *myProduct = [[Product alloc] init];
//        myProduct = self.productList[i];
        NSPredicate *companyPredicate = [NSPredicate predicateWithFormat:@"companyId = %@", [self.productList[i] companyKey]];
        Company *myCompany = [[Company alloc] init];
        NSArray *foundCompanyList = [[NSArray alloc] initWithArray:[self.companyList filteredArrayUsingPredicate:companyPredicate]];
        myCompany = foundCompanyList[0];
        [myCompany.companyProducts addObject:self.productList[i]];
    }
    [self.productList removeAllObjects];
}

- (void)deleteData:(NSString *)productName
{
    NSFetchRequest *deleteFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *deleteEntity = [NSEntityDescription entityForName:@"CoreProducts" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [deleteFetchRequest setEntity:deleteEntity];
    
    NSPredicate *deletePredicate = [NSPredicate predicateWithFormat:@"productName = %@", productName];
    [deleteFetchRequest setPredicate:deletePredicate];
    
    NSError *error;
    NSArray *deleteProductObject = [self.appDelegate.managedObjectContext executeFetchRequest:deleteFetchRequest error:&error];
    
    [self.appDelegate.managedObjectContext deleteObject:deleteProductObject[0]];
    
    //Save context to write to store
    [self saveTheContext];
    
    NSLog(@"Deletion successful");
}

@end






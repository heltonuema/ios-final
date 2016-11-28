//
//  MainTableViewController.h
//  iosfinal
//
//  Created by Helton Shinhei Uema on 27/10/16.
//  Copyright © 2016 Helton Shinhei Uema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MainTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;

@end

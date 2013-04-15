//
//  DHMasterViewController.h
//  SampleCollectionView
//
//  Created by derrick on 4/15/13.
//  Copyright (c) 2013 Derrick Hathaway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHDetailViewController;

#import <CoreData/CoreData.h>

@interface DHCollectionViewController : UICollectionViewController

@property (strong, nonatomic) DHDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

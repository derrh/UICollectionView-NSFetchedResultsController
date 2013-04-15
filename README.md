# `UICollectionView+NSFetchedResultsController`

A category on `UICollectionView` providing methods to queue up and commit changes in response to `NSFetchedResultsControllerDelegate` methods.

# Setup

Copy UICollectionView+NSFetchedResultsController.h and UICollectionView+NSFetchedResultsController.m into your project and call the appropriate category methods in your `UIFetchedResultsControllerDelegate`

    #pragma mark - Fetched results controller
    
    - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
    {
        // do nothing
    }
    
    - (void)controller:(NSFetchedResultsController *)controller
      didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
               atIndex:(NSUInteger)sectionIndex
         forChangeType:(NSFetchedResultsChangeType)type
    {
        [self.collectionView addChangeForSection:sectionInfo
                                         atIndex:sectionIndex
                                   forChangeType:type];
    }
    
    - (void)controller:(NSFetchedResultsController *)controller
       didChangeObject:(id)anObject
           atIndexPath:(NSIndexPath *)indexPath
         forChangeType:(NSFetchedResultsChangeType)type
          newIndexPath:(NSIndexPath *)newIndexPath
    {
        [self.collectionView addChangeForObjectAtIndexPath:indexPath
                                             forChangeType:type
                                              newIndexPath:newIndexPath];
    }
    
    - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
    {
        [self.collectionView commitChanges];
    }
    
# Credit

Most of the logic for this is taken from [this gist](https://gist.github.com/4440c1cba83318e276bb).

//
//  NewsDataModel.m
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/12/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NewsDataModel.h"
#import "Story.h"
#import <UIKit/UIKit.h>
#import "HackerNewsAPIClient.h"

NSUInteger const NewsDataModel_numberOfSections = 1;
NSUInteger const NewsDataModel_storySection = 0;

@interface NewsDataModel()

@property NSDictionary *storiesDictionary;

@end

@implementation NewsDataModel

-(NSInteger)numberOfSections {
   return NewsDataModel_numberOfSections;
}

-(NSInteger)numberOfRowsInSection:(NSUInteger)section {
   if (section == NewsDataModel_storySection) {
      return [self.storiesDictionary count];
   }
   return 0;
}

-(NSString *)storyAuthorForIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == NewsDataModel_storySection) {
      Story *story = [self.storiesDictionary objectForKey:@(indexPath.row)];
      return story.author;
   }
   return nil;
}

-(NSString *)storyTitleForIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == NewsDataModel_storySection) {
      Story *story = [self.storiesDictionary objectForKey:@(indexPath.row)];
      return story.title;
   }
   return nil;
}

-(NSURL *)storyURLForIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == NewsDataModel_storySection) {
      Story *story = [self.storiesDictionary objectForKey:@(indexPath.row)];
      return story.url;
   }
   return nil;
}

-(void)reloadData {
   __weak typeof(self) weakBlockSelf = self; //*1
  
   [HackerNewsAPIClient fetchTopFiveHundredStoryIDsWithCompletion:^(NSArray *storyIDs) { //*2
      NSMutableDictionary *temporaryStoriesDict = [@{} mutableCopy]; //*3
      dispatch_group_t dispatchGroup = dispatch_group_create(); //*4
      
      for (NSInteger i = 0; i < [storyIDs count]; i++) { //*5
         dispatch_group_enter(dispatchGroup); //*6
         
         [HackerNewsAPIClient fetchStoryWithIDWithCompletion:storyIDs[i] :^(NSDictionary *storyDictionary) { //*7
            Story *newStory = [[Story alloc]initWithJSON:storyDictionary]; //*8
            [temporaryStoriesDict setObject:newStory forKey:@(i)]; //*9
           
            dispatch_group_leave(dispatchGroup); //*10
         }];
      }
      
      dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{ //*11
         weakBlockSelf.storiesDictionary = temporaryStoriesDict; //*12

         if ([weakBlockSelf.delegate respondsToSelector:@selector(dataSourceDidLoad)]) { //*13
            [weakBlockSelf.delegate dataSourceDidLoad]; //*14
         }
      });
      
   }];
}

//*1
/* The __weak keyword creates a weak reference to self for access inside the block.
 This avoids a retain cycle where self retains a block which in turn retains self. In that scenario, the retain cycle could lead to a memory leak. 
 http://stackoverflow.com/questions/7853915/how-do-i-avoid-capturing-self-in-blocks-when-implementing-an-api */

//*2
//This method fetches up to 500 story IDs asynchronously and passes the IDs as an array into its completion block

//*3
//Create a mutable stories dictionary to collect the stories as they load

//*4
/*Here we create a dispatch group to manage the multiple network calls we must make to gather the stories using the IDs passed into this block.
 A dispatch group is a mechanism for monitoring a set of blocks. Your application can monitor the blocks in the group synchronously or asynchronously depending on your needs.
 By extension, group can be useful for synchronizing for code that depends on the completion of other tasks.
 Note that the blocks in a group may be run on different queues, and each individual block can add more blocks to the group.
 The dispatch group keeps track of how many blocks are outstanding, and GCD retains the group until all its associated blocks complete execution.
 https://developer.apple.com/library/ios/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW25 */

//*5
//Iterate over each story ID in the array

//*6
//Enter the dispatch group. This tells GCD that our code is about to execute and to keep the group alive until we leave it.

//*7
//Using each individual story ID, fetch the story dictionary from the API and pass it into this method's completion block.

//*8
//Initialize a new story using the JSON dictionary passed into the block.

//*9
/*Add the story object into the mutable dictionary we previously created and set its key to its position in the IDs array.
 By using i as the dictionary key, we can make sure we keep the stories properly ordered with an inexpensive data-type for access since we do not know the order in which the API will respond*/

//*10
/*Indicate a block in the group has completed.
 When all the operations which have entered the group leave, we can be notified that the group's work is complete and thr group can be released by GCD*/

//*11
/*dispatch_group_notify takes a group and a diapatch queue to notify us that a given group's operations are finished and executes a block on the specified thread.
 In this case, we listen for dispatchGroup to finish its operations, and execute a GCD block on the main thread.*/

//*12
//Set the strongSelf.storiesDictionary variable to the value of the story dictionary we created during our iteration

//*13
/*Check to see if our block version of self responds to the optional dataSourceDidLoad delegate method.
 We need to check since dataSourceDidLoad is optional. If we call it and the delegate does not implement it, the app will crash.*/

//*14
//Call the dataSourceDidLoad method to update any controllers that are tightly-coupled to the data source by its delegate.

@end

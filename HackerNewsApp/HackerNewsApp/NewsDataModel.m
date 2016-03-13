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

@property NSArray *storiesArray;

@end

@implementation NewsDataModel

-(NSInteger)numberOfSections {
   return NewsDataModel_numberOfSections;
}

-(NSInteger)numberOfRowsInSection:(NSUInteger)section {
   if (section == NewsDataModel_storySection) {
      return [self.storiesArray count];
   }
   return 0;
}

-(NSString *)storyAuthorForIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == NewsDataModel_storySection) {
      return ((Story *)self.storiesArray[indexPath.row]).author;
   }
   return nil;
}

-(NSString *)storyTitleForIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == NewsDataModel_storySection) {
      return ((Story *)self.storiesArray[indexPath.row]).title;
   }
   return nil;
}

-(NSURL *)storyURLForIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == NewsDataModel_storySection) {
      return ((Story *)self.storiesArray[indexPath.row]).url;
   }
   return nil;
}

-(void)reloadData {
   //Create a weak reference to self for access inside the block.
   //This avoids a retain cycle where self retains a block which in turn retains self. In that scenario, the retain cycle could lead to a memory leak.
   //The reason we do not need to call __block is because we do not modify self.storiesArray outside of the execution of this block.
   //If we relied on a change to self or any of its instance variables while the block is executing, we would need to utilize the __block keyword
   __weak typeof(self) weakSelf = self;
   
   //This method fetches up to 500 story IDs asynchronously and passes the IDs as an array into its completion block
   [HackerNewsAPIClient fetchTopFiveHundredStoryIDsWithCompletion:^(NSArray *storyIDs) {
      
      //Inside the block, we create a strong reference to self to ensure that during the execution of the block, the weak reference does not get released.
      //Because weakSelf is weak, it can be deallocated before our work here is done.
      //By creating a strong version inside the block, we can be certain it will exist as long as the block is still executing
      __strong typeof(weakSelf) strongSelf = weakSelf;
      
      //Here we create a dispatch group to manage the multiple network calls we must make to gather the stories using the IDs passed into this block
      
      /* A dispatch group is a mechanism for monitoring a set of blocks. Your application can monitor the blocks in the group synchronously or asynchronously depending on your needs. By extension, a group can be useful for synchronizing for code that depends on the completion of other tasks.
       
       Note that the blocks in a group may be run on different queues, and each individual block can add more blocks to the group.
       
       The dispatch group keeps track of how many blocks are outstanding, and GCD retains the group until all its associated blocks complete execution. */
      
      dispatch_group_t dispatchGroup = dispatch_group_create();
      
      //Create a mutable stories array to collect the stories as they load
      
      NSMutableArray *stories = [@[] mutableCopy];
      
      //Iterate over each story ID in the array
      
      for (NSNumber *storyID in storyIDs) {
        
         //Enter the dispatch group. This tells GCD that our code is about to execute and to keep the group alive until we leave it.
         
         dispatch_group_enter(dispatchGroup);
         
         //Using each individual story ID, fetch the story dictionary from the API and pass it into this method's completion block.
         
         [HackerNewsAPIClient fetchStoryWithIDWithCompletion:storyID :^(NSDictionary *storyDictionary) {
            
            //Initialize a new story using the JSON dictionary passed into the block.
            
            Story *newStory = [[Story alloc]initWithJSON:storyDictionary];
           
            //Add the story object into the mutable dictionary we previously created.
            
            [stories addObject:newStory];
            
            //Indicate a block in the group has completed.
            //When all the operations which have entered the group leave, we can be notified that the group's work is complete and thr group can be released by GCD
            
            dispatch_group_leave(dispatchGroup);
         }];
      }
      
      //dispatch_group_notify takes a group and a diapatch queue to notify us that a given group's operations are finished and executes a block on the specified thread.
      //In this case, we listen for dispatchGroup to finish its operations, and execute a GCD block on the main thread.
      
      dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
         
         //Set our strong stories storiesArray variable to the value of the stories we collected during our fast-iteration
         
         strongSelf.storiesArray = stories;
         
         //Check to see if our block version of self responds to the optional dataSourceDidLoad delegate method.
         //We need to check since dataSourceDidLoad is optional. If we call it and the delegate does not implement it, the app will crash.
         
         if ([strongSelf.delegate respondsToSelector:@selector(dataSourceDidLoad)]) {
            
            //Call the dataSourceDidLoad method to update any controllers that are tightly-coupled to the data source by its delegate.
            
            [strongSelf.delegate dataSourceDidLoad];
         }
      });
   }];
   
}

@end

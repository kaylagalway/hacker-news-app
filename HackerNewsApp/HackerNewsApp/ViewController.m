//
//  ViewController.m
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "ViewController.h"
#import "HackerNewsAPIClient.h"
#import "Story.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *stories;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stories = [NSMutableArray new];
    
    __block __weak typeof(self) blockSelf = self;
    [HackerNewsAPIClient fetchTopFiveHundredStoryIDs:^(NSArray *storyIDs) {
        for (NSNumber *storyID in storyIDs) {
            
            NSLog(@"have a storyID: %@", storyID);
            [HackerNewsAPIClient fetchStoryWithID:storyID :^(NSDictionary *storyDictionary) {
                
                Story *newStory = [[Story alloc]initWithJSON:storyDictionary];
                NSLog(@"newStory: %@", newStory);
                [blockSelf.stories addObject:newStory];
                
                //TOM ADDED THINGS BELOW
                // when its all done... reload tableview
                if (blockSelf.stories.count == storyIDs.count) {
                    // tableview reloadData
                }
                // OR make an indexPath and reload that row
                NSInteger indexOfStoryInStoriesProperty = [blockSelf.stories indexOfObject:newStory];
                NSIndexPath *ipForNewStory = [NSIndexPath indexPathForItem:indexOfStoryInStoriesProperty inSection:0];
                // [self.tableView reloadRowsAtIndexPaths:@[ipForNewStory] animation: UITableViewAnimationFromLeft];
            }];
        }
        
        
        
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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

  self.stories = [@[] mutableCopy];
  
  __block typeof(self) blockSelf = self;
  [HackerNewsAPIClient fetchTopFiveHundredStoryIDs:^(NSArray *storyIDs) {
    for (NSNumber *storyID in storyIDs) {
      [HackerNewsAPIClient fetchStoryWithID:storyID :^(NSDictionary *storyDictionary) {
        [blockSelf.stories addObject:[[Story alloc]initWithJSON:storyDictionary]];
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

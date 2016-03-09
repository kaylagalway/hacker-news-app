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
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storyLoaded:) name:HackerNewsAPIClient_notification_storyDidLoad object:nil];
  self.stories = [@[] mutableCopy];
  
  [HackerNewsAPIClient fetchTopFiveHundredStoryIDs:^(NSArray *storyIDs) {
    for (NSNumber *storyID in storyIDs) {
      [HackerNewsAPIClient fetchStoryWithID:storyID :nil];
    }
  }];
    
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)storyLoaded:(NSNotification *)note {
  NSDictionary *storyDict = note.userInfo;
  [self.stories addObject:storyDict];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

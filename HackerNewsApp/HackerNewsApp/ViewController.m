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
  
  //https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Blocks/Articles/bxVariables.html#//apple_ref/doc/uid/TP40007502-CH6-SW1
  //http://rypress.com/tutorials/objective-c/blocks
  
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

//
//  HackerNewsAPIClient.m
//  HackerNewsApp
//
//  Created by Ryan, Dare on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "HackerNewsAPIClient.h"

@implementation HackerNewsAPIClient

+ (void)fetchTopFiveHundredStoryIDs: (void (^)(NSArray *storyIDs))completion {
  NSURL *url = [NSURL URLWithString:@"https://hacker-news.firebaseio.com/v0/topstories.json"];
  
    //this is the same as creating an NSURLsession variable, creates a data task, and resumes session
  [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
      //created a variable that contains the serialized data from the request which is turned into an NSObject(array in this case)
      NSArray *arrayWithID = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
      
      //called completion and passed it arrayWithID
      completion (arrayWithID);
    
    NSLog(@"%@", data);
    
  }]resume];
  
  
}


@end


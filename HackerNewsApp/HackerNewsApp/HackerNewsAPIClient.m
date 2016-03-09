//
//  HackerNewsAPIClient.m
//  HackerNewsApp
//
//  Created by Ryan, Dare on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "HackerNewsAPIClient.h"

NSString *const HackerNewsAPIClient_baseURL = @"https://hacker-news.firebaseio.com/v0/";

NSString *const HackerNewsApiClient_topStoriesURLParameter = @"/topstories";
NSString *const HackerNewsApiClient_itemURLParameter = @"/item/";

NSString *const HackerNewsApiClient_JsonURLParameter = @".json";

@implementation HackerNewsAPIClient

+ (void)fetchTopFiveHundredStoryIDs: (void (^)(NSArray *storyIDs))completion {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", HackerNewsAPIClient_baseURL, HackerNewsApiClient_topStoriesURLParameter, HackerNewsApiClient_JsonURLParameter]];
  
    //this is the same as creating an NSURLsession variable, creates a data task, and resumes session
  [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
      //created a variable that contains the serialized data from the request which is turned into an NSObject(array in this case)
      NSArray *arrayWithID = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
      
      //called completion and passed it arrayWithID
      completion (arrayWithID);
    
  }]resume];
}

+ (void)fetchStoryWithID:(NSNumber *)storyID :(void (^)(NSDictionary *storyDictionary))completion {
  
}

@end


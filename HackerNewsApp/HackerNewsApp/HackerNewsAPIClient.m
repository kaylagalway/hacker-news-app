//
//  HackerNewsAPIClient.m
//  HackerNewsApp
//
//  Created by Ryan, Dare on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "HackerNewsAPIClient.h"

//creating these constants to contain the portions of the URL that we can then reference easily later. These are unchangeable.

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

//method takes NSNumber argument of storyID (number within URL) and completes a block
//from viewcontroller.m we called fetchStoryWithID and passed storyIDs[0] which is an NSNumber within an array
+ (void)fetchStoryWithID:(NSNumber *)storyID :(void (^)(NSDictionary *storyDictionary))completion {
    
    //creating a malleable URL with four components, three of them are constants defined above, and one is a variable storyID
    NSURL *storyIdUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@", HackerNewsAPIClient_baseURL, HackerNewsApiClient_itemURLParameter, storyID, HackerNewsApiClient_JsonURLParameter]];
    
    //creates nsurlsession, data task, nsurlresponse which is state of data we got back(used to track status/errors), and then resumes session
    [[[NSURLSession sharedSession] dataTaskWithURL:storyIdUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
    //using NSJSONSerialization to convert raw data to NSObject that we requested
    NSDictionary *storyDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:0
                                                                      error:nil];
        
      completion(storyDictionary);
    }]resume];
    
    
    
    
    
  //https://hacker-news.firebaseio.com/v0/item/11248320.json
}

@end


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
    NSURLSession *session = [NSURLSession sharedSession];
    
//    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        <#code#>
//    }]
    
}


@end


//
//  HackerNewsAPIClient.h
//  HackerNewsApp
//
//  Created by Ryan, Dare on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const HackerNewsAPIClient_notification_storyDidLoad;

@interface HackerNewsAPIClient : NSObject

//passses an array of 500 story ID's into its completion block
+ (void)fetchTopFiveHundredStoryIDsWithCompletion: (void (^)(NSArray *storyIDs))completion;

//takes story ID number and passes
+ (void)fetchStoryWithIDWithCompletion:(NSNumber *)storyID :(void (^)(NSDictionary *storyDictionary))completion;

@end

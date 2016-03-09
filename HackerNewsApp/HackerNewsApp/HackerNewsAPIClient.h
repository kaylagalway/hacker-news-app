//
//  HackerNewsAPIClient.h
//  HackerNewsApp
//
//  Created by Ryan, Dare on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HackerNewsAPIClient : NSObject

+ (void)fetchTopFiveHundredStoryIDs: (void (^)(NSArray *storyIDs))completion;

@end

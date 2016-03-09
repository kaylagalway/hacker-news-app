//
//  Story.h
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property NSString *author;
@property NSNumber *commentCount;
@property NSNumber *idNumber;
@property NSArray *commentIDs;
@property NSNumber *votesScore;
@property NSDate *postDate;
@property NSString *title;
@property NSString *type;
@property NSURL *url;

- (instancetype)initWithJSON:(NSDictionary *) JSON;

@end

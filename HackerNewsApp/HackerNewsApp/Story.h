//
//  Story.h
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (strong, nonatomic, readonly) NSString *author;
@property (strong, nonatomic, readonly) NSNumber *commentCount;
@property (strong, nonatomic, readonly) NSNumber *idNumber;
@property (strong, nonatomic, readonly) NSArray *commentIDs;
@property (strong, nonatomic, readonly) NSNumber *votesScore;
@property (strong, nonatomic, readonly) NSDate *postDate;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *type;
@property (strong, nonatomic, readonly) NSURL *url;

- (instancetype)initWithJSON:(NSDictionary *) JSON;

@end

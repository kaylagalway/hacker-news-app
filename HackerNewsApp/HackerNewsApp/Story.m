//
//  Story.m
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "Story.h"

NSString *const Story_DictionaryKey_author = @"by";
NSString *const Story_DictionaryKey_commentCount = @"descendants";
NSString *const Story_DictionaryKey_id= @"id";
NSString *const  Story_DictionaryKey_commentIDs = @"kids";
NSString *const  Story_DictionaryKey_votesScore = @"score";
NSString *const  Story_DictionaryKey_postDate = @"time";
NSString *const  Story_DictionaryKey_title = @"title";
NSString *const  Story_DictionaryKey_type = @"type";
NSString *const  Story_DictionaryKey_url = @"url";

@interface Story ()

//changed to readwrite so that it could be initialized 
@property (strong, nonatomic, readwrite) NSString *author;
@property (strong, nonatomic, readwrite) NSNumber *commentCount;
@property (strong, nonatomic, readwrite) NSNumber *idNumber;
@property (strong, nonatomic, readwrite) NSArray *commentIDs;
@property (strong, nonatomic, readwrite) NSNumber *votesScore;
@property (strong, nonatomic, readwrite) NSDate *postDate;
@property (strong, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) NSString *type;
@property (strong, nonatomic, readwrite) NSURL *url;

@end


@implementation Story

- (instancetype)initWithJSON:(NSDictionary *)JSON{
    self = [super init];
    //initializing all properties to the values of their keys in the dictionary
    if (self) {
        _author = JSON[Story_DictionaryKey_author];
        _commentCount = JSON[Story_DictionaryKey_commentCount];
        _idNumber = JSON[Story_DictionaryKey_id];
        _commentIDs = JSON[Story_DictionaryKey_commentIDs];
        _votesScore = JSON[Story_DictionaryKey_votesScore];
        _postDate = [NSDate dateWithTimeIntervalSince1970:[JSON[Story_DictionaryKey_postDate]doubleValue]];
        _title = JSON[Story_DictionaryKey_title];
        _type = JSON[Story_DictionaryKey_type];
        _url = JSON[Story_DictionaryKey_url];
    }
    
    return self;
}

@end

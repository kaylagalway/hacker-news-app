//
//  NewsDataModel.m
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/12/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NewsDataModel.h"
#import "Story.h"
#import <UIKit/UIKit.h>

NSUInteger const NewsDataModel_numberOfSections = 1;

@interface NewsDataModel()

@property (nonatomic, strong) NSMutableArray *storiesArray;

@end

@implementation NewsDataModel


-(instancetype) initWithStories: (NSMutableArray *)stories{
    self = [super init];
    if (self) {
        _storiesArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSInteger)numberOfSections {
    return NewsDataModel_numberOfSections;
}

-(NSInteger)numberOfRowsInSection:(NSUInteger)section {
    return [self.storiesArray count];
}

-(NSString *)storyAuthorForIndexPath:(NSIndexPath *)indexPath {
    return ((Story *)self.storiesArray[indexPath.row]).author;
}

-(NSString *)storyTitleForIndexPath:(NSIndexPath *)indexPath {
    return ((Story *)self.storiesArray[indexPath.row]).title;
}

-(NSURL *)storyURLForIndexPath:(NSIndexPath *)indexPath {
    return ((Story *)self.storiesArray[indexPath.row]).url;
}

-(void)reloadData {
    
}

@end

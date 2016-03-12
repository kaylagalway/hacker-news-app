//
//  NewsDataModel.h
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/12/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsDataModelDelegate;

@interface NewsDataModel : NSObject

@property (nonatomic, weak) id<NewsDataModelDelegate> delegate;

-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSUInteger)section;

-(NSString *)storyAuthorForIndexPath:(NSIndexPath *)indexPath;
-(NSString *)storyTitleForIndexPath:(NSIndexPath *)indexPath;
-(NSURL *)storyURLForIndexPath:(NSIndexPath *)indexPath;

-(void)reloadData;

@end

@protocol NewsDataModelDelegate <NSObject>

@optional
-(void)dataSourceDidLoad;



@end

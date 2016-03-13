//
//  ViewController.m
//  HackerNewsApp
//
//  Created by Kayla Galway on 3/8/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "ViewController.h"
#import "NewsDataModel.h"

@interface ViewController ()<NewsDataModelDelegate>
@property NewsDataModel *dataModel;

@end

@implementation ViewController

- (void)viewDidLoad {
   
   [super viewDidLoad];
   
   self.dataModel = [[NewsDataModel alloc]init];
   self.dataModel.delegate = self;
   [self.dataModel reloadData];
   
   
   // Do any additional setup after loading the view, typically from a nib.
}



-(void)dataSourceDidLoad {
   NSLog(@"%ld", (long)[self.dataModel numberOfRowsInSection:0]);
   NSIndexPath *ip = [NSIndexPath indexPathForItem:0 inSection:0];
   NSLog(@"%@", [self.dataModel storyTitleForIndexPath:ip]);
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end

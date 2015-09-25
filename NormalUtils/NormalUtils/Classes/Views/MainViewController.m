//
//  MainViewController.m
//  NormalUtils
//
//  Created by wsliang on 15/8/18.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSString *tableViewCellId;

@property (nonatomic) NSMutableArray *mRowTitles;
@property (nonatomic) NSMutableDictionary *mRowsDict;// key:section,value:array(items)

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.title = @"测试首页";
  
  self.tableViewCellId = @"tableViewCellId";
  self.mRowTitles = [NSMutableArray new];
  self.mRowsDict = [NSMutableDictionary new];
  
  [self setDefaultData];
}

-(void)setDefaultData
{
  
  
  [self.mRowsDict setDictionary:@{
                                  @"1. 测试字符串":@"TestStringViewController",
                                  @"2. 测试图片缓存":@"TestImgCacheViewController",
                                  
                                  
                                  @"---- 关闭程序 ----":@"_exit"
                                  
                                  }];
  
  [self.mRowTitles addObjectsFromArray:[self.mRowsDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
    return [obj1 compare:obj2 options:NSNumericSearch range:NSMakeRange(0, 5)];
  }]];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//  return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.mRowTitles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 40;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.tableViewCellId];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:self.tableViewCellId];
  }
  cell.textLabel.text = self.mRowTitles[indexPath.row];
  return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *title = self.mRowTitles[indexPath.row];
  NSString *itemClass = [self.mRowsDict objectForKey:title];
  if ([itemClass isEqualToString:@"_exit"]) {
    exit(0);
  }else{
    // check class
    Class tempClass = NSClassFromString(itemClass);
    BOOL right = [tempClass isSubclassOfClass:[BaseViewController class]];
    if (right) {
      BaseViewController *tempVC = [[tempClass alloc] initWithNibName:itemClass bundle:nil];
      tempVC.title = title;
      [self.navigationController pushViewController:tempVC animated:YES];
    }
 
  }
}


@end

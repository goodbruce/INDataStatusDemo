//
//  INMainViewController.m
//  INDataStatusDemo
//
//  Created by guobingwei on 2019/10/18.
//  Copyright © 2019年 bruce. All rights reserved.
//

#import "INMainViewController.h"
#import "UIColor+Addition.h"
#import "INDemoShowViewController.h"

@interface INMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *lists;

@end

@implementation INMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"示例列表";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, kStatusBarHeight+44.0, self.view.bounds.size.width, self.view.bounds.size.height - (kStatusBarHeight+44.0)) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
    _tableView.rowHeight = 44.0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    self.lists = [NSMutableArray arrayWithObjects:
                  @"无数据样式",
                  @"网络请求异常样式",
                  @"Facy",
                  @"airbnb",
                  @"Dropbox",
                  @"instagram",
                  @"yy",
                  @"qq",
                  @"jd",
                  nil];
    
    [self.tableView reloadData];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"595959"];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    NSString *title = [self.lists objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.lists objectAtIndex:indexPath.row];
    INDemoShowViewController *demoShowVC = [[INDemoShowViewController alloc] init];
    demoShowVC.navTitle = title;
    [self.navigationController pushViewController:demoShowVC animated:YES];
}

@end

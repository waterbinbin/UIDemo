//
//  ViewController.m
//  UISearchController
//
//  Created by 王福滨 on 2017/4/25.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

// 参考链接：http://www.jianshu.com/p/993ac8fceb6a# 上中下篇
// https://github.com/Ja5onHoffman/UISearchController-Demo

#import "ViewController.h"

#import "SearchResultTableVC.h"

@interface ViewController () <UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate>
{
}

@property(nonatomic, strong) UISearchController *searchController;
@property(nonatomic, strong) NSArray *airlines;
@property(nonatomic, strong) NSMutableArray *searchResults;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) SearchResultTableVC *searchResultTableVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"airlineData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    self.airlines = dict[@"airlines"];
    
    // tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds/* style:UITableViewStyleGrouped*/];
    
    // 自动调整子视图的大小
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // 设置数据视图的代理对象
    _tableView.delegate = self;
    // 设置数据视图的数据源对象
    _tableView.dataSource = self;
    
    // 数据视图的头部视图和尾部视图的设定
    _tableView.tableHeaderView = nil;
    _tableView.tableFooterView = nil;
    
    [self.view addSubview:_tableView];
    
    // 第一步：自定义搜索结果的ViewController，继承UITableViewController
    // 第二步：在主视图控制器初始化UISearchController和SearchResultTableVC
    _searchResultTableVC = [[SearchResultTableVC alloc] init];
    _searchResultTableVC.delegate = self;
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchResultTableVC];
    _searchController.searchResultsUpdater = self;
    
    _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x,
                                                   _searchController.searchBar.frame.origin.y,
                                                   _searchController.searchBar.frame.size.width,
                                                   44.0);
    // UInavigationBar不隐藏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    self.tableView.tableHeaderView = _searchController.searchBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.airlines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Airline";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Airline" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.airlines objectAtIndex:indexPath.row] objectForKey:@"Name"];;
    
    return cell;
}

// 第三步：在SearchResultTableVC中（非主视图控制器）实现UISearchResultsUpdating和搜索逻辑
#pragma mark -- UISearchResultsUpdating & UISearchControllerDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 实现搜索逻辑代码
    NSString *searchString = searchController.searchBar.text;
    [self updateFilteredContentForAitlineName:searchString];
    
    if(_searchController.searchResultsController)
    {
//        UINavigationController *navController = (UINavigationController *)_searchController.searchResultsController;
//        _searchResultTableVC = (SearchResultTableVC *)navController.topViewController;
        
        // 更新searchResults
        _searchResultTableVC.searchResultArray = self.searchResults;
    }
    // 搜索完成后可别忘记刷新tableview
    [_searchResultTableVC.tableView reloadData];
}

- (void)updateFilteredContentForAitlineName:(NSString *)airlineName
{
    if(airlineName == nil)
    {
        _searchResults = [_airlines mutableCopy];
    }
    else
    {
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        for(NSDictionary *airline in self.airlines)
        {
            if([airline[@"Name"] containsString:airlineName])
            {
                NSString *str = [NSString stringWithFormat:@"%@", airline[@"Name"]];
                [searchResults addObject:str];
            }
            _searchResults = searchResults;
        }
    }
}
@end

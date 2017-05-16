//
//  ViewController.m
//  SDWebImage
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

// 下载：git@github.com:rs/SDWebImage.git

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "BookModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_arrayData;
    // 加载视图
    UIBarButtonItem *_btnLoadData;
    // 编辑按钮
    UIBarButtonItem *_btnEdit;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"加载网络视图Demo";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 自动调整视图大小属性
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
    
    _arrayData = [[NSMutableArray alloc] init];
    
    _btnLoadData = [[UIBarButtonItem alloc] initWithTitle:@"加载"
                                                    style:UIBarButtonItemStylePlain
                                                   target:self
                                                   action:@selector(pressLoad)];
    self.navigationItem.rightBarButtonItem = _btnLoadData;
    
}

// 加载新的数据刷新显示的视图
- (void)pressLoad
{
//    static int i = 0;
//    for(int j = 0; j < 10; ++i, ++j)
//    {
//        NSString *str = [NSString stringWithFormat:@"数据%d", i + 1];
//        [_arrayData addObject:str];
//    }
    [self loadDataFromNet];
    [_tableView reloadData];
}

// 下载数据
- (void)loadDataFromNet
{
    // 创建HTTP连接管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSArray *arrayG = [NSArray arrayWithObjects:@"ios" , @"Android", @"C++", nil];
    static int counter = 0;
    NSString *path = [NSString stringWithFormat:@"http://api.douban.com/book/subjects?q=%@&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1",
                      arrayG[counter]];
    counter++;
    if(counter >= 3)
    {
        counter = 0;
    }
    // GET方法获取服务器数据
    // GET:通过GET方法
    // P1:参数传入一个URL对象
    // P2:通过指定的结构传入参数
    // P3:指定下载的进度条UI
    // P4:下载数据成功后调用block,pp1：下载的任务线程 pp2:返回的数据内容
    // P5:下载数据失败后调用block，pp1：下载的任务线程 pp2:返回的错误数据内容
    [session GET:path
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"下载成功");
             if([responseObject isKindOfClass:[NSDictionary class]])
             {
                 NSLog(@"res = %@", responseObject);
                 [self parseData:responseObject];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"下载失败");
         }];
}

// 解析数据函数
- (void)parseData:(NSDictionary *)dicData
{
    NSArray *arrEntry = [dicData objectForKey:@"entry"];
    for(NSDictionary *dicBook in arrEntry)
    {
        NSDictionary *dicTitle = [dicBook objectForKey:@"title"];
        NSString *strTitle = [dicTitle objectForKey:@"$t"];
        
        BookModel *bModel = [[BookModel alloc] init];
        bModel.mBookName = strTitle;
        
        NSArray *arrLink = [dicBook objectForKey:@"link"];
        for(NSDictionary *dicLink in arrLink)
        {
            NSString *sValue = [dicLink objectForKey:@"@rel"];
            if([sValue isEqualToString:@"image"])
            {
                bModel.mImageURL = [dicLink objectForKey:@"@href"];
            }
        }
        
        [_arrayData addObject:bModel];
    }
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource

// 设置数据视图的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 获取每组元素的个数（行数）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

// 创建单元格对象函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strID = @"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    
    BookModel *bModel = [_arrayData objectAtIndex:indexPath.row];
    cell.textLabel.text = bModel.mBookName;
    // 使用webImage来加载网络图片
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:bModel.mImageURL] placeholderImage:[UIImage imageNamed:@"0.jpeg"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end

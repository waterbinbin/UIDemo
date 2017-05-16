//
//  SearchResultTableVC.h
//  UISearchController
//
//  Created by 王福滨 on 2017/4/25.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableVC : UITableViewController

@property(assign, nonatomic)id<UITableViewDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *searchResultArray;

@end

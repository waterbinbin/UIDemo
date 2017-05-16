//
//  VCRoot.m
//  UISearchBar&AddressBookUI
//
//  Created by 王福滨 on 2017/4/21.
//  Copyright © 2017年 YY Inc. All rights reserved.
//
// 参考资料
// http://blog.csdn.net/u011622479/article/details/51276461
// http://blog.csdn.net/dolacmeng/article/details/49981687
// 使用UISearchController替代UISearchBar，与UISearchDisplayController 更加好
// 使用Contacts.framework ContactsUI.framework的最新的ios9.0框架代替AddressBookUI 更加好

#import "VCRoot.h"

// 在Build phases中添加AddressBook.framework与AddressBookUI.framework，info.plist中需要添加NSContactsUsageDescription
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Contacts.h"

@interface VCRoot () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>
{
    // 方法1
    NSMutableDictionary *sections;
    
    // 方法2
    NSMutableArray *listSection;
    NSMutableArray *addressBookTemp;
    NSMutableArray *listPhone;
    NSMutableArray *_searchContacts;// 符合条件的搜索联系人
    UISearchDisplayController *_searchDisplayController;
    NSMutableDictionary *sectionsSearch;
    
}

@property(nonatomic, strong)UISearchBar *customSearchBar;

@property(nonatomic, strong)NSArray *listContacts;   // 通讯录原始的数据对象
@property(nonatomic, strong)NSArray *contactsArr;    // 转换为name字符串的通讯录人名
@property(nonatomic, strong)UITableView *tableView;

// 方法1的操作会加载通讯录事件比较长，会卡
- (void)filterContentForSearchText:(NSString*)searchText;

@end

@implementation VCRoot

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 搜索框
    CGRect mainViewBounds = self.navigationController.view.bounds;
    _customSearchBar = [[UISearchBar alloc] initWithFrame:
                                    CGRectMake(CGRectGetWidth(mainViewBounds) / 2 - ((CGRectGetWidth(mainViewBounds) - 120) / 2),
                                               CGRectGetMinY(mainViewBounds) + 22,
                                               CGRectGetWidth(mainViewBounds) - 120,
                                               40)];
    _customSearchBar.delegate = self;
    _customSearchBar.showsCancelButton = YES;
    _customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    _customSearchBar.placeholder = @"搜索";
    [self.navigationController.view addSubview:_customSearchBar];
    
    // UISearchBar上按钮的默认文字为Cancel,这里修改
    for(id cancel in [_customSearchBar.subviews[0] subviews])
    {
        if([cancel isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cancel;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
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
    //_tableView.hidden = YES;
    
    // 初始化联系人
//    CFErrorRef error = NULL;
//    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
//    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//        
//        if (granted) {
//            //查询所有
//            [self filterContentForSearchText:@""];
//        }
//        
//    });
//    CFRelease(addressBook);
    
    // 方法2:
    // UISearchDisplayController
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_customSearchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    [_searchDisplayController setActive:NO animated:YES];
    
    // 初始化对象
    addressBookTemp = [[NSMutableArray alloc] init];
    listSection = [[NSMutableArray alloc] init];
    listPhone =[[NSMutableArray alloc] init];
    NSMutableArray * listPhoneShow = [[NSMutableArray alloc] init];

    //获取通讯录联系人信息
    [self getAddressBook];
}

// listContacts的mode对象数组
//- (NSArray *)contactsArr
//{
//    NSMutableArray *conArr = [NSMutableArray array];
//    for(NSArray *arr in _listContacts)
//    {
//        ABRecordRef thisPerson = CFBridgingRetain(arr);
//        
//        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(thisPerson, kABPersonFirstNameProperty));
//        firstName = firstName != nil?firstName:@"";
//        NSString *lastName =  CFBridgingRelease(ABRecordCopyValue(thisPerson, kABPersonLastNameProperty));
//        lastName = lastName != nil?lastName:@"";
//        NSString* name = CFBridgingRelease(ABRecordCopyCompositeName(thisPerson));
//        CFRelease(thisPerson);
//        
//        Contacts *constacts = [Contacts initWithName:name];
//        [conArr addObject:constacts];
//    }
//    
//    _contactsArr = conArr;
//    
//    return _contactsArr;
//}

- (void)setupData
{
    // 创建所有Keys
    NSMutableDictionary *tempSections = [NSMutableDictionary dictionary];
    BOOL found;
    for(Contacts *teamer in _searchContacts)
    {
        NSString *index = teamer.nameIndex;
        found = NO;
        for(NSString *str in [tempSections allKeys])
        {
            if([str isEqualToString:index])
            {
                found = YES;
            }
        }
        // 还没有对应的key，则新建
        if(!found)
        {
            [tempSections setValue:[[NSMutableArray alloc] init] forKey:index];
        }
    }
    
    // 将所有的contacts数据加载进去
    for(Contacts *contact in _searchContacts)
    {
        [[tempSections objectForKey:contact.nameIndex] addObject:contact];
    }
    // 按照A-Z排序
    for(NSString *key in [tempSections allKeys])
    {
        [[tempSections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    }
    
    sectionsSearch = tempSections;
}


- (void)filterContentForSearchText:(NSString*)searchText
{
    //如果没有授权则退出
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        return ;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    
    if([searchText length]==0)
    {
        //查询所有
        self.listContacts = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
        [self setupData];
    }
    else
    {
        //条件查询
        CFStringRef cfSearchText = (CFStringRef)CFBridgingRetain(searchText);
        self.listContacts = CFBridgingRelease(ABAddressBookCopyPeopleWithName(addressBook, cfSearchText));
        [self setupData];
        CFRelease(cfSearchText);
    }
    
    [self.tableView reloadData];
    
    CFRelease(addressBook);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UISearchBarDelegate
// 获得焦点，成为第一响应者
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

// 点击键盘上的search按钮时调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //[_customSearchBar resignFirstResponder];
}

// 输入文本实时更新时调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //[self filterContentForSearchText:_customSearchBar.text];
    [_tableView reloadData];
}

// cancel按钮点击时调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //查询所有
    //[self filterContentForSearchText:_customSearchBar.text];
    [_tableView reloadData];
    [_customSearchBar resignFirstResponder];
}

// 点击搜索框时调用
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //_tableView.hidden = NO;
    _tableView.tableHeaderView = _customSearchBar;
    [_tableView reloadData];
    // 这里用于访问手机联系人信息
    //[self filterContentForSearchText:_customSearchBar.text];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        //return 1;
        NSLog(@"Sections = %ld", [[sectionsSearch allKeys] count]);
        return [[sectionsSearch allKeys] count];
    }
    return [[sections allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.listContacts count];
    //如果当前是UISearchDisplayController内部的tableView则使用搜索数据
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        //return _searchContacts.count;
        NSLog(@"RowsInSection = %ld", [[sectionsSearch valueForKey:[[[sectionsSearch allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count]);
        return [[sectionsSearch valueForKey:[[[sectionsSearch allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
    return [[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView==self.searchDisplayController.searchResultsTableView)
    {
        return [[[sectionsSearch allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    }
    return [[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
//    ABRecordRef thisPerson = CFBridgingRetain([self.listContacts objectAtIndex:[indexPath row]]);
//    
//    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(thisPerson, kABPersonFirstNameProperty));
//    firstName = firstName != nil?firstName:@"";
//    NSString *lastName =  CFBridgingRelease(ABRecordCopyValue(thisPerson, kABPersonLastNameProperty));
//    lastName = lastName != nil?lastName:@"";
//    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
//    NSString* name = CFBridgingRelease(ABRecordCopyCompositeName(thisPerson));
//    cell.textLabel.text = name;
    
    if(tableView!=self.searchDisplayController.searchResultsTableView)
    {
        Contacts *contacts = [[sections valueForKey:[[[sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = contacts.name;
    }
    else
    {
        Contacts *contacts = [[sectionsSearch valueForKey:[[[sectionsSearch allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = contacts.name;
        //如果显示搜索列表
        //cell.textLabel.text = [[_searchContacts objectAtIndex:indexPath.row] name];

    }
    
    
    //CFRelease(thisPerson);
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- 方法2
-(void) getAddressBook{
    
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        //        dispatch_release(sema);
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        //Contacts *addressBook = [[Contacts alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        Contacts *addressBook = [Contacts initWithName:nameString];
        
        
        [addressBookTemp addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    _contactsArr = addressBookTemp;
    
    // 创建所有Keys
    NSMutableDictionary *tempSections = [NSMutableDictionary dictionary];
    BOOL found;
    for(Contacts *teamer in _contactsArr)
    {
        NSString *index = teamer.nameIndex;
        found = NO;
        for(NSString *str in [tempSections allKeys])
        {
            if([str isEqualToString:index])
            {
                found = YES;
            }
        }
        // 还没有对应的key，则新建
        if(!found)
        {
            [tempSections setValue:[[NSMutableArray alloc] init] forKey:index];
        }
    }
    
    // 将所有的contacts数据加载进去
    for(Contacts *contact in self.contactsArr)
    {
        [[tempSections objectForKey:contact.nameIndex] addObject:contact];
    }
    // 按照A-Z排序
    for(NSString *key in [tempSections allKeys])
    {
        [[tempSections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    }
    
    sections = tempSections;
}

// 搜索形成新数据
-(void)searchDataWithKeyWord:(NSString *)keyWord{
    _searchContacts=[NSMutableArray array];
    
    int count =  [_contactsArr count];
    Contacts * contact = nil;
    //过滤
    for(int i=0;i<count;i++){
        contact = [_contactsArr objectAtIndex:i];
        
        if ([contact.name.uppercaseString containsString:keyWord.uppercaseString])
        {
            [_searchContacts addObject:contact];
        }
    }
}

#pragma mark -- UISearchDisplayDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self searchDataWithKeyWord:searchString];
    [self setupData];
    return YES;
}

@end

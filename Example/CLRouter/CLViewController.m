//
//  CLViewController.m
//  CLRouter
//
//  Created by zhangchenglong on 01/15/2019.
//  Copyright (c) 2019 zhangchenglong. All rights reserved.
//

#import "CLViewController.h"
#import "CLRouterManager.h"

@interface CLTableItem : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *router;

- (instancetype)initWithTitle:(NSString *)title router:(NSString *)router;

@end

@implementation CLTableItem

- (instancetype)initWithTitle:(NSString *)title router:(NSString *)router {
    if (self = [super init]) {
        self.title = title;
        self.router = router;
    }
    return self;
}

@end

@interface CLViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *datas;

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation CLViewController

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
        [_datas addObjectsFromArray:@[
                                      [[CLTableItem alloc]initWithTitle:@"动态Class" router:@"SmartTourism://CLDynamicClassVC?code=10003&content=您好！"],
                                      [[CLTableItem alloc]initWithTitle:@"动态Xib" router:@"SmartTourism://CLDynamicXibVC?code=10003&content=ThisisDynamicRegister"],
                                      [[CLTableItem alloc]initWithTitle:@"动态Storyboard" router:@"SmartTourism://CLDynamicStoryboardVC?code=10003&content=ThisisDynamicRegister"],
                                      ]];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:NSStringFromClass([self class])];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifer = @"router_tablecell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifer];
    }
    CLTableItem *item = self.datas[indexPath.row];
    [cell.textLabel setText:item.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLTableItem *item = self.datas[indexPath.row];
    CLRouterRequest *routerRequest = [[CLRouterRequest alloc]init];
    routerRequest.strUrl = item.router;
//    routerRequest.viewController = self;
    [[CLRouterManager sharedManager] openURLWithRouterRequest:routerRequest callback:^(NSURL *URL, BOOL success) {
        NSLog(@"%s | %d | %@",__func__, success, URL);
    }];
}

@end

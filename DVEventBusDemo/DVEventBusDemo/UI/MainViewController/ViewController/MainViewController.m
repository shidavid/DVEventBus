//
//  MainViewController.m
//  DVDataBindDemo
//
//  Created by David on 2020/3/16.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableView.h"
#import "MainViewModel.h"
#import "MainTableDataSource.h"

@interface MainViewController () <MainTableDelegate>

@property(nonatomic, strong) UITableView *mainView;

@property(nonatomic, strong) MainTableDataSource *mainDataSource;
@property(nonatomic, strong) MainViewModel *mainViewModel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initViews];
    [self initModels];
    [self loadData];
}

#pragma mark - <-- Init -->
- (void)initViews {
    self.mainView = [[UITableView alloc] initWithFrame:DVFrame.frame_not_nav];
    [self.view addSubview:self.mainView];
}

- (void)initModels {
    self.mainViewModel = [[MainViewModel alloc] init];
    
    self.mainDataSource = [[MainTableDataSource alloc] initWithTableView:self.mainView];
    self.mainDataSource.delegate = self;
}

- (void)loadData {
    self.mainDataSource.models = self.mainViewModel.tableItems;
}


#pragma mark - <-- Delegate -->
- (void)MainTableDataSource:(MainTableDataSource *)dataSource didSelectItem:(NSString *)item {
    Class class = NSClassFromString(item);
    
    if (!class) return;
    
    __kindof UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

//
//  MainTableDataSource.m
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "MainTableDataSource.h"

@interface MainTableDataSource ()

@property(nonatomic, strong) NSArray<NSString *> *keys;

@end


@implementation MainTableDataSource

#pragma mark - <-- Initializer -->
- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

- (void)dealloc{
    if (_tableView) {
        _tableView.delegate = nil;
        _tableView.dataSource = nil;
        _tableView = nil;
    }
    
    _models = nil;
    _delegate = nil;
}


#pragma mark - <-- Property -->
- (void)setModels:(NSDictionary<NSString *,NSString *> *)models {
    _models = models;
    _keys = models.allKeys;
    if (self.tableView) [self.tableView reloadData];
}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.keys ? self.keys.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell && self.keys && indexPath.row < self.keys.count) {
        cell.textLabel.text = self.keys[indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && self.keys && indexPath.row < self.keys.count) {
        NSString *key = self.keys[indexPath.row];
        NSString *value = self.models[key];
        [self.delegate MainTableDataSource:self didSelectItem:value];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

@end

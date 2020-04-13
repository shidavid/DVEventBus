//
//  MainTableDataSource.h
//  DVEventBusDemo
//
//  Created by mlgPro on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - <-------------------- Protocol -------------------->
@class MainTableDataSource;
@protocol MainTableDelegate <NSObject>

- (void)MainTableDataSource:(MainTableDataSource *)dataSource didSelectItem:(NSString *)item;

@end


#pragma mark - <-------------------- Class -------------------->
@interface MainTableDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) id<MainTableDelegate> delegate;
@property(nonatomic, strong) NSDictionary<NSString *, NSString *> *models;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

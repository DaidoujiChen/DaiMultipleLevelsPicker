//
//  DaiMultipleLevelsPicker.m
//  DaiMultipleLevelsPicker
//
//  Created by DaidoujiChen on 2015/5/27.
//  Copyright (c) 2015年 DaidoujiChen. All rights reserved.
//

#import "DaiMultipleLevelsPicker.h"
#import <objc/runtime.h>

@interface UITableView (DaiMultipleLevelsPicker)

@property (nonatomic, assign) NSInteger daiMultipleLevelsPicker_selectedIndex;

@end

@implementation UITableView (DaiMultipleLevelsPicker)

- (void)setDaiMultipleLevelsPicker_selectedIndex:(NSInteger)daiMultipleLevelsPicker_selectedIndex {
    objc_setAssociatedObject(self, @selector(daiMultipleLevelsPicker_selectedIndex), @(daiMultipleLevelsPicker_selectedIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)daiMultipleLevelsPicker_selectedIndex {
    NSNumber *daiMultipleLevelsPicker_selectedIndex = objc_getAssociatedObject(self, _cmd);
    return daiMultipleLevelsPicker_selectedIndex.integerValue;
}

@end

@interface DaiMultipleLevelsPicker ()

@property (nonatomic, assign) CGFloat componentWidth;
@property (nonatomic, copy) DaiMultipleLevelsPickerRows rows;
@property (nonatomic, copy) DaiMultipleLevelsPickerCell cell;
@property (nonatomic, copy) DaiMultipleLevelsPickerHeight height;
@property (nonatomic, copy) DaiMultipleLevelsPickerSelected selected;

@end

@implementation DaiMultipleLevelsPicker

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rows(self, [self componet:tableView]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = self.cell(self, ^UITableViewCell *(NSString *identifier) {
        if (![tableView dequeueReusableCellWithIdentifier:identifier]) {
            [tableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
        }
        return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    }, [self componet:tableView], indexPath.row);
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.daiMultipleLevelsPicker_selectedIndex = indexPath.row;
    self.selected(self, [tableView cellForRowAtIndexPath:indexPath], [self componet:tableView], indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.height) {
        return self.height(self, [self componet:tableView], indexPath.row);
    }
    else {
        return 44.0f;
    }
}

#pragma mark - instance method

- (void)reloadAllComponents {
    [self.subviews makeObjectsPerformSelector:@selector(reloadData)];
}

- (void)reloadComponent:(NSInteger)component {
    UITableView *tableView = (UITableView *)[self.subviews objectAtIndex:component];
    [tableView reloadData];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component {
    UITableView *tableView = (UITableView *)[self.subviews objectAtIndex:component];
    [tableView.delegate tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    UITableView *tableView = (UITableView *)[self.subviews objectAtIndex:component];
    return tableView.daiMultipleLevelsPicker_selectedIndex;
}

#pragma mark - private instance method

- (NSInteger)componet:(UIView *)view {
    return [self.subviews indexOfObject:view];
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame components:(NSInteger)components rows:(DaiMultipleLevelsPickerRows)rows cell:(DaiMultipleLevelsPickerCell)cell selected:(DaiMultipleLevelsPickerSelected)selected {
    return [self initWithFrame:frame components:components rows:rows cell:cell height:nil selected:selected];
}

- (instancetype)initWithFrame:(CGRect)frame components:(NSInteger)components rows:(DaiMultipleLevelsPickerRows)rows cell:(DaiMultipleLevelsPickerCell)cell height:(DaiMultipleLevelsPickerHeight)height selected:(DaiMultipleLevelsPickerSelected)selected {
    self = [super initWithFrame:frame];
    if (self) {
        self.rows = rows;
        NSAssert(self.rows, @"rows is require");
        self.cell = cell;
        NSAssert(self.cell, @"cell is require");
        self.selected = selected;
        NSAssert(self.selected, @"selected is require");
        self.height = height;
        
        CGFloat viewWidth = CGRectGetWidth(frame);
        self.componentWidth = viewWidth / components;
        CGFloat height = CGRectGetHeight(frame);
        for (int index = 0; index < components; index++) {
            UITableView *newTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.componentWidth * index, 0, self.componentWidth, height) style:UITableViewStylePlain];
            newTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            newTableView.delegate = self;
            newTableView.dataSource = self;
            newTableView.daiMultipleLevelsPicker_selectedIndex = 0;
            [self addSubview:newTableView];
        }
    }
    return self;
}

@end

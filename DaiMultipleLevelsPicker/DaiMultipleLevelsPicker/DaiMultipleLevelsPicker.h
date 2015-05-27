//
//  DaiMultipleLevelsPicker.h
//  DaiMultipleLevelsPicker
//
//  Created by DaidoujiChen on 2015/5/27.
//  Copyright (c) 2015年 DaidoujiChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DaiMultipleLevelsPicker;

typedef NSInteger (^DaiMultipleLevelsPickerRows)(DaiMultipleLevelsPicker *picker, NSInteger component);
typedef UITableViewCell *(^DaiMultipleLevelsPickerDequeue)(NSString *identifier);
typedef UITableViewCell *(^DaiMultipleLevelsPickerCell)(DaiMultipleLevelsPicker *picker, DaiMultipleLevelsPickerDequeue dequeueIdentifier, NSInteger component, NSInteger row);
typedef CGFloat (^DaiMultipleLevelsPickerHeight)(DaiMultipleLevelsPicker *picker, NSInteger component, NSInteger row);
typedef void (^DaiMultipleLevelsPickerSelected)(DaiMultipleLevelsPicker *picker, id selectedItem, NSInteger component, NSInteger row);

@interface DaiMultipleLevelsPicker : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readonly) CGFloat componentWidth;

- (instancetype)initWithFrame:(CGRect)frame components:(NSInteger)components rows:(DaiMultipleLevelsPickerRows)rows cell:(DaiMultipleLevelsPickerCell)cell selected:(DaiMultipleLevelsPickerSelected)selected;
- (instancetype)initWithFrame:(CGRect)frame components:(NSInteger)components rows:(DaiMultipleLevelsPickerRows)rows cell:(DaiMultipleLevelsPickerCell)cell height:(DaiMultipleLevelsPickerHeight)height selected:(DaiMultipleLevelsPickerSelected)selected;

- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component;
- (NSInteger)selectedRowInComponent:(NSInteger)component;

@end

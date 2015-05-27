//
//  ViewController.m
//  DaiMultipleLevelsPicker
//
//  Created by DaidoujiChen on 2015/5/27.
//  Copyright (c) 2015年 DaidoujiChen. All rights reserved.
//

#import "ViewController.h"
#import "DaiMultipleLevelsPicker.h"
#import "ImageCell.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *level1components = @[@"水果", @"海鮮", @"高雄"];
    NSArray *level2components = @[@[@"香蕉", @"葡萄", @"橘子"], @[@"魚", @"蝦"], @[@"高雄"]];
    
    DaiMultipleLevelsPicker *newPicker = [[DaiMultipleLevelsPicker alloc] initWithFrame:self.view.bounds components:2 rows:^NSInteger(DaiMultipleLevelsPicker *picker, NSInteger component) {
        switch (component) {
            case 0:
                return level1components.count;
                
            case 1:
            {
                NSArray *items = level2components[[picker selectedRowInComponent:0]];
                return items.count;
            }
                
            default:
                return 0;
        }
    } cell:^UITableViewCell *(DaiMultipleLevelsPicker *picker, DaiMultipleLevelsPickerDequeue dequeueIdentifier, NSInteger component, NSInteger row) {
        switch (component) {
            case 0:
            {
                static NSString *identifier = @"UITableViewCell";
                UITableViewCell *cell = dequeueIdentifier(identifier);
                cell.textLabel.text = level1components[row];
                return cell;
            }
                
            case 1:
            {
                static NSString *identifier = @"ImageCell";
                ImageCell *cell = (ImageCell *)dequeueIdentifier(identifier);
                cell.backgroundColor = [UIColor redColor];
                NSArray *items = level2components[[picker selectedRowInComponent:0]];
                cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", items[row]]];
                return cell;
            }
                
            default:
                return nil;
                break;
        }
    } height:^CGFloat(DaiMultipleLevelsPicker *picker, NSInteger component, NSInteger row) {
        switch (component) {
            case 0:
                return 44;
                
            case 1:
                return picker.componentWidth;
                
            default:
                return 0;
        }
    } selected:^(DaiMultipleLevelsPicker *picker, id selectedItem, NSInteger component, NSInteger row) {
        switch (component) {
            case 0:
            {
                [picker reloadComponent:1];
                break;
            }
                
            case 1:
                NSLog(@"%d, %d", [picker selectedRowInComponent:0], [picker selectedRowInComponent:1]);
                break;
                
            default:
                break;
        }
    }];

    [newPicker selectRow:1 inComponent:0];
    [self.view addSubview:newPicker];
}

@end

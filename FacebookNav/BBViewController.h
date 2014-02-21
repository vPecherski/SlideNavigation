//
//  BBViewController.h
//  FacebookNav
//
//  Created by Mac on 1/30/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BBViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topLayer;
@property (nonatomic) CGFloat layerPosition;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UIView *bottomLayer;

@end

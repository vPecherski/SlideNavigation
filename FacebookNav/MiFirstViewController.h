//
//  MiFirstViewController.h
//  FacebookNav
//
//  Created by Mac on 2/12/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface MiFirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstLayer;
@property (nonatomic) CGFloat layerPosition;
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *profileMenu;
@property (nonatomic, strong) NSArray *settingsMenu;

@property (nonatomic,strong) NSMutableArray *allTouches;
@end

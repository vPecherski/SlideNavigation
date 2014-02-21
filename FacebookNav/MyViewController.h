//
//  MyViewController.h
//  FacebookNav
//
//  Created by Mac on 2/4/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *top;
@property (nonatomic) CGFloat position;
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *myArrayActivity;
@property (nonatomic, strong) NSMutableArray *myArrayProfile;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

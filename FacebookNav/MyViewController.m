//
//  MyViewController.m
//  FacebookNav
//
//  Created by Mac on 2/4/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()
@property (strong, nonatomic) NSArray *menu;
@end

@implementation MyViewController

@synthesize top = _top;
@synthesize position = _position;
@synthesize myArrayActivity = _myArrayActivity;
@synthesize myArrayProfile = _myArrayProfile;
@synthesize myTable = _myTable;
@synthesize menu;
@synthesize webView;

#define kLeftMargin      20.0
#define kTopMargin       20.0
#define kRightMargin     20.0
#define kTweenMargin     20.0
#define kTextFieldHeight 30.0

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"WebTitle", @"");
    
    // создание поля для ввода URL
    
    CGRect textFieldFrame = CGRectMake(kLeftMargin, kTweenMargin, CGRectGetWidth(self.view.bounds) - (kLeftMargin * 2.0), kTextFieldHeight);
    UITextField *urlField = [[UITextField alloc] initWithFrame:textFieldFrame];
    urlField.textColor = [UIColor blackColor];
    urlField.delegate = self;
    urlField.placeholder = @"введите адрес";
    urlField.text = @"http://fashiony.ru";
    urlField.backgroundColor = [UIColor whiteColor];
    urlField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    urlField.returnKeyType = UIReturnKeyGo;
    urlField.keyboardType = UIKeyboardTypeURL;
    urlField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    urlField.autocorrectionType = UITextAutocorrectionTypeNo;
    urlField.clearButtonMode = UITextFieldViewModeAlways;
    [urlField setAccessibilityLabel:NSLocalizedString(@"URLTextField", @"")];
    [self.view addSubview:urlField];
    
    //создание WebView
    CGRect webFrame = self.view.frame;
    webFrame.origin.y += (kTweenMargin * 2.0) + kTextFieldHeight; // оставляем пространство для поля ввода url
    webFrame.size.height -= 40.0;
    self.webView = [[UIWebView alloc] initWithFrame:webFrame];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    self.webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin);
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fashiony.ru"]]];
    
    /*
    NSURL *url = [NSURL URLWithString:@"http://fashiony.ru"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    */
    
    self.top.layer.shadowOffset = CGSizeMake(-1, 0); // создание тени у верхнего слоя
    self.top.layer.shadowOpacity = .9;
    //self.top.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.top.bounds].CGPath; // что делает??
    
    

    self.position = self.top.frame.origin.x;
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myArrayProfile = [NSMutableArray arrayWithObjects:@"Настройки", @"Получить PRO", @"Меня оценивают", nil];
    self.myArrayActivity = [NSMutableArray arrayWithObjects:@"Мои публикации", @"Мои комментарии", @"Избранное", @"Любимые картинки", nil];
    
    self.menu = [NSArray arrayWithObjects:self.myArrayActivity, self.myArrayProfile, nil];
    //self.section1 = [NSArray arrayWithObjects:@"letItBe", @"first", @"table", nil];
    //self.section2 = [NSArray arrayWithObjects:@"noDoubt", @"Dont Speak", nil];
    
}


#define VIEW_HIDDEN 260

- (void)animateLayerToPoint:(CGFloat)x {
    
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: UIViewAnimationCurveEaseOut
                     animations: ^{
                         CGRect frame = self.top.frame;
                         frame.origin.x = x;
                         self.top.frame = frame;
                     }
                     completion: ^(BOOL finished){
                         self.position = self.top.frame.origin.x;
                     }];
}

- (IBAction)panGesture:(UIPanGestureRecognizer*)pan {
    
    if (pan.state == UIGestureRecognizerStateChanged || self.top.frame.origin.x !=0) {
        CGPoint point = [pan translationInView:self.top];
        CGRect frame = self.top.frame;
        frame.origin.x = self.position + point.x;
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        self.top.frame = frame;
        
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (self.top.frame.origin.x <= 160) {
            [self animateLayerToPoint:0];
        } else {
            [self animateLayerToPoint: VIEW_HIDDEN];
        }
    }
}

- (IBAction)menuButton:(id)sender {
    
    if (self.position == VIEW_HIDDEN) {
        [self animateLayerToPoint:0];
    } else {
        [self animateLayerToPoint:VIEW_HIDDEN];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.menu count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    if (section == 0) {
        return [self.myArrayActivity count];
    } else if (section == 1) {
        return [self.myArrayProfile count];
    }
    return 0;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return @"Активность";
        
    } else if (section == 1) {
        
        return @"Профиль";
    }
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.detailTextLabel.text = @"2014";
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.myArrayActivity[indexPath.row]];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.myArrayProfile[indexPath.row]];
    }
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", self.myArray[indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *newTopViewController;
    
    if (indexPath.section == 0) {
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
    } else if (indexPath.section == 1) {
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    
    //NSString *identifier = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
    //UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}
*/

@end

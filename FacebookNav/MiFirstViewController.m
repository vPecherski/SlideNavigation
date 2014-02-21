//
//  MiFirstViewController.m
//  FacebookNav
//
//  Created by Mac on 2/12/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MiFirstViewController.h"

@interface MiFirstViewController ()

@end

@implementation MiFirstViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.sections = @[@"Активность", @"Настройки"];
    self.profileMenu = @[@"Мои публикации", @"Мои комменты", @"Комменты к публикациям", @"Любимые картинки"];
    self.settingsMenu = @[@"Мой профиль", @"Получить PRO", @"Приглашения"];
    
    self.allTouches = [NSMutableArray array];
    self.view.multipleTouchEnabled = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.allTouches addObjectsFromArray:[touches allObjects]];
    UITouch *touch = [self.allTouches objectAtIndex:0];
    CGPoint pointOfTouch = [touch locationInView:self.view];
    NSLog(@"point of touch %.2f", pointOfTouch.x);
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [self.allTouches objectAtIndex:0];
    CGPoint pointOfTouch = [touch locationInView:self.view];
    NSLog(@"point of touch %.2f", pointOfTouch.x);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.allTouches removeObjectsInArray:[touches allObjects]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.sections[0];
            break;
        case 1:
            return self.sections[1];
            break;
        default:
            return 0;
            break;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.profileMenu count];
            break;
        case 1:
            return [self.settingsMenu count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.profileMenu[indexPath.row];
            return cell;
            break;
        case 1:
            cell.textLabel.text = self.settingsMenu[indexPath.row];
            return cell;
            break;
            
        default:
            return 0;
            break;
    }
    
}


#define View_Hidden 260

- (void)animateLayerToPoint:(CGFloat)x {
    
    [UIView animateWithDuration: 0.3
                          delay: 0
                        options: UIViewAnimationCurveEaseOut
                     animations: ^{
                         CGRect frame = self.firstLayer.frame;
                         frame.origin.x = x;
                         self.firstLayer.frame = frame;
                     }
                     completion: ^(BOOL finished){self.layerPosition = self.firstLayer.frame.origin.x;}];
    
}

- (IBAction)myGesture:(UIPanGestureRecognizer *)pan {
    
    CGFloat layerPosition2 = self.firstLayer.frame.origin.x;
    int i = 0;
    if (layerPosition2 == 0.0) {
        i = 1;
        NSLog(@"succsess");
    }
    CGPoint pointCash;
    if (i ==1) {
        pointCash = [pan translationInView:self.firstLayer];
    }
        
    

    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [pan translationInView:self.firstLayer];
        pointCash = point;
        
        //UITouch *touch = [self.allTouches objectAtIndex:0];
        //CGPoint pointOfTouch = [touch locationInView:self.view];
        
        CGRect frame = self.firstLayer.frame;
        frame.origin.x = self.layerPosition + abs(point.x);
        
        //NSLog(@"point %.2f vs pointoftouch %.2f position %.2f layer %.2f", point.x, pointOfTouch.x, frame.origin.x, self.layerPosition);
        
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        if (frame.origin.x > View_Hidden) {
            frame.origin.x = View_Hidden;
        }
        self.firstLayer.frame = frame;
        
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [pan translationInView:self.firstLayer];
        NSLog(@"%.2f position %.2f", point.x, layerPosition2);
        
        if (point.x < 0.0) {
            [self animateLayerToPoint:0];
        } else {
            [self animateLayerToPoint:View_Hidden];
        }
        /*
        if ((self.firstLayer.frame.origin.x <= View_Hidden / 2 * 3) || point.x < 0.0) {
            [self animateLayerToPoint:0];
        } else if ((self.firstLayer.frame.origin.x >= View_Hidden / 1 * 3) || point.x > 0.0){
            [self animateLayerToPoint:View_Hidden];
        }
         */
        
        
    }

}

- (IBAction)menuBtn:(id)sender {
    
    if (self.layerPosition == View_Hidden) {
        [self animateLayerToPoint:0];
    } else {
        [self animateLayerToPoint:View_Hidden];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

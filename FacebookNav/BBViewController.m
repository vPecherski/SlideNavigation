//
//  BBViewController.m
//  FacebookNav
//
//  Created by Mac on 1/30/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "BBViewController.h"

@interface BBViewController ()

@end

@implementation BBViewController

@synthesize topLayer = _topLayer;
@synthesize layerPosition = _layerPosition;
@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.topLayer.layer.shadowOffset = CGSizeMake(-2, 0); // создание тени у верхнего слоя
    self.topLayer.layer.opacity = 1;
    self.topLayer.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.topLayer.bounds].CGPath; // ?? не дает смещаться верхнему слою, когда открыто доп меню
    
    
	    
    // Do any additional setup after loading the view, typically from a nib.
    self.layerPosition = self.topLayer.frame.origin.x;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dataArray = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", nil];
    
}

#define VIEW_HIDDEN 260

- (void)animateLayerToPoint:(CGFloat)x { //анимация верхнего слоя
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect frame = self.topLayer.frame;
                         frame.origin.x = x;
                         self.topLayer.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         self.layerPosition = self.topLayer.frame.origin.x;
                     }];
}

- (IBAction)toggleLayer:(id)sender { //действие на кнопке слева вверху в верхнем слое
    
    if (self.layerPosition == VIEW_HIDDEN) {
        [self animateLayerToPoint:0];
    } else {
        [self animateLayerToPoint:VIEW_HIDDEN];
    }
}

- (IBAction)panLayer:(UIPanGestureRecognizer *)pan { // обработка касаний
    
    CGFloat layerPosition2 = self.topLayer.frame.origin.x; // координата верхнего слоя
    
    CGPoint point2 = [pan locationInView:self.topLayer]; // точка касания к верхнему слою
    NSLog(@"coordinate %.2f and point %.2f - %.2f", layerPosition2, point2.x, point2.y);
    
    //((pan.state == UIGestureRecognizerStateChanged && frame2 > 40 && frame2 < 230) || (point2.x > 0 && point2.x < 60 && pan.state == UIGestureRecognizerStateChanged))
    if (pan.state == UIGestureRecognizerStateChanged && ((layerPosition2 > 40 && layerPosition2 < 230) || (point2.x > 0 && point2.x < 60))) { // когда позиция измененяется, т.е. двигаешь пальцем по экрану
        
        CGPoint point = [pan translationInView:self.topLayer]; // translationInView - translation in the coordinate system of the specified view
        point2 = point;
        layerPosition2 = self.topLayer.frame.origin.x;
        
        CGRect frame = self.topLayer.frame;
        frame.origin.x = self.layerPosition + point.x;
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        self.topLayer.frame = frame;
        
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) { // когда убрал палец
        
        if (self.topLayer.frame.origin.x <= 200) { // количество пикселей в отступе слева, необходимое для сдвига
            
            [self animateLayerToPoint:0];
            
        } else if (self.topLayer.frame.origin.x >= 10) {
            
            [self animateLayerToPoint: VIEW_HIDDEN];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %i", indexPath.row+1];
    cell.detailTextLabel.text = @"2014";
    
    return cell;
}


@end

//
//  ViewController.m
//  TransitionsAnimationDemo
//
//  Created by aaron on 16/4/17.
//  Copyright © 2016年 decai wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) CAShapeLayer *shaperlayer;

@end

@implementation ViewController

#pragma mark - lifr cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self drawCircle2];
    
}
- (IBAction)startDoAnimation:(UIButton *)sender {
    
    self.shaperlayer = [self drawCircle];
    
    self.shaperlayer.strokeStart = 0.0;
    self.shaperlayer.strokeEnd = 0.0;
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateCircle) userInfo:nil repeats:YES];
    
}

- (CAShapeLayer *)drawCircle{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position = self.view.center;
    shapeLayer.bounds = CGRectMake(0, 0, self.view.bounds.size.width * 0.25, self.view.bounds.size.width * 0.25);
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 1.5f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds];
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

- (CAShapeLayer *)drawCircle2{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position = self.view.center;
    shapeLayer.bounds = CGRectMake(0, 0, 200, 200);
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 1.5f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(shapeLayer.bounds, -50, -50)];
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

- (void)updateCircle{

    if (self.shaperlayer.strokeStart == 0  && self.shaperlayer.strokeEnd < 1.0) {
        self.shaperlayer.strokeEnd += 0.1;
    }
    else if (self.shaperlayer.strokeEnd >= 1.0 && self.shaperlayer.strokeStart < 1.0){
        self.shaperlayer.strokeStart += 0.1;
    }
    else if (self.shaperlayer.strokeStart >= 1.0 && self.shaperlayer.strokeEnd >= 1.0){
        self.shaperlayer.strokeStart = 0;
        self.shaperlayer.strokeEnd = 0;
    }
    
}
@end

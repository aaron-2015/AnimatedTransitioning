//
//  SecondViewController.m
//  TransitionsAnimationDemo
//
//  Created by aaron on 16/4/17.
//  Copyright © 2016年 decai wang. All rights reserved.
//

#import "SecondViewController.h"
#import "PopAnimation.h"

@interface SecondViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentInteractiveTransition;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
}

- (void)edgePan:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat per = [gestureRecognizer locationInView:self.view].x / self.view.bounds.size.width;
    per = MIN(1, MAX(0, per));
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _percentInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        [_percentInteractiveTransition updateInteractiveTransition:per];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled){
        if (per > 0.3) {
            [_percentInteractiveTransition finishInteractiveTransition];
        } else {
            [_percentInteractiveTransition cancelInteractiveTransition];
        }
        _percentInteractiveTransition = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}


- (IBAction)popClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return _percentInteractiveTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        PopAnimation *pop = [PopAnimation new];
        return pop;
    }else {
        return nil;
    }
}

@end

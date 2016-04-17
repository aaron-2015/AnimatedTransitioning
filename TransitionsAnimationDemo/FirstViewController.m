//
//  FirstViewController.m
//  TransitionsAnimationDemo
//
//  Created by aaron on 16/4/17.
//  Copyright © 2016年 decai wang. All rights reserved.
//

#import "FirstViewController.h"
#import "PushAnimation.h"
#import "SecondViewController.h"

@interface FirstViewController ()<UINavigationControllerDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        PushAnimation *push = [PushAnimation new];
        return push;
    }else {
        return nil;
    }
}

@end

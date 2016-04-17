//
//  PushAnimation.m
//  TransitionsAnimationDemo
//
//  Created by aaron on 16/4/17.
//  Copyright © 2016年 decai wang. All rights reserved.
//

#import "PushAnimation.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface PushAnimation ()
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PushAnimation

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7f;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    FirstViewController *fromVC = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contain = transitionContext.containerView;
    [contain addSubview:fromVC.view];
    [contain addSubview:toVC.view];
    
    UIButton *pushButton = fromVC.button;
    UIBezierPath *startpath = [UIBezierPath bezierPathWithOvalInRect:pushButton.frame];
    
    CGPoint finalPoint;
    //根据终点位置所在象限的不同,计算覆盖的最大半径
    if (pushButton.frame.origin.x > toVC.view.bounds.size.width * 0.5 ) {
        if (pushButton.frame.origin.y < toVC.view.bounds.size.height * 0.5) { //第一象限
            finalPoint = CGPointMake(pushButton.center.x , pushButton.center.y - toVC.view.bounds.size.height);
        } else {          //第四现象
            finalPoint = CGPointMake(pushButton.center.x , pushButton.center.y);
        }
    } else {
        if (pushButton.frame.origin.y < toVC.view.bounds.size.height * 0.5) { //第二象限
            finalPoint = CGPointMake(pushButton.center.x - toVC.view.bounds.size.width , pushButton.center.y - toVC.view.bounds.size.height);
        } else {          //第三现象
            finalPoint = CGPointMake(pushButton.center.x - toVC.view.bounds.size.width, pushButton.center.y);
        }
    }
    
    CGFloat radius = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y);
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(pushButton.frame, -radius, -radius)]; //-radius表示增大,+radius表示缩小
    
    //创建一个 CAShapeLayer 作为 toView 的遮罩。并让遮罩发生 path 属性的动画
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startpath.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:self.transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"push"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end

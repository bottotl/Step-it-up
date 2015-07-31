//
//  RootTabViewController.m
//  Step-it-up
//
//  Created by syfll on 15/7/29.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import "RootTabViewController.h"
#import "Todo_RootViewController.h"
#import "BaseNavigationController.h"
#import "Me_RootViewController.h"
#import "Discover_RootViewController.h"
#import "Group_RootViewController.h"

#import "RDVTabBarItem.h"

@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Private_M
- (void)setupViewControllers {
    
    //Init ViewController
    Todo_RootViewController *todo = [[Todo_RootViewController alloc]init];
     UINavigationController *nav_project = [[BaseNavigationController alloc] initWithRootViewController:todo];
    
    Discover_RootViewController *discover = [[Discover_RootViewController alloc]init];
    UINavigationController *nav_discover = [[BaseNavigationController alloc] initWithRootViewController:discover];
    
    Group_RootViewController *group = [[Group_RootViewController alloc]init];
    UINavigationController *nav_group = [[BaseNavigationController alloc] initWithRootViewController:group];
    
    Me_RootViewController *me = [[Me_RootViewController alloc]init];
    UINavigationController *nav_me = [[BaseNavigationController alloc] initWithRootViewController:me];
    
    
    
    
    //Set TabBar's ViewControllers
    [self setViewControllers:@[nav_project,nav_group,nav_discover,nav_me]];
    
    
    //Call customize TabBar
    [self customizeTabBarForController];
    self.delegate = self;
}


//Set TabBarItems's image and name
- (void)customizeTabBarForController {
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    NSArray *tabBarItemImages = @[@"project", @"privatemessage", @"tweet", @"me"];
    NSArray *tabBarItemTitles = @[@"日程",@"群组",@"发现",@"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}

#pragma mark - RDVTabBarControllerDelegate
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(tabBarController.selectedViewController != viewController){
        return YES;
    }

    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
    if ([nav.topViewController isKindOfClass:[BaseViewController class]]) {
        
        BaseViewController *rootVC = (BaseViewController *)nav.topViewController;
        [rootVC tabBarItemClicked];
    }
//    if ([nav isKindOfClass:[RKSwipeBetweenViewControllers class]]) {
//        RKSwipeBetweenViewControllers *swipeVC = (RKSwipeBetweenViewControllers *)nav;
//        if ([[swipeVC curViewController] isKindOfClass:[BaseViewController class]]) {
//            BaseViewController *rootVC = (BaseViewController *)[swipeVC curViewController];
//            [rootVC tabBarItemClicked];
//        }
//    }else{
//        if ([nav.topViewController isKindOfClass:[BaseViewController class]]) {
//            BaseViewController *rootVC = (BaseViewController *)nav.topViewController;
//            [rootVC tabBarItemClicked];
//        }
//    }
    return YES;
}
@end

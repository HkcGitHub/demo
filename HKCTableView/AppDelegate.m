//
//  AppDelegate.m
//  HKCTableView
//
//  Created by 黄堪川 on 2022/4/4.
//

#import "AppDelegate.h"
#import "HKCOneViewController.h"
#import "HKCTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
   HKCTabBarController *view = [[HKCTabBarController alloc]init];
   self.window.rootViewController = view;
    [self.window makeKeyAndVisible];
    return YES;
}




@end

//
//  HKCTabBarController.m
//  HKCTableView
//
//  Created by 黄堪川 on 2022/4/6.
//

#import "HKCTabBarController.h"
#import "HKCOneViewController.h"
#import "HKChatViewController.h"
#import "HKCMeViewController.h"
#import "HKCTabBar.h"

@interface HKCTabBarController ()
@property(nonatomic, strong)NSString *tag;
@end

@implementation HKCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor =[UIColor whiteColor];
    
    self.navigationController.toolbarHidden = YES;

    
    HKCOneViewController *v1 = [[HKCOneViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:v1];
    
    HKChatViewController *v2 = [[HKChatViewController alloc]init];
    v2.view.backgroundColor = [UIColor yellowColor];
    
    HKCMeViewController *v3 = [[HKCMeViewController alloc]init];
    v3.view.backgroundColor = [UIColor grayColor];
    self.viewControllers = @[nav,v2,v3,];
    
    
    HKCTabBar *tabbar = [[HKCTabBar alloc]init];
    // 3.使用 block(遵守协议,使用代理方法)
    __weak HKCTabBarController* weakSelf = self;
    tabbar.tabBarButtonBlock = ^(NSInteger index) {
        weakSelf.selectedIndex = index;
        self.tag = [NSString stringWithFormat:@"%ld",(long)index];
    };
    tabbar.frame = self.tabBar.bounds;
    
    for (int i = 0; i< self.viewControllers.count; i++) {
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"tab%d", i + 1]];
        UIImage* imagePress = [UIImage imageNamed:[NSString stringWithFormat:@"tab%d_s", i + 1]];
        [tabbar addButtonWithImage:image andImageSel:imagePress];
    }
    [self.tabBar addSubview:tabbar];

}

@end

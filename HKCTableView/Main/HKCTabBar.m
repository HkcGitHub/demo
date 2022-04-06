//
//  HKCTabBar.m
//  AccountBook
//
//  Created by 黄堪川 on 2022/3/20.
//

#import "HKCTabBar.h"

@interface HKCTabBarButton : UIButton

@end

@implementation HKCTabBarButton

- (void)setHighlighted:(BOOL)highlighted
{
}
@end

@interface HKCTabBar ()

@property (nonatomic, weak) UIButton * currentButton;

@end
#define HKCScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation HKCTabBar

-(void)addButtonWithImage:(UIImage *)image andImageSel:(UIImage *)imageSel
{
    HKCTabBarButton *tabbarButton = [[HKCTabBarButton alloc]init];

    [tabbarButton setImage:image forState:UIControlStateNormal];

    [tabbarButton setImage:imageSel forState:UIControlStateSelected];
    // 监听 btn
    [tabbarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabbarButton];
        
}
// 点击 tabbar 上按钮的时候调用
- (void)tabBarButtonClick:(UIButton*)sender
{
    // 取消记录的按钮的选中状态
    self.currentButton.selected = NO;
    // 设置点击的按钮为选中状态
    sender.selected = YES;
    // 记录选中的按钮
    self.currentButton = sender;
    // 判断 block 是否有值(代理方法 是不是能够响应)
       if (self.tabBarButtonBlock) {
            // 2.执行 block(执行代理方法)
            self.tabBarButtonBlock(sender.tag);
       }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *tabBtn = self.subviews[i];
       
        // 设置 tag 切换控制器
        tabBtn.tag = i;
        CGFloat w = HKCScreenWidth /3;
        CGFloat h = 50;
        CGFloat x = i * w;
        CGFloat y = 0;
        tabBtn.frame = CGRectMake(x, y, w, h);
    
        // 第一个按钮
        if (i == 0) {
            [self tabBarButtonClick:tabBtn];
        }

    }
}

@end

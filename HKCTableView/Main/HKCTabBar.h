//
//  HKCTabBar.h
//  AccountBook
//
//  Created by 黄堪川 on 2022/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HKCTabBar : UIView

@property (nonatomic,copy)void (^tabBarButtonBlock)(NSInteger);

- (void)addButtonWithImage:(UIImage *)image andImageSel:(UIImage *)imageSel;

@end

NS_ASSUME_NONNULL_END

//
//  HKCOneViewController.m
//  HKCTableView
//
//  Created by 黄堪川 on 2022/4/4.
//

#import "HKCOneViewController.h"
#import "HKCSecondViewController.h"
#import "HKCThirdViewController.h"
#import "HKCFourViewController.h"


@interface HKCOneViewController ()<UIScrollViewDelegate>
{
    UIScrollView *mainScrollView;
}
@property (nonatomic, strong)HKCSecondViewController *secondView;
@property (nonatomic, strong)HKCThirdViewController *thirdView;
@property (nonatomic, strong)HKCFourViewController *fourView;

@property (nonatomic,strong) UIButton *nearbyBtn;
@property (nonatomic,strong) UIButton *squareBtn;
@property (nonatomic,strong) UIButton *recommendBtn;

@property (nonatomic, strong) UILabel  *sliderLabel;
@property (nonatomic, strong) UIView *navView;

@end
#define HKCScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation HKCOneViewController

-(HKCSecondViewController *)secondView
{
    if (!_secondView) {
        _secondView = [[HKCSecondViewController alloc]init];
    
    }
    return _secondView;
}


-(HKCThirdViewController *)thirdView
{
    if (!_thirdView) {
        _thirdView = [[HKCThirdViewController alloc]init];
        
    }
    return  _thirdView;
}

-(HKCFourViewController *)fourView
{
    if (!_fourView) {
        _fourView = [[HKCFourViewController alloc]init];
    }
    return  _fourView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creationView];
    [self setNavigationBarColor];
    
    [self setMainSrollView];
    //设置默认
    [self sliderWithTag:self.currentIndex+1];
    
}



-(void)setNavigationBarColor
{
   
    //ios 15系统
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc]init];
        //添加背景色
       appperance.backgroundColor =[UIColor blueColor];
       appperance.shadowImage = [[UIImage alloc]init];
        //设置字体颜色大小
        [appperance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        self.navigationController.navigationBar.standardAppearance = appperance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appperance;
    }
}
-(void)creationView
{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HKCScreenWidth, 40)];
    _nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nearbyBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_nearbyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _nearbyBtn.frame = CGRectMake(0, 0, HKCScreenWidth/3, _navView.frame.size.height);
    _nearbyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [_nearbyBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [_nearbyBtn setTitle:@"附近" forState:UIControlStateNormal];
    _nearbyBtn.tag = 1;
    _nearbyBtn.selected = YES;
    
    [_navView addSubview:_nearbyBtn];
    
    _squareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _squareBtn.frame = CGRectMake(_nearbyBtn.frame.origin.x+_nearbyBtn.frame.size.width, _nearbyBtn.frame.origin.y, HKCScreenWidth/3, _navView.frame.size.height);
    [_squareBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_squareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

   _squareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_squareBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [_squareBtn setTitle:@"广场" forState:UIControlStateNormal];
    _squareBtn.tag = 2;
    [_navView addSubview:_squareBtn];
    
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(_squareBtn.frame.origin.x+_squareBtn.frame.size.width, _squareBtn.frame.origin.y, HKCScreenWidth/3, _navView.frame.size.height);
    [_recommendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_recommendBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    _recommendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_recommendBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    _recommendBtn.tag = 3;
    [_navView addSubview:_recommendBtn];
    
    _sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40-2, HKCScreenWidth/3, 4)];
    _sliderLabel.backgroundColor = [UIColor redColor];
    [_navView addSubview:_sliderLabel];
    
    self.navigationItem.titleView = _navView;
    
}
-(void)setMainSrollView{
    
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, HKCScreenWidth, self.view.frame.size.height)];
    mainScrollView.delegate = self;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    
    NSArray *views = @[self.secondView.view,self.thirdView.view,self.fourView.view];
    
    for (int i = 0; i< views.count; i ++) {
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(HKCScreenWidth*i, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
        [pageView addSubview:views[i]];
        [mainScrollView addSubview:pageView];
    }
    mainScrollView.contentSize = CGSizeMake(HKCScreenWidth*(views.count), 0);
    [mainScrollView setContentOffset:CGPointMake((mainScrollView.frame.size.width)*_currentIndex, 0) animated:YES];
       
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat contenoffSetX = scrollView.contentOffset.x;
    CGFloat X = contenoffSetX *(HKCScreenWidth/3)/HKCScreenWidth;
   CGRect frame = _sliderLabel.frame;
   frame.origin.x= X;
    _sliderLabel.frame = frame;

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    int index = contentOffSetX/HKCScreenWidth;
    [self sliderWithTag:index+1];
}
-(void)sliderWithTag:(NSInteger)tag{
    self.currentIndex = tag;
    _nearbyBtn.selected = NO;
    _squareBtn.selected = NO;
    _recommendBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
        _sliderLabel.frame = CGRectMake(sender.frame.origin.x, _sliderLabel.frame.origin.y, _sliderLabel.frame.size.width, _sliderLabel.frame.size.height);
        _nearbyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _squareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _recommendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:19];
}
-(UIButton *)buttonWithTag:(NSInteger )tag{
    if (tag==1) {
        return _nearbyBtn;
    }else if (tag==2){
        return _squareBtn;
    }else if (tag==3){
        return _recommendBtn;
    }else{
        return nil;
    }
}


-(void)sliderAction:(UIButton *)sender{
    if (self.currentIndex==sender.tag) {
        return;
    }
    [self sliderAnimationWithTag:sender.tag];
    [UIView animateWithDuration:0.3 animations:^{
        
        mainScrollView.contentOffset = CGPointMake(HKCScreenWidth*(sender.tag-1), 0);
    } completion:^(BOOL finished) {        
    }];
}

-(void)sliderAnimationWithTag:(NSInteger)tag{
    self.currentIndex = tag;
    _nearbyBtn.selected = NO;
    _squareBtn.selected = NO;
    _recommendBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        _sliderLabel.frame = CGRectMake(sender.frame.origin.x, _sliderLabel.frame.origin.y, _sliderLabel.frame.size.width, _sliderLabel.frame.size.height);
        
    } completion:^(BOOL finished) {
        _nearbyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _squareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _recommendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    }];
}
@end

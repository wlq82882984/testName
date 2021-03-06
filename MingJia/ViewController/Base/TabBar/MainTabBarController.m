#import "MainTabBarController.h"
#import "UIColor+Hex.h"
#import "BaseNavigationController.h"
#import "MJMyInfoViewController.h"
#import "MJHomeViewController.h"
#import "MJServiceViewController.h"
#import "MJFindFriendViewController.h"

static MainTabBarController *mainTabBar = nil;

@interface MainTabBarController ()

@end

@implementation MainTabBarController

+ (instancetype)sharedMainTb
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainTabBar = [[MainTabBarController alloc] init];
    });
    return mainTabBar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BaseNavigationController *nvc1 = [[BaseNavigationController alloc] initWithRootViewController:[[MJHomeViewController alloc]init]];
    
    BaseNavigationController *nvc2 = [[BaseNavigationController alloc] initWithRootViewController:[[MJServiceViewController alloc]init]];
    
    BaseNavigationController *nvc3 = [[BaseNavigationController alloc] initWithRootViewController:[[MJFindFriendViewController alloc]init]];
    
    BaseNavigationController *nvc4 = [[BaseNavigationController alloc] initWithRootViewController:[[MJMyInfoViewController alloc]init]];
    
    //4、指定tabVC的所有子控制器
    self.viewControllers=@[nvc1,nvc2,nvc3,nvc4];
    
    [self customTabBar];
    [self selectedTabAtIndex:0];
    
    //在这里扫除掉所有原有的tabbar上面的子视图，以免对后来的自定义tabbar造成影响
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - private
- (void)setButtonImageAndText:(NSInteger)index isSelected:(BOOL)select
{
    UIButton *btn =  (UIButton *)[_buttons objectAtIndex:index];
    btn.selected = select;
    //    btn.userInteractionEnabled = !select;   //重复点击不响应
}

-(void)initRedRoll{
    
    UIImage* image = [UIImage imageNamed:@"redroll"];
    self.recordRoll = [[UIImageView alloc] initWithFrame:CGRectMake(50+64, 7, 8, 8)];
    [self.recordRoll setImage:image];
    
    self.discoverRoll = [[UIImageView alloc] initWithFrame:CGRectMake(50+64*2, 7, 8, 8)];
    [self.discoverRoll setImage:image];
    
    self.shareRoll = [[UIImageView alloc] initWithFrame:CGRectMake(50+64*3, 7, 8, 8)];
    [self.shareRoll setImage:image];
    
}

#pragma for add red roll
-(void)setRoll:(int)_num{
    
    CALayer *lay = nil;
    if (_num == 1) {
        lay = self.recordRoll.layer;
        [lay setMasksToBounds:YES];
        [lay setCornerRadius:4.0];
        [self.tabBar addSubview:self.recordRoll];
        
    }else if(_num == 2){
        lay = self.discoverRoll.layer;
        [lay setMasksToBounds:YES];
        [lay setCornerRadius:4.0];
        [self.tabBar addSubview:self.discoverRoll];
        
    }else{
        lay = self.shareRoll.layer;
        [lay setMasksToBounds:YES];
        [lay setCornerRadius:4.0];
        [self.tabBar addSubview:self.shareRoll];
        
    }
}

-(void)removeRoll:(int)_num{
    if (_num == 1) {
        [self.recordRoll removeFromSuperview];
    }else if(_num == 2){
        [self.discoverRoll removeFromSuperview];
    }else{
        [self.shareRoll removeFromSuperview];
    }
}

#pragma for add animation of add record
-(void)addRecordAnimation:(NSString*)_result{
}

- (void)selectedTab:(UIButton*)button
{
    
    if (self.forbidSwitchBar) {
        if (self.selectedIndex == 0) {
            // 测试过程中，不让tab切换，并且自动跳到测试页面
            self.shouldSelectedIndex = 0;
            
            if (self.selectedIndex < 5) {
                [self setButtonImageAndText:self.selectedIndex isSelected:NO];
            }
            //焦点切换
            self.selectedIndex = self.shouldSelectedIndex;
            [self setButtonImageAndText:self.selectedIndex isSelected:YES];
            
            UIAlertView* alert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Compelte_Test", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"Close", nil) otherButtonTitles:nil, nil];
            [alert show];
        }else{
            
        }
        return;
    }
    
    if (button.selected)
    {
//        [[self.viewControllers objectAtIndex:button.tag] popToRootViewControllerAnimated:YES];
    }
    
    self.shouldSelectedIndex = button.tag;
    
    if (self.selectedIndex < 4) {
        [self setButtonImageAndText:self.selectedIndex isSelected:NO];
    }
    //焦点切换
    self.selectedIndex = self.shouldSelectedIndex;
    [self setButtonImageAndText:self.selectedIndex isSelected:YES];
    
    //    [self imgAnimate:button];
    
}

-(void)hideTabBar
{
    [self.tabBar setHidden:YES];
}

- (void)customTabBar{
    UIView *tabBarBackGroundView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    UILabel *tapline = [UILabel createLabelWithFrame:CGRectMake(0, 0, ScreenWidth, 1) backgroundColor:[UIColor lightTextColor] textColor:CLEAN_COLOR font:SYSTEM_FONT_(2) textalignment:NSTextAlignmentLeft text:@""];
    [tabBarBackGroundView addSubview:tapline];
    tabBarBackGroundView.backgroundColor = [UIColor colorWithHex:0xf5f5f5 alpha:1.0];
    
    //创建按钮
    NSInteger viewCount = 4;
    self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
    NSLog(@"self.tabBar.frame.size.width=%f",[UIScreen mainScreen].bounds.size.width);
    CGFloat _width = self.tabBar.frame.size.width / viewCount;
    CGFloat _height = self.tabBar.frame.size.height;
    
    NSArray * arrIcon = [[NSArray alloc] initWithObjects:
                         @"首页_首页未选中", @"首页_首页选中",
                         @"首页_服务未选中", @"首页_服务选中",
                         @"首页_邀请未选中", @"首页_邀请选中",
                         @"首页_个人未选中", @"首页_个人选中",
                         nil];
    NSArray *arrTitle = [NSArray arrayWithObjects:@" 首页",@"      明佳服务",@"      邀请好友",@"        个人", nil];
    if (ScreenWidth <= 320) {
        arrTitle = [NSArray arrayWithObjects:@"    首页",@"     明佳服务",@"     邀请好友",@"     个人", nil];
    }
    
    for (NSInteger i = 0; i < viewCount; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttons addObject:btn];
        
        [tabBarBackGroundView addSubview:btn];
        btn.titleLabel.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, 38, btn.frame.size.height);
        
        btn.frame = CGRectMake((i*_width)-0.5, 0, _width+1, _height);
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:[arrIcon objectAtIndex:(NSInteger)(i*2)]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[arrIcon objectAtIndex:(NSInteger)(i*2+1)]] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:[arrIcon objectAtIndex:(NSInteger)(i*2+1)]] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:[arrIcon objectAtIndex:(NSInteger)(i*2+1)]] forState:5];
        
        [btn setTitleColor:TABBAR_TEXT_COLOR_NOR forState:UIControlStateNormal];
        [btn setTitleColor:TABBAR_TEXT_COLOR_SEL forState:UIControlStateHighlighted];
        [btn setTitleColor:TABBAR_TEXT_COLOR_SEL forState:UIControlStateSelected];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-14, _width/2-btn.imageView.frame.size.width/2, 0, 10)];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, _width/2-btn.imageView.frame.size.width/2, btn.frame.size.height / 2 - 10, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, -25, 0, 0)];
        
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, -_width/2 + btn.titleLabel.frame.size.width/2, 0, 0)];
        
        [btn setTitle:[arrTitle objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        [self setButtonImageAndText:(NSInteger)(i) isSelected:NO];
    }
    [self.tabBar addSubview:tabBarBackGroundView];
    
    [self selectedTab:[self.buttons objectAtIndex:0]];
}


- (void)selectedTabAtIndex:(NSInteger)index
{
    
    self.shouldSelectedIndex = index;
    
    if (self.selectedIndex < 4) {
        [self setButtonImageAndText:self.selectedIndex isSelected:NO];
    }
    
    //切换焦点
    self.selectedIndex = self.shouldSelectedIndex;
    [self setButtonImageAndText:self.selectedIndex isSelected:YES];
}

- (void)imgAnimate:(UIButton*)_btn{
    
    UIView *view=_btn.subviews[1];
    UIView *view2=_btn.subviews[2];
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.50;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.35, 1.35, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 0.8)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
    [view2.layer addAnimation:animation forKey:nil];
}


-(UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
{
    UIImage *img = nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
@end


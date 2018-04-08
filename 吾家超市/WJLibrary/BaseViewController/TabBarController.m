//
//  TabBarController.m
//  吾家超市
//
//  Created by iMac15 on 2016/10/24.
//  Copyright © 2016年 iMac15. All rights reserved.
//

#import "TabBarController.h"
#import "BaseNavigationController.h"
#import "UITabBar+BadgeValue.h"

#import "InvestmentVC.h"        //消费投资
#import "ShopCarVC.h"           //购物车
#import "MineVC.h"              //我的
#import "LoginVC.h"             //登录
#import "NSString+RSA.h"
#import "GTMBase64.h"

#import "HomePageVC.h"

@interface TabBarController ()<UITabBarControllerDelegate>
@property (weak, nonatomic) UITabBarItem * shoppingCartItem;
@end

@implementation TabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    
    //    self.tabBar.backgroundImage = [UIImage imageWithColor:kColor(235, 235, 235)];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.tintColor = kGlobalRedColor;
    
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAmount) name:@"UpdateShoppingCartAmountNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginAuto:) name:@"isLoginAuto" object:nil];
    
}

- (void)setupChildViewControllers
{
    HomePageVC *home = [[HomePageVC alloc] init];
    [self addChildViewController:home withTitle:@"首页" andNormalImage:@"shouyeicon" andSelectedImage:@"shouyeiconH"];
    
    ShopCarVC *shoppingCart = [[ShopCarVC alloc] init];
    shoppingCart.title = @"购物车";
    [self addChildViewController:shoppingCart withTitle:@"购物车" andNormalImage:@"gouwudaiicon" andSelectedImage:@"gouwudaiiconH"];
    self.shoppingCartItem = shoppingCart.tabBarItem;
    
    //    InvestmentVC *category = [[InvestmentVC alloc] init];
    //    category.title = @"消费投资";
    //    [self addChildViewController:category withTitle:@"消费投资" andNormalImage:@"xiaofeitouziicon" andSelectedImage:@"xiaofeitouziiconH"];
    
    MineVC *mine = [[MineVC alloc] init];
    [self addChildViewController:mine withTitle:@"我的" andNormalImage:@"wodeicon" andSelectedImage:@"wodeiconH"];
}

- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title andNormalImage:(NSString *)normalImageName andSelectedImage:(NSString *)selectedImageName
{
    childController.tabBarItem.title = title;
    
    childController.tabBarItem.image = [UIImage imageNamed:normalImageName];
    
    childController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -1);
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.tabBarItem.selectedImage = selectedImage;
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
//        [self.navigationController pushViewController:[MineVC new] animated:YES];
//        return NO;
//    }
//    else {
//        return YES;
//    }
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -获取采购车 数量
- (void)updateAmount
{
    kWeakSelf
    [WJRequestTool get:kCartNumUrl param:nil resultClass:[ShopCartNumResult class] successBlock:^(ShopCartNumResult *result)
     {
         WJLog(@"获取采购车-数量---");
         [weakSelf.tabBar showBadgeValue:result.t.num atIndex:1];
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateCommodityAmountNotification" object:nil userInfo:@{@"badgeValue" : result.t.num}];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -判断是否登录
- (void)isLoginAuto:(NSNotification *)notification
{
    kWeakSelf
    [WJRequestTool get:kAutoCheckUrl param:nil successBlock:^(WJBaseRequestResult *result)
     {
         if (![result.type isEqualToString:@"success"] && ![result.content isEqualToString:@"已登录"]) {
             
             if (!kStringIsEmpty([NSString decodeBase64String:[ZNGUser userInfo].enPassword])) {
                 [weakSelf loadThePublicKey];
             }
         }
     } failure:^(NSError *error) {
         
     }];
}
#pragma mark -获取公钥
- (void)loadThePublicKey
{
    [WJRequestTool get:kAutoPublicKeyUrl param:nil resultClass:[SetPasswordDataResult class]successBlock:^(SetPasswordDataResult *result)
     {
         WJLog(@"获取加密公钥---");
         kUserDefaultSetObjectForKey(result.t.publicKey, @"publickStr");
         [self loginDidClick];
         
     } failure:^(NSError *error) {
         
     }];
}

#pragma mark -自动登录
- (void)loginDidClick
{
    NSString *passwordStr = [NSString decodeBase64String:[ZNGUser userInfo].enPassword];
    
    LoginParam *param = [[LoginParam alloc] init];
    param.username = [ZNGUser userInfo].username;
    param.enPassword = [NSString encryptString:passwordStr andPublicKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"publickStr"]];
    
    if (kStringIsEmpty(param.username) || kStringIsEmpty(passwordStr)) {
        [ZNGUser logout];
        return;
    }
    
    [WJRequestTool post:kLoginUrl param:param resultClass:[ZNGLoginResult class] successBlock:^(ZNGLoginResult *result)
     {
         WJLog(@"自动登录成功----");
         if ([result.type isEqualToString:@"success"] && !kObjectIsEmpty(result.t)) {
             
             kUserDefaultSetObjectForKey(@"200", @"isLoginOne");
             
             NSString *enPasswordStr = [NSString encodeBase64String:passwordStr];   //base64加密 密码
             
             ZNGUserData *user = [[ZNGUserData alloc] init];
             user.username = [ZNGUser userInfo].username;
             user.enPassword = enPasswordStr;
             
             user.email = result.t.email;
             user.id = result.t.id;
             user.balance = result.t.balance;
             user.blanceCapital = result.t.blanceCapital;
             user.amount = result.t.amount;
             user.totalCapital = result.t.totalCapital;
             user.createDate = result.t.createDate;
             user.gender = result.t.gender;
             user.modifyDate = result.t.modifyDate;
             user.name = result.t.username;
             user.point = result.t.point;
             user.registerIp = result.t.registerIp;
             user.mobile = result.t.mobile;
             user.sumPoint = result.t.sumPoint;

             [ZNGUser loginWithT:user];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateShoppingCartAmountNotification" object:nil];
         }
         else{
             kUserDefaultSetObjectForKey(@"400", @"isLoginOne");
             [ZNGUser logout];
         }
         
     } failure:^(NSError *error) {
         
     }];
}



////（1）将导航栏的代理设置为当前的控制器，然后在将要展示下个页面的方法里修正的TabBar的帧。
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (IS_IPHONE_X) {
//        CGRect frame = self.tabBarController.tabBar.frame;
//        if (frame.origin.y < ([UIScreen mainScreen].bounds.size.height - 83)) {
//            frame.origin.y = [UIScreen mainScreen].bounds.size.height - 83;
//            self.tabBarController.tabBar.frame = frame;
//        }
//    }
//    
//
//}
@end

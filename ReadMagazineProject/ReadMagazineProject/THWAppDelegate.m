//
//  THWAppDelegate.m
//  ReadMagazineProject
//
//  Created by William on 13-11-20.
//  Copyright (c) 2013年 William. All rights reserved.
//

#import "THWAppDelegate.h"
#import "DemoViewController.h"
#import "RootViewController.h"
#import "SecondViewController.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation THWAppDelegate

+ (NSInteger)OSVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:@"主界面" action:^(RESideMenu *menu, RESideMenuItem *item) {
        DemoViewController *viewController = [[DemoViewController alloc] init];
        viewController.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [menu displayContentController:navigationController];
    }];
    RESideMenuItem *exploreItem = [[RESideMenuItem alloc] initWithTitle:@"免费订阅" action:^(RESideMenu *menu, RESideMenuItem *item) {
        SecondViewController *secondViewController = [[SecondViewController alloc] init];
        secondViewController.title = item.title;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
        [menu displayContentController:navigationController];
    }];
    RESideMenuItem *activityItem = [[RESideMenuItem alloc] initWithTitle:@"帐号管理" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
        NSLog(@"Item %@", item);
    }];
    RESideMenuItem *profileItem = [[RESideMenuItem alloc] initWithTitle:@"清理杂志" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
        NSLog(@"Item %@", item);
    }];
    RESideMenuItem *aroundMeItem = [[RESideMenuItem alloc] initWithTitle:@"关于我们" action:^(RESideMenu *menu, RESideMenuItem *item) {
        [menu hide];
        NSLog(@"Item %@", item);
    }];
    
    RESideMenuItem *helpPlus1 = [[RESideMenuItem alloc] initWithTitle:@"意见反馈" action:^(RESideMenu *menu, RESideMenuItem *item) {
        NSLog(@"Item %@", item);
        [menu hide];
    }];
    
    RESideMenuItem *helpPlus2 = [[RESideMenuItem alloc] initWithTitle:@"帮助" action:^(RESideMenu *menu, RESideMenuItem *item) {
        NSLog(@"Item %@", item);
        [menu hide];
    }];
    
    RESideMenuItem *helpCenterItem = [[RESideMenuItem alloc] initWithTitle:@"问题反馈" action:^(RESideMenu *menu, RESideMenuItem *item) {
        NSLog(@"Item %@", item);
    }];
    helpCenterItem.subItems  = @[helpPlus1,helpPlus2];
    
    RESideMenuItem *itemWithSubItems = [[RESideMenuItem alloc] initWithTitle:@"建议" action:^(RESideMenu *menu, RESideMenuItem *item) {
        NSLog(@"Item %@", item);
    }];
    itemWithSubItems.subItems = @[aroundMeItem,helpCenterItem];
    
    RESideMenuItem *logOutItem = [[RESideMenuItem alloc] initWithTitle:@"退出" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要退出吗?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        [alertView show];
    }];
    
    _sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem,itemWithSubItems, logOutItem]];
    
    _sideMenu.verticalPortraitOffset = IS_WIDESCREEN ? 110 : 76;
    _sideMenu.verticalLandscapeOffset = 16;
    
    _sideMenu.hideStatusBarArea = [THWAppDelegate OSVersion] < 7;
    
    _sideMenu.openStatusBarStyle = UIStatusBarStyleBlackTranslucent;
    
    // Call the home action rather than duplicating the initialisation
    homeItem.action(_sideMenu, homeItem);
    
    self.window.rootViewController = _sideMenu;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    fView =[[UIImageView alloc]initWithFrame:self.window.frame];//初始化fView
    fView.image=[UIImage imageNamed:@"9.jpg"];//图片f.png 到fView
    
    zView=[[UIImageView alloc]initWithFrame:self.window.frame];//初始化zView
    zView.image=[UIImage imageNamed:@"8.png"];//图片z.png 到zView
    
    rView=[[UIView alloc]initWithFrame:self.window.frame];//初始化rView
    
    [rView addSubview:fView];//add 到rView
    [rView addSubview:zView];//add 到rView
    
    [self.window addSubview:rView];//add 到window
    
    [self performSelector:@selector(TheAnimation) withObject:nil afterDelay:4];//5秒后执行TheAnimation
    
    
    
    
    return YES;
}

- (void)TheAnimation{
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7 ;  // 动画持续时间(秒)
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;//淡入淡出效果
    
    NSUInteger f = [[rView subviews] indexOfObject:fView];
    NSUInteger z = [[rView subviews] indexOfObject:zView];
    [rView exchangeSubviewAtIndex:z withSubviewAtIndex:f];
    
    [[rView layer] addAnimation:animation forKey:@"animation"];
    
    [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:3];//2秒后执行TheAnimation
}

#pragma mark - 上升效果
- (void)ToUpSide {
    
    [self moveToUpSide];//向上拉界面
    
}

- (void)moveToUpSide {
    [UIView animateWithDuration:0.7 //速度0.7秒
                     animations:^{//修改rView坐标
                         rView.frame = CGRectMake(self.window.frame.origin.x,
                                                  -self.window.frame.size.height,
                                                  self.window.frame.size.width,
                                                  self.window.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end

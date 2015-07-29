//
//  AppDelegate.m
//  Step-it-up
//
//  Created by syfll on 7/27/15.
//  Copyright © 2015 JFT0M. All rights reserved.
//

#import "AppDelegate.h"
#import "EaseStartView.h"

#import "RootTabViewController.h"
#import "IntroductionViewController.h"
#import "BaseViewController.h"

#import "XGPush.h"

@interface AppDelegate ()
#warning isLogin为前期测试界面用的，后期需要扩展
@property (assign,nonatomic)bool isLogin;

@end

@implementation AppDelegate


#pragma mark XGPush
- (void)registerPush{
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(sysVer < 8){
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }else{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:userSettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    }
}

#pragma mark - application
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    //设置导航条样式
    [self customizeInterface];
#warning 第一个画面的Status Bar的样式在 General -> Deployment info -> Status Bar Style 中设置
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    _isLogin = YES;
    
    if (_isLogin) {
        [self setupTabViewController];
    }else{
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [self setupIntroductionViewController];
    }

    
    
    [self.window makeKeyAndVisible];
    
    EaseStartView *startView = [EaseStartView startView];
    @weakify(self);
    [startView startAnimationWithCompletionBlock:^(EaseStartView *easeStartView) {
        @strongify(self);
        [self completionStartAnimationWithOptions:launchOptions];
    }];
    

    [self registerPush];
    return YES;
}

- (void)completionStartAnimationWithOptions:(NSDictionary *)launchOptions{
    //推送注册
//    
//    if (_isLogin) {
//        NSDictionary *remoteNotification = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//        if (remoteNotification) {
//            [BaseViewController handleNotificationInfo:remoteNotification applicationState:UIApplicationStateInactive];
//        }
//    }
//    
//    
//    //    信鸽推送
//    [XGPush startApp:kXGPush_Id appKey:kXGPush_Key];
//    [Login setXGAccountWithCurUser];
//    //注销之后需要再次注册前的准备
//    @weakify(self);
//    void (^successCallback)(void) = ^(void){
//        //如果变成需要注册状态
//        if(![XGPush isUnRegisterStatus] && [Login isLogin]){
//            @strongify(self);
//            [self registerPush];
//        }
//    };
//    [XGPush initForReregister:successCallback];
//    
//    [XGPush registerPush];  //注册Push服务，注册后才能收到推送
//    
//    推送反馈(app不在前台运行时，点击推送激活时。统计而已)
//    [XGPush handleLaunching:launchOptions];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "JFT0M.Step_it_up" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Step_it_up" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Step_it_up.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Interface
- (void)customizeInterface {
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
        [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextField的光标颜色
        [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextView的光标颜色
        [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorTableSectionBg] forBarPosition:0 barMetrics:UIBarMetricsDefault];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorTableSectionBg]];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                           UITextAttributeTextColor: [UIColor whiteColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x28303b"]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

#pragma mark - ViewController


- (void)setupIntroductionViewController{
    IntroductionViewController *introductionVC = [[IntroductionViewController alloc] init];
    [self.window setRootViewController:introductionVC];
}

- (void)setupTabViewController{
    RootTabViewController *rootVC = [[RootTabViewController alloc] init];
    rootVC.tabBar.translucent = YES;
    
    [self.window setRootViewController:rootVC];
}


@end

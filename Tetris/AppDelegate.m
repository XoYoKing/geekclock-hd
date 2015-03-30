//
//  AppDelegate.m
//  Tetris
//
//  Created by Jonathan Querubina on 11/15/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import "AppDelegate.h"
#import "AirPlayViewController.h"
#import "ViewController.h"

NSString *const FBSessionStateChangedNotification = @"com.phocus.Tetris:FBSessionStateChangedNotification";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(externalScreenDidConnect:) name:UIScreenDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(externalScreenDidDisconnect:) name:UIScreenDidDisconnectNotification object:nil];
    
    if (UIScreen.screens.count > 1){
        [self prepareExternalScreen:UIScreen.screens.lastObject];
    }
    
    database = [[SQLiteManager alloc] initWithDatabaseNamed:@"config.db"];
    NSError *sql = nil;

    sql = [database doQuery:@"CREATE TABLE IF NOT EXISTS preferencias (id integer primary key autoincrement, style integer, theme integer);"];
    if ([[database getRowsForQuery:@"SELECT * FROM preferencias"] count]==0) {
        sql = [database doQuery:@"insert into preferencias (style, theme) values (0,0);"];
    }

    self.viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
    
    //sql = [database doQuery:[NSString stringWithFormat:@"update preferencias set theme=%d",0]];
    

}

- (void)externalScreenDidConnect:(NSNotification*)notification
{
    [self prepareExternalScreen:notification.object];
}

- (void)externalScreenDidDisconnect:(NSNotification*)notification
{
    // Don't need these anymore.
    self.externalWindow = nil;
}

- (void)prepareExternalScreen:(UIScreen*)externalScreen
{
    
    AirPlayViewController *airPlay = [[AirPlayViewController alloc] initWithNibName:nil bundle:nil];
    
    NSLog(@"PREPPING EXTERNAL SCREEN.");
    //self.viewController.view.backgroundColor = [UIColor blueColor];
    CGRect frame = externalScreen.bounds;
    self.externalWindow = [[UIWindow alloc] initWithFrame:frame];
    self.externalWindow.screen = externalScreen;
    self.externalWindow.hidden = NO;
    self.externalWindow.backgroundColor = [UIColor redColor];
    [self.externalWindow setRootViewController:airPlay];
    
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

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error {
    
    if (FBSession.activeSession.isOpen) {
        //[self.authButton setTitle:@"Logout" forState:UIControlStateNormal];
        //self.userInfoTextView.hidden = NO;
        
        NSLog(@"logou");
        
        NSError *sql;
        sql = [database doQuery:[NSString stringWithFormat:@"update preferencias set theme=%d",3]];
        
        [self.viewController recreateClock];
        
    }
    
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"read_friendlists",@"read_stream",nil];
    return [FBSession openActiveSessionWithReadPermissions:permissions
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}

@end

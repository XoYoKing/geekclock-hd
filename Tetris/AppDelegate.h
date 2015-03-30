//
//  AppDelegate.h
//  Tetris
//
//  Created by Jonathan Querubina on 11/15/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SQLiteManager.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    SQLiteManager *database;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UIWindow *externalWindow;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end

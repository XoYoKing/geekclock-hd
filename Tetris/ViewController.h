//
//  ViewController.h
//  Tetris
//
//  Created by Jonathan Querubina on 11/15/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LineViewController.h"
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "SQLiteManager.h"
#import "LoadImageViewController.h"

@interface ViewController : UIViewController <AVAudioSessionDelegate, UIGestureRecognizerDelegate> {
    
    LineViewController *hourOne;
    LineViewController *hourTwo;
    
    LineViewController *minuteOne;
    LineViewController *minuteTwo;
    
    NSTimer *timer;
    NSString *horasTXT,*minutosTXT,*segundosTXT;
    int horasINT,minutosINT,segundosINT;
    
    MPMoviePlayerController *audioPlayer;
    
    UIView *clock;
    UIButton *config;
    UIScrollView *configView;
    
    SQLiteManager *database;
    
    UIButton *_12h;
    UIButton *_24h;
    
    UIButton *white;
    UIButton *dark;
    UIButton *color;
    UIButton *facebook;
    
    UIImageView *mark;
    
    float w,h;
    
    UIButton *faceBook;
    
    NSString *linkURL;
    
    BOOL openLink;
    
    LoadImageViewController *imgNews;
    
}

-(void)showMasterControls:(float)alpha;
-(void)recreateClock;

@end

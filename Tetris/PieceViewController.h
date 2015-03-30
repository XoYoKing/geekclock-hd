//
//  PieceViewController.h
//  Tetris
//
//  Created by Jonathan Querubina on 11/17/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SQLiteManager.h"
#import "LoadImageViewController.h"

@interface PieceViewController : UIViewController {
    
    id delegate;
    int turns;
    int maxAngle;
    NSString *actualPiece;
    NSTimer *timer;
    
    SQLiteManager *database;
    
    LoadImageViewController *imgNewsWhatever;
    
    BOOL tici;
    
    BOOL air;
    
}

@property (nonatomic, retain) id delegate;

-(void)createL:(int)position;
-(void)createJ:(int)position;
-(void)createS:(int)position;
-(void)createZ:(int)position;
-(void)createT:(int)position;
-(void)createI:(int)position;
-(void)createO:(int)position;
-(void)printPiece:(NSArray*)pattern;

-(void)setAirPlay;

-(void)rotate:(int)to:(NSString*)piece;

-(void)setTici;

@end
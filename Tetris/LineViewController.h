//
//  PieceViewController.h
//  Tetris
//
//  Created by Jonathan Querubina on 11/15/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PieceViewController.h"

#import <Social/Social.h>
#import "Accounts/Accounts.h"

@interface LineViewController : UIViewController {

    id delegate;
    float pieceWidth;
    NSTimer *timerY;
    NSTimer *timerX;
    NSTimer *timerPieces;
    int counterPieces;
    
    NSMutableArray *piecesArray;
    
    BOOL tici;
    BOOL air;

}

-(void)setNumber:(int)number;
-(void)setAirPlay;

@property (nonatomic, retain) id delegate;

@end
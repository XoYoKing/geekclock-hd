//
//  PieceViewController.m
//  Tetris
//
//  Created by Jonathan Querubina on 11/15/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import "LineViewController.h"

@interface LineViewController ()

@end

@implementation LineViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(void)dropPieces
{
    
    if (counterPieces==[piecesArray count]) {
        
        counterPieces = 0;
        [timerPieces invalidate];
        timerPieces = nil;
        
    }else{
    
        NSArray *piece = [piecesArray objectAtIndex:counterPieces];
        
        PieceViewController *pieceBlock = [[PieceViewController alloc] initWithNibName:nil bundle:nil];
        if (air) {
            [pieceBlock setAirPlay];
        }
        pieceBlock.view.frame = CGRectMake(pieceWidth*2, pieceWidth*-1, pieceWidth*6, pieceWidth*20);
        pieceBlock.view.tag = [[piece objectAtIndex:0] intValue];
        if (tici) {
            [pieceBlock setTici];
        }
        [self.view addSubview:pieceBlock.view];
        [pieceBlock rotate:[[piece objectAtIndex:1] intValue]:[piece objectAtIndex:2]];
        counterPieces++;

    }
    
}

-(void)createZero
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"117",@"1",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"122",@"2",@"S", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"114",@"1",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"106",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"103",@"3",@"Z", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"3",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"89",@"1",@"Z", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"75",@"1",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"78",@"1",@"Z", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"1",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"65",@"2",@"Z", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
    [piecesArray addObject:piece];
}

-(void)createOne
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"111",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"110",@"3",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"89",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"82",@"3",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"68",@"1",@"O", nil];
    [piecesArray addObject:piece];
}

-(void)createTwo
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"128",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"123",@"4",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"106",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"107",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"100",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"95",@"4",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"82",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"72",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
    [piecesArray addObject:piece];
}

-(void)createThree
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"120",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"122",@"2",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"111",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"109",@"1",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"100",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"95",@"4",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"82",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"72",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
    [piecesArray addObject:piece];
}

-(void)createFour
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"124",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"110",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"100",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"95",@"4",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"69",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"71",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"68",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"3",@"L", nil];
    [piecesArray addObject:piece];
}

-(void)createFive
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"120",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"122",@"2",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"111",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"109",@"1",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"100",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"95",@"4",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"78",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"72",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
    [piecesArray addObject:piece];
}

-(void)createSix
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"120",@"2",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"123",@"4",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"110",@"1",@"S", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"114",@"2",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"96",@"3",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"94",@"2",@"S", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"93",@"3",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"71",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"3",@"L", nil];
    [piecesArray addObject:piece];
}

-(void)createSeven
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"124",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"103",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"96",@"3",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"82",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"72",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
    [piecesArray addObject:piece];
}

-(void)createEight
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"120",@"2",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"123",@"4",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"113",@"2",@"Z", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"116",@"2",@"S", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"96",@"1",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"100",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"78",@"3",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"87",@"4",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"69",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"65",@"4",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"3",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"3",@"J", nil];
    [piecesArray addObject:piece];
}

-(void)createNine
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"117",@"1",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"110",@"3",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"83",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"100",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"85",@"1",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"87",@"4",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"73",@"4",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"71",@"1",@"S", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"2",@"T", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
    [piecesArray addObject:piece];
}

-(void)createTen
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"115",@"1",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"108",@"3",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"94",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"80",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"66",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"68",@"1",@"O", nil];
    [piecesArray addObject:piece];
}

-(void)createEleven
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"109",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"108",@"3",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"87",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"80",@"3",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"66",@"1",@"O", nil];
    [piecesArray addObject:piece];
}

-(void)createTwelve
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"128",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"123",@"4",@"J", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"106",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"107",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"92",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"78",@"1",@"O", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"72",@"2",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"64",@"2",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
    [piecesArray addObject:piece];
//    piece = [[NSArray alloc] initWithObjects:@"82",@"1",@"O", nil];
//    [piecesArray addObject:piece];
//    piece = [[NSArray alloc] initWithObjects:@"72",@"2",@"I", nil];
//    [piecesArray addObject:piece];
//    piece = [[NSArray alloc] initWithObjects:@"64",@"2",@"L", nil];
//    [piecesArray addObject:piece];
//    piece = [[NSArray alloc] initWithObjects:@"67",@"4",@"J", nil];
//    [piecesArray addObject:piece];
}

-(void)createThirteen
{
    NSArray *piece;
    piece = [[NSArray alloc] initWithObjects:@"109",@"1",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"108",@"3",@"I", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"87",@"1",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"80",@"3",@"L", nil];
    [piecesArray addObject:piece];
    piece = [[NSArray alloc] initWithObjects:@"66",@"1",@"O", nil];
    [piecesArray addObject:piece];
}

-(CGPoint)getBlockPoint:(int)block
{
    
    CGPoint point;
    UIView *blockPosition;
    int count = 0;
    
    for (UIView *view in self.view.subviews) {
        
        if (view.tag==0) {
            count++;
            if (count==block) {
                blockPosition = view;
            }
        }
        
    }
    
    point = CGPointMake(blockPosition.frame.origin.x+blockPosition.frame.size.width, blockPosition.frame.origin.y+blockPosition.frame.size.height);
    return point;
    
}

-(void)setNumber:(int)number
{
    
    tici = false;
    
    piecesArray = nil;
    piecesArray = [[NSMutableArray alloc] init];
    [timerPieces invalidate];
    timerPieces = nil;
    counterPieces = 0;
    
    for (UIView *view in self.view.subviews) {
        if (view.tag>0) {
            [view removeFromSuperview];
        }
    }
    
    switch (number) {
        case 0:
            [self createZero];
            break;
        case 1:
            [self createOne];
            break;
        case 2:
            [self createTwo];
            break;
        case 3:
            [self createThree];
            break;
        case 4:
            [self createFour];
            break;
        case 5:
            [self createFive];
            break;
        case 6:
            [self createSix];
            break;
        case 7:
            [self createSeven];
            break;
        case 8:
            [self createEight];
            break;
        case 9:
            [self createNine];
            break;
        case 10:
            tici = true;
            [self createTen];
            break;
        case 11:
            tici = true;
            [self createEleven];
            break;
        case 12:
            tici = true;
            [self createTwelve];
            break;
        case 13:
            tici = true;
            [self createThirteen];
            break;
            
        default:
            break;
    }
    
    timerPieces = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dropPieces) userInfo:nil repeats:YES];
    
    //NSLog(@"%d",number);
    
}

-(void)playTetris:(int)move
{
    
    for (UIView *view in self.view.subviews) {
        if (view.tag>0) {
            
            CGPoint position = view.frame.origin;
            
            float x = position.x;
            float y = position.y;

            CGPoint actualBlock = [self getBlockPoint:view.tag];
            
            if(move==1){
                if (y<actualBlock.y-1) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+pieceWidth, view.frame.size.width, view.frame.size.height);
                if (y>actualBlock.y+1) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-pieceWidth, view.frame.size.width, view.frame.size.height);
            }else{
                if (x<actualBlock.x-1) view.frame = CGRectMake(view.frame.origin.x+pieceWidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
                if (x>actualBlock.x+1) view.frame = CGRectMake(view.frame.origin.x-pieceWidth, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            }
            
        }
    }
    
}

-(void)moveY
{
    [self playTetris:1];
}

-(void)moveX
{
    [self playTetris:2];
}

-(void)setAirPlay
{
    air = true;
    //NSLog(@"setou");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    int l = 0;
    int c = 0;
    
    //NSLog(@"pieceWidth %f",self.view.frame.size.height);
    
    UIScreen *tela = UIScreen.screens.lastObject;
    
    pieceWidth = [[UIScreen mainScreen] bounds].size.height/40;
    
    if (air) {
        pieceWidth = tela.bounds.size.width/40;
    }
    
    //NSLog(@"%f",pieceWidth);
    
    counterPieces = 0;
    
    for (int i=0; i<140; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c*pieceWidth, l*pieceWidth, pieceWidth, pieceWidth)];
        //view.layer.borderWidth = 1;
        //view.layer.borderColor = [[UIColor whiteColor] CGColor];
        //view.layer.cornerRadius = 4;
        view.tag = 0;
        //view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        
        //if (i>69) {
        //    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        //}
        view.alpha = 0;
        [self.view addSubview:view];
        
        //if (c==0) {
        //    view.alpha = 0;
        //}
        
        c++;
        
        if (c==7) {
            l++;
            c=0;
        }
        
    }
    
    timerY = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(moveY) userInfo:nil repeats:YES];
    timerX = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(moveX) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

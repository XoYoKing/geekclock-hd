//
//  PieceViewController.m
//  Tetris
//
//  Created by Jonathan Querubina on 11/17/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import "PieceViewController.h"
#import "AppDelegate.h"
#define UIColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface PieceViewController ()

@end

@implementation PieceViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
        database = [[SQLiteManager alloc] initWithDatabaseNamed:@"config.db"];
    }
    return self;
}

-(void)setTici
{
    tici = true;
}

-(void)createL:(int)position{
    NSArray *pattern;
    switch (position) {
        case 1:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 2:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 3:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 4:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"0",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        default:
            break;
    }
    [self printPiece:pattern];
}

-(void)createJ:(int)position{
    NSArray *pattern;
    switch (position) {
        case 1:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 2:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 3:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 4:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        default:
            break;
    }
    [self printPiece:pattern];
}

-(void)createS:(int)position{
    NSArray *pattern;
    switch (position) {
        case 1:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 2:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"1",@"1",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 3:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 4:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"1",@"1",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        default:
            break;
    }
    [self printPiece:pattern];
}

-(void)createZ:(int)position{
    NSArray *pattern;
    switch (position) {
        case 1:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"1",@"0",@"0",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 2:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"0",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 3:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"1",@"0",@"0",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 4:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"0",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        default:
            break;
    }
    [self printPiece:pattern];
}

-(void)createT:(int)position{
    NSArray *pattern;
    switch (position) {
        case 1:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 2:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 3:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"1",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 4:
            pattern = [[NSArray alloc] initWithObjects:@"0",@"1",@"0",@"0",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        default:
            break;
    }
    [self printPiece:pattern];
}

-(void)createI:(int)position{
    NSArray *pattern;
    switch (position) {
        case 1:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0", nil];
            break;
        case 2:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        case 3:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0",@"1",@"0",@"0",@"0", nil];
            break;
        case 4:
            pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
            break;
        default:
            break;
    }
    [self printPiece:pattern];
}

-(void)createO:(int)position{
    NSArray *pattern = [[NSArray alloc] initWithObjects:@"1",@"1",@"0",@"0",@"1",@"1",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    [self printPiece:pattern];
}

-(void)printPiece:(NSArray*)pattern{
    
    for (int i=0; i<[pattern count]; i++) {
        float value = [[pattern objectAtIndex:i] floatValue];
        UIView *view = [self.view.subviews objectAtIndex:i];
        view.alpha = value;
        view.clipsToBounds = YES;
    }
    
    NSArray *configArray = [database getRowsForQuery:@"select * from preferencias"];
    int configTheme = [[[configArray objectAtIndex:0] objectForKey:@"theme"] intValue];
    
    if (configTheme==3 && !tici){
        NSMutableArray *avatar = [[NSMutableArray alloc] init];
        
        FBRequest *request = [FBRequest requestWithGraphPath:@"me/friends?limit=50" parameters:@{} HTTPMethod:@"GET"];
        [request startWithCompletionHandler: ^(FBRequestConnection *connection,
                                               NSDictionary* result,
                                               NSError *error) {
        
        //FBRequest* friendsRequest = [FBRequest requestForMyFriends];
        //[friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      //NSDictionary* result,
                                                      //NSError *error) {
            NSArray* friends = [result objectForKey:@"data"];
            //NSLog(@"Found: %i friends", friends.count);
            
            for (NSDictionary<FBGraphUser>* friend in friends) {
                //NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
                [avatar addObject:friend.id];
            }
            
            for (UIView *view in self.view.subviews) {
                
                if (view.alpha == 1 ) {
                    
                    if ([view.subviews count]>0) {
                        for (UIView *subView in view.subviews) {
                            [subView  removeFromSuperview];
                        }
                    }
                    
                    int myNumber = arc4random() % [avatar count];
                    
                    @try {
                        imgNewsWhatever = [[LoadImageViewController alloc] initWithNibName:nil bundle:nil];
                        imgNewsWhatever.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
                        [imgNewsWhatever loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small",[avatar objectAtIndex:myNumber]]]];
                        [view addSubview:imgNewsWhatever.view];
                    }
                    @catch (NSException *exception) {
                        NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
                    }
                    @finally {
                        
                    }
                    
                    
                    
                }
                
            }
            
        }];
        
    }
    
    if (tici) {
        
        for (UIView *view in self.view.subviews) {
            
            if (view.alpha == 1 ) {
                
                view.backgroundColor = UIColorRGB(0xb00000);
                
            }
            
        }
        
    }
    
}

-(void)setAngle
{
    turns++;
    if (turns==maxAngle) {
        [timer invalidate];
        timer = nil;
    }
    if([actualPiece isEqual:@"L"]) [self createL:turns];
    if([actualPiece isEqual:@"J"]) [self createJ:turns];
    if([actualPiece isEqual:@"S"]) [self createS:turns];
    if([actualPiece isEqual:@"Z"]) [self createZ:turns];
    if([actualPiece isEqual:@"T"]) [self createT:turns];
    if([actualPiece isEqual:@"I"]) [self createI:turns];
    if([actualPiece isEqual:@"O"]) [self createO:turns];
    //NSLog(@"%d",turns);
}

-(void)rotate:(int)to:(NSString*)piece
{
    maxAngle = to;
    actualPiece = piece;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(setAngle) userInfo:nil repeats:YES];
}

-(void)setAirPlay
{
    air = true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    int l = 0;
    int c = 0;
    turns = 0;
    maxAngle = 0;
    actualPiece = @"";
    float pieceWidth = [[UIScreen mainScreen] bounds].size.height/40;
    
    UIScreen *tela = UIScreen.screens.lastObject;
    
    if (air) {
        pieceWidth = tela.bounds.size.width/40;
        //NSLog(@"air");
    }
    
    float rand = arc4random() % 100;
    float rand2 = arc4random() % 100;
    float rand3 = arc4random() % 100;
    
    for (int i =0; i<16; i++) {
        
        //NSLog(@"%f",rand);
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c*pieceWidth, l*pieceWidth, pieceWidth, pieceWidth)];
        view.layer.borderWidth = 1;
        view.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor];
        view.layer.cornerRadius = 4;
        
        NSArray *configArray = [database getRowsForQuery:@"select * from preferencias"];
        int configTheme = [[[configArray objectAtIndex:0] objectForKey:@"theme"] intValue];
        
        UIColor *color;
        if (configTheme==0) color = UIColorRGB(0x2d2d2d);
        if (configTheme==1 || configTheme==3) color = [UIColor whiteColor];
        if (configTheme==2) color = [UIColor colorWithRed:rand/100 green:rand2/100 blue:rand3/100 alpha:1];
        
        view.backgroundColor = color;
        
        
        
        view.alpha = 0;
        [self.view addSubview:view];
        
        c++;
        
        if (c==4) {
            l++;
            c=0;
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
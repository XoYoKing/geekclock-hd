//
//  AirPlayViewController.m
//  GeekClock
//
//  Created by Jonathan on 11/29/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import "AirPlayViewController.h"
#import "AppDelegate.h"

#define UIColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AirPlayViewController ()

@end

@implementation AirPlayViewController

-(void)recreateClock
{
    
    NSArray *configArray = [database getRowsForQuery:@"select * from preferencias"];
    int configTheme = [[[configArray objectAtIndex:0] objectForKey:@"theme"] intValue];
    
    UIColor *colorBG;
    if (configTheme==0) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgWhite.png"]];
    if (configTheme==1 || configTheme==2 || configTheme==3) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgBlack.png"]];
    //if (configTheme==2) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgWhite.png"]];
    //if (configTheme==3) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgWhite.png"]];
    
    self.view.backgroundColor = colorBG;
    
    if (configTheme==3) {
        NSMutableArray *avatar = [[NSMutableArray alloc] init];
        
        FBRequest* friendsRequest = [FBRequest requestForMyFriends];
        [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      NSDictionary* result,
                                                      NSError *error) {
            NSArray* friends = [result objectForKey:@"data"];
            //NSLog(@"Found: %i friends", friends.count);
            
            for (NSDictionary<FBGraphUser>* friend in friends) {
                //NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
                [avatar addObject:friend.id];
            }
            
            for (UIView *view in clock.subviews) {
                
                if (view.tag==666) {
                    int myNumber = arc4random() % [avatar count];
                    imgNews = [[LoadImageViewController alloc] initWithNibName:nil bundle:nil];
                    imgNews.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
                    //imgNews.view.transform = CGAffineTransformIdentity;
                    //imgNews.view.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                    [imgNews loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small",[avatar objectAtIndex:myNumber]]]];
                    [view addSubview:imgNews.view];
                }
                
            }
            
        }];
    }
    
    hourOne.view.tag = hourTwo.view.tag = minuteOne.view.tag = minuteTwo.view.tag = 99999999;
    
}

- (void)updateClock
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate* now = [NSDate date];
    int m = [[cal components:NSMinuteCalendarUnit fromDate:now] minute];
    int s = [[cal components:NSSecondCalendarUnit fromDate:now] second];
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                                                       fromDate:[NSDate date]];
    NSInteger seconds = [dateComponents second];
    NSInteger minutes = [dateComponents minute];
    NSInteger hours = [dateComponents hour];
    
    horasINT = hours;
    minutosINT = minutes;
    segundosINT = seconds;
    
    NSArray *configArray = [database getRowsForQuery:@"select * from preferencias"];
    int configTheme = [[[configArray objectAtIndex:0] objectForKey:@"theme"] intValue];
    int configStyle = [[[configArray objectAtIndex:0] objectForKey:@"style"] intValue];
    
    if (configTheme==3 && (segundosINT==0 || segundosINT==30) && h==1024) {
        
        FBRequest *request = [FBRequest requestWithGraphPath:@"me/home" parameters:@{} HTTPMethod:@"GET"];
        [request startWithCompletionHandler: ^(FBRequestConnection *connection,
                                               NSDictionary* result,
                                               NSError *error) {
            
            NSArray* feed = [result objectForKey:@"data"];
            
            NSDictionary *post = [feed objectAtIndex:0];
            int contador = [[post objectForKey:@"id"] length];
            int id_post = [[[post objectForKey:@"id"] substringWithRange:NSMakeRange(contador-8,6)] intValue];
            //NSLog(@"%d %d %@",contador,id_post,[post objectForKey:@"id"]);
            NSDictionary *from = [post objectForKey:@"from"];
            NSDictionary *link = [[post objectForKey:@"actions"] objectAtIndex:0];
            NSString *mensagem = [post objectForKey:@"message"];
            
            if ([mensagem length]<1) {
                mensagem = [post objectForKey:@"story"];
                if ([mensagem length]<1) {
                    mensagem = [post objectForKey:@"description"];
                    if ([mensagem length]<1) {
                        mensagem = [post objectForKey:@"question"];
                        if ([mensagem length]<1) {
                            mensagem = [post objectForKey:@"title"];
                            if ([mensagem length]<1) {
                                mensagem = [post objectForKey:@"caption"];
                            }
                        }
                    }
                }
            }
            
            
            //NSLog(@"%@,%@,%@",from,link,mensagem);
            //NSLog(@"%@",post);
            
            linkURL = [link objectForKey:@"link"];
            
            for (UIView *view in faceBook.subviews) {
                if (view.tag==12 && [view isKindOfClass:[UIView class]]) {
                    
                    if ([view.subviews count]>0) {
                        [[view.subviews objectAtIndex:0] removeFromSuperview];
                    }
                    
                    imgNews = [[LoadImageViewController alloc] initWithNibName:nil bundle:nil];
                    imgNews.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
                    [imgNews loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[from objectForKey:@"id"]]]];
                    [view addSubview:imgNews.view];
                    imgNews.view.backgroundColor = [UIColor clearColor];
                    
                }
            }
            
            for (UILabel *view in faceBook.subviews) {
                if (view.tag==1 && [view isKindOfClass:[UILabel class]]) {
                    view.text = [NSString stringWithFormat:@"%@:",[[from objectForKey:@"name"] uppercaseString]];
                }
                if (view.tag==2 && [view isKindOfClass:[UILabel class]]) {
                    view.text = [NSString stringWithFormat:@"%@",mensagem];
                }
            }
            
            if (faceBook.tag!=id_post) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(removeFacebookUpdate)];
                faceBook.frame = CGRectMake(faceBook.frame.origin.x, 768-77, faceBook.frame.size.width, faceBook.frame.size.height);
                [UIView commitAnimations];
                faceBook.tag = id_post;
            }
            
            //NSLog(@"%d",faceBook.tag);
            
        }];
        
    }
    
    seconds += 30; seconds %=60;
    minutes += 30; minutes %=60;
    hours += 6; hours %=12;
    
    if (s<10) {
        segundosTXT = [NSString stringWithFormat:@"0%d",s];
    }else{
        segundosTXT = [NSString stringWithFormat:@"%d",s];
    }
    
    if (m<10) {
        minutosTXT = [NSString stringWithFormat:@"0%d",m];
    }else{
        minutosTXT = [NSString stringWithFormat:@"%d",m];
    }
    
    if ([dateComponents hour]<10) {
        horasTXT = [NSString stringWithFormat:@"0%d",[dateComponents hour]];
    }else{
        
        horasTXT = [NSString stringWithFormat:@"%d",[dateComponents hour]];
        
        if (configStyle==0 && [dateComponents hour]>12) {
            horasTXT = [NSString stringWithFormat:@"0%d",[dateComponents hour]-12];
        }
        
    }
    
    if (hourOne.view.tag==[[horasTXT substringWithRange:NSMakeRange(0,1)] intValue] || hourOne.view.tag==10) {
        
    }else{
        [hourOne setNumber:[[horasTXT substringWithRange:NSMakeRange(0,1)] intValue]];
        hourOne.view.tag = [[horasTXT substringWithRange:NSMakeRange(0,1)] intValue];
        
    }
    
    if (hourTwo.view.tag==[[horasTXT substringWithRange:NSMakeRange(1,1)] intValue] || hourTwo.view.tag==11) {
        
    }else{
        [hourTwo setNumber:[[horasTXT substringWithRange:NSMakeRange(1,1)] intValue]];
        hourTwo.view.tag = [[horasTXT substringWithRange:NSMakeRange(1,1)] intValue];
    }
    
    if (minuteOne.view.tag==[[minutosTXT substringWithRange:NSMakeRange(0,1)] intValue] || minuteOne.view.tag==12) {
        
    }else{
        [minuteOne setNumber:[[minutosTXT substringWithRange:NSMakeRange(0,1)] intValue]];
        minuteOne.view.tag = [[minutosTXT substringWithRange:NSMakeRange(0,1)] intValue];
    }
    
    if (minuteTwo.view.tag==[[minutosTXT substringWithRange:NSMakeRange(1,1)] intValue] || minuteTwo.view.tag==13) {
        
    }else{
        [minuteTwo setNumber:[[minutosTXT substringWithRange:NSMakeRange(1,1)] intValue]];
        minuteTwo.view.tag = [[minutosTXT substringWithRange:NSMakeRange(1,1)] intValue];
        
        
        
        
    }
    
    float rand = arc4random() % 100;
    float rand2 = arc4random() % 100;
    float rand3 = arc4random() % 100;
    
    for (UIView *view in clock.subviews) {
        
        if (view.tag==666) {
            
            if (view.alpha<1) {
                view.alpha = 1;
            }else{
                view.alpha=0;
            }
            
            UIColor *colorPIECE;
            if (configTheme==0) colorPIECE = UIColorRGB(0x2d2d2d);
            if (configTheme==1) colorPIECE = [UIColor whiteColor];
            if (configTheme==2) colorPIECE = [UIColor colorWithRed:rand/100 green:rand2/100 blue:rand3/100 alpha:1];
            
            view.backgroundColor = colorPIECE;
            
            if (configTheme==0|| configTheme==1 || configTheme==2) {
                for (UIView *face in view.subviews) {
                    [face removeFromSuperview];
                }
            }
            
        }
        
    }
    
    if (configTheme==configMaster) {
        
    }else{
        configMaster=configTheme;
        [self recreateClock];
        NSLog(@"troca %d",configMaster);
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //imgNews = [[LoadImageViewController alloc] initWithNibName:nil bundle:nil];
    
    UIScreen *tela = UIScreen.screens.lastObject;
    
    w = tela.bounds.size.width;
    
    //w = [[UIScreen screens] bounds].size.width;
    //h = [[UIScreen mainScreen] bounds].size.height;
    
    h = tela.bounds.size.height;
    
    NSLog(@"%f %f",w,h);
    
    database = [[SQLiteManager alloc] initWithDatabaseNamed:@"config.db"];
    
    NSArray *configArray = [database getRowsForQuery:@"select * from preferencias"];
    int configTheme = [[[configArray objectAtIndex:0] objectForKey:@"theme"] intValue];
    
    UIColor *colorBG;
    if (configTheme==0) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgWhite.png"]];
    if (configTheme==1 || configTheme==2 || configTheme==3) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgBlack.png"]];
    
    self.view.backgroundColor = colorBG;
    
    clock = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [self.view addSubview:clock];
    
    int l = 0;
    int c = 0;
    float pieceWidth = tela.bounds.size.width/40;
    NSLog(@"%f",pieceWidth);
    
    for (int i =0; i<1200; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(c*pieceWidth, l*pieceWidth, pieceWidth, pieceWidth)];
        //view.layer.borderWidth = 1;
        view.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor];
        view.layer.borderWidth = 0.2;
        view.backgroundColor = UIColorRGB(0x2d2d2d);
        view.tag = 999;
        view.alpha = 1;
        //tema branco
        //view.alpha = 0.2;
        //view.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        
        view.layer.cornerRadius = 4;
        
        if (i==499 || i==500 || i==539 || i==540 || i==659 || i==660 || i==699 || i==700) {
            view.layer.borderWidth = 1;
            view.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] CGColor];
            view.layer.cornerRadius = 4;
            view.clipsToBounds = YES;
            
            float rand = arc4random() % 100;
            float rand2 = arc4random() % 100;
            float rand3 = arc4random() % 100;
            
            NSArray *configArray = [database getRowsForQuery:@"select * from preferencias"];
            int configTheme = [[[configArray objectAtIndex:0] objectForKey:@"theme"] intValue];
            
            UIColor *colorPIECE;
            if (configTheme==0) colorPIECE = [UIColor whiteColor];
            if (configTheme==1) colorPIECE = UIColorRGB(0x2d2d2d);
            if (configTheme==2) colorPIECE = [UIColor colorWithRed:rand/100 green:rand2/100 blue:rand3/100 alpha:1];
            
            view.backgroundColor = colorPIECE;
            
            //view.backgroundColor = UIColorRGB(0xffffff);
            view.alpha = 1;
            view.tag = 666;
            [clock addSubview:view];
        }
        
        
        
        c++;
        
        if (c==40) {
            l++;
            c=0;
        }
        
    }
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    [appDelegate openSessionWithAllowLoginUI:YES];
    
    if (configTheme==3) {
        NSMutableArray *avatar = [[NSMutableArray alloc] init];
        
        FBRequest* friendsRequest = [FBRequest requestForMyFriends];
        [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      NSDictionary* result,
                                                      NSError *error) {
            NSArray* friends = [result objectForKey:@"data"];
            //NSLog(@"Found: %i friends", friends.count);
            
            for (NSDictionary<FBGraphUser>* friend in friends) {
                //NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
                [avatar addObject:friend.id];
            }
            
            for (UIView *view in clock.subviews) {
                
                if (view.tag==666) {
                    int myNumber = arc4random() % [avatar count];
                    imgNews = [[LoadImageViewController alloc] initWithNibName:nil bundle:nil];
                    imgNews.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
                    //imgNews.view.transform = CGAffineTransformIdentity;
                    //imgNews.view.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                    [imgNews loadImageFromURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=small",[avatar objectAtIndex:myNumber]]]];
                    [view addSubview:imgNews.view];
                }
                
            }
            
        }];
    }
    
    hourOne = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    [hourOne setAirPlay];
    hourOne.view.frame = CGRectMake(pieceWidth*1, 0, pieceWidth*7, pieceWidth*20);
    hourOne.view.tag = 99;
    
    [clock addSubview:hourOne.view];
    
    hourTwo = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    [hourTwo setAirPlay];
    hourTwo.view.frame = CGRectMake(pieceWidth*9, 0, pieceWidth*7, pieceWidth*20);
    hourTwo.view.tag = 99;
    
    [clock addSubview:hourTwo.view];
    
    minuteOne = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    [minuteOne setAirPlay];
    minuteOne.view.frame = CGRectMake(pieceWidth*23, 0, pieceWidth*7, pieceWidth*20);
    minuteOne.view.tag = 99;
    
    [clock addSubview:minuteOne.view];
    
    minuteTwo = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    [minuteTwo setAirPlay];
    minuteTwo.view.frame = CGRectMake(pieceWidth*31, 0, pieceWidth*7, pieceWidth*20);
    minuteTwo.view.tag = 99;
    
    [clock addSubview:minuteTwo.view];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight );
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

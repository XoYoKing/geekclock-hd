//
//  ViewController.m
//  Tetris
//
//  Created by Jonathan Querubina on 11/15/12.
//  Copyright (c) 2012 Phocus Interact. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#define UIColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

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

-(void)removeFacebookUpdateOK
{
    openLink = false;
}

-(void)removeFacebookUpdate
{
    openLink = true;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:7];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeFacebookUpdateOK)];
    faceBook.frame = CGRectMake(faceBook.frame.origin.x, 768, faceBook.frame.size.width, faceBook.frame.size.height);
    [UIView commitAnimations];
}

- (void)updateClock
{
    
    if (UIScreen.screens.count > 1){
        [self showMasterControls:1];
    }else{
        [self showMasterControls:0];
    }
    
    //NSLog(@"%d",UIScreen.screens.count);
    
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
        
        if (configStyle==0 && [dateComponents hour]>12 && [dateComponents hour]<22) {
            horasTXT = [NSString stringWithFormat:@"0%d",[dateComponents hour]-12];
        }else if(configStyle==0 && [dateComponents hour]>21){
            horasTXT = [NSString stringWithFormat:@"%d",[dateComponents hour]-12];
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
    
    //[audioPlayer setCurrentPlaybackTime:0];
    //[audioPlayer play];
    
    /*
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    
    if (playingInfoCenter) {
    
        UIWindow* theWindow = [[UIApplication sharedApplication] keyWindow];
        UIGraphicsBeginImageContext(theWindow.bounds.size);
        [theWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *windowImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage * LandscapeImage = windowImage;
        UIImage * PortraitImage = [[UIImage alloc] initWithCGImage: LandscapeImage.CGImage
                                                             scale: 1.0
                                                       orientation: UIImageOrientationLeft];
    
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage: PortraitImage];
        [songInfo setObject:@"Audio Title" forKey:MPMediaItemPropertyTitle];
        [songInfo setObject:@"Audio Author" forKey:MPMediaItemPropertyArtist];
        [songInfo setObject:@"Audio Album" forKey:MPMediaItemPropertyAlbumTitle];
        [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
    
    }
    */
    
    
}

-(void)changeStyle:(UIButton*)button
{
    
    NSError *sql;
    sql = [database doQuery:[NSString stringWithFormat:@"update preferencias set style=%d",button.tag]];
    
    if (button.tag==0) {
        _12h.enabled = NO;
        _24h.enabled = YES;
    }else{
        _12h.enabled = YES;
        _24h.enabled = NO;
    }
    
    [self recreateClock];
    
}

-(void)changeTheme:(UIButton*)button
{
    
    NSError *sql;
    if (button.tag!=3) sql = [database doQuery:[NSString stringWithFormat:@"update preferencias set theme=%d",button.tag]];
    float position;
    
    if (button.tag==3) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    
    switch (button.tag) {
        case 0:
            white.enabled = NO;
            dark.enabled = YES;
            color.enabled = YES;
            facebook.enabled = YES;
            position = 674;
            if (h<1024) {
                position = 329;
            }
            break;
        case 1:
            white.enabled = YES;
            dark.enabled = NO;
            color.enabled = YES;
            facebook.enabled = YES;
            position = 664+65;
            if (h<1024) {
                position = 329+34;
            }
            break;
        case 2:
            white.enabled = YES;
            dark.enabled = YES;
            color.enabled = NO;
            facebook.enabled = YES;
            position = 664+65+55;
            if (h<1024) {
                position = 329+34+34;
            }
            break;
        case 3:
            white.enabled = YES;
            dark.enabled = YES;
            color.enabled = YES;
            facebook.enabled = NO;
            position = 664+65+55+55;
            if (h<1024) {
                position = 329+34+34+34;
            }
            break;
        default:
            break;
    }
    
    mark.frame = CGRectMake(1014+position-3, mark.frame.origin.y, mark.frame.size.width, mark.frame.size.height);
    
    if (h<1024) {
        mark.frame = CGRectMake(h+position, 20, 31, 27);
    }
    
    if (button.tag!=3) {
        [self recreateClock];
    }
    
}

-(void)openConfig:(id)sender
{
    float alpha=0.2;
    float position = clock.frame.origin.y;
    if (position==0) {
        position = 130;
        alpha = 1;
    }else{
        position=0;
        alpha = 0.2;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    clock.frame = CGRectMake(0, position, h, w);
    configView.frame = CGRectMake(0, position-130, h, 130);
    config.alpha = alpha;
    [UIView commitAnimations];
    
}

-(void)infoButtonView:(id)sender
{
    [configView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

-(void)configButtonView:(id)sender
{
    [configView setContentOffset:CGPointMake(h, 0) animated:YES];
}

-(void)showHideControls:(UITapGestureRecognizer*)tapgesture
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if (config.alpha<1) {
        config.alpha = 1;
    }else{
        config.alpha = 0.2;
    }
    [UIView commitAnimations];
    
    if (clock.frame.origin.y>0) {
        [config sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    //NSLog(@"veio");
    
}

-(void)showMasterControls:(float)alpha
{

    if (alpha==1) {
        configView.frame = CGRectMake(0, 768/2-(130/2), h, w);
        configView.backgroundColor = [UIColor clearColor];
        UIImageView *masterConfig = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        masterConfig.image = [UIImage imageNamed:@"masterConfig.png"];
        masterConfig.tag = 9966;
        [self.view addSubview:masterConfig];
        //[self.view bringSubviewToFront:masterConfig];
        [self.view bringSubviewToFront:configView];
    }else{
        for (UIView *view in self.view.subviews) {
            if (view.tag == 9966) {
                [view removeFromSuperview];
            }
        }
        
        if(configView.frame.size.height>400){
            configView.frame = CGRectMake(0, -130, h, 130);
            configView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgConfigView.png"]];
        }
        
    }
    
    //NSLog(@"%f %f",configView.frame.origin.y,f configView.frame.size.height);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //imgNews = [[LoadImageViewController alloc] initWithNibName:nil bundle:nil];
    
    w = [[UIScreen mainScreen] bounds].size.width;
    h = [[UIScreen mainScreen] bounds].size.height;
    
    database = [[SQLiteManager alloc] initWithDatabaseNamed:@"config.db"];
    [UIApplication sharedApplication].idleTimerDisabled = YES;

    NSError *myErr;

    // Initialize the AVAudioSession here.
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&myErr]) {
        // Handle the error here.
        NSLog(@"Audio Session error %@, %@", myErr, [myErr userInfo]);
    }
    else{
        // Since there were no errors initializing the session, we'll allow begin receiving remote control events
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    
    //NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    //resourcePath = [resourcePath stringByAppendingString:@"/tic.m4a"];
    
    //initialize our audio player
    //audioPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:resourcePath]];
    //[audioPlayer setShouldAutoplay:NO];
    //[audioPlayer setControlStyle: MPMovieControlStyleEmbedded];
    //audioPlayer.view.hidden = YES;
    
    NSArray *configArray = [database getRowsForQuery:@"select * from preferencias"];
    int configTheme = [[[configArray objectAtIndex:0] objectForKey:@"theme"] intValue];
    
    UIColor *colorBG;
    if (configTheme==0) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgWhite.png"]];
    if (configTheme==1 || configTheme==2 || configTheme==3) colorBG = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgBlack.png"]];
    
    self.view.backgroundColor = colorBG;
    
    clock = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [self.view addSubview:clock];
    
    int l = 0;
    int c = 0;
    float pieceWidth = [[UIScreen mainScreen] bounds].size.height/40;
    
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
    
    if (configTheme==3) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    
    
    hourOne = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    hourOne.view.frame = CGRectMake(pieceWidth*1, 0, pieceWidth*7, pieceWidth*20);
    hourOne.view.tag = 99;
    [clock addSubview:hourOne.view];
    
    hourTwo = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    hourTwo.view.frame = CGRectMake(pieceWidth*9, 0, pieceWidth*7, pieceWidth*20);
    hourTwo.view.tag = 99;
    [clock addSubview:hourTwo.view];
    
    minuteOne = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    minuteOne.view.frame = CGRectMake(pieceWidth*23, 0, pieceWidth*7, pieceWidth*20);
    minuteOne.view.tag = 99;
    [clock addSubview:minuteOne.view];
    
    minuteTwo = [[LineViewController alloc] initWithNibName:nil bundle:nil];
    minuteTwo.view.frame = CGRectMake(pieceWidth*31, 0, pieceWidth*7, pieceWidth*20);
    minuteTwo.view.tag = 99;
    [clock addSubview:minuteTwo.view];
    
    config = [[UIButton alloc] initWithFrame:CGRectMake(h-(1024-921), 0, 51, 51)];
    [config setImage:[UIImage imageNamed:@"config.png"] forState:UIControlStateNormal];
    [config addTarget:self action:@selector(openConfig:) forControlEvents:UIControlEventTouchUpInside];
    [clock addSubview:config];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    config.alpha = 0.2;
    [UIView commitAnimations];
    
    UITapGestureRecognizer *tapGesture = nil;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHideControls:)];
	tapGesture.cancelsTouchesInView = NO;
    tapGesture.delaysTouchesEnded = NO;
	tapGesture.numberOfTouchesRequired = 1;
	tapGesture.numberOfTapsRequired = 1;
	tapGesture.delegate = self;
	[clock addGestureRecognizer:tapGesture];
    
    
    
    
    
    
    
    
    configView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -130, h, 130)];
    configView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgConfigView.png"]];
    configView.contentSize = CGSizeMake(h*2, 130);
    configView.contentOffset = CGPointMake(h, 0);
    configView.pagingEnabled = NO;
    configView.scrollEnabled = NO;
    configView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:configView];
    
    UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(1024+73, 56, 21, 23)];
    [infoButton setImage:[UIImage imageNamed:@"infoBtn.png"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(infoButtonView:) forControlEvents:UIControlEventTouchUpInside];
    [configView addSubview:infoButton];
    
    UIButton *infoButtonInactive = [[UIButton alloc] initWithFrame:CGRectMake(73, 56, 21, 23)];
    [infoButtonInactive setImage:[UIImage imageNamed:@"infoInactive.png"] forState:UIControlStateNormal];
    [configView addSubview:infoButtonInactive];
    
    UIButton *configButton = [[UIButton alloc] initWithFrame:CGRectMake(940, 56, 21, 23)];
    [configButton setImage:[UIImage imageNamed:@"configActive.png"] forState:UIControlStateNormal];
    [configButton addTarget:self action:@selector(configButtonView:) forControlEvents:UIControlEventTouchUpInside];
    [configView addSubview:configButton];
    
    UIButton *configButtonInactive = [[UIButton alloc] initWithFrame:CGRectMake(1024+940, 56, 21, 23)];
    [configButtonInactive setImage:[UIImage imageNamed:@"configInative.png"] forState:UIControlStateNormal];
    [configView addSubview:configButtonInactive];
    
    UIImageView *info = [[UIImageView alloc] initWithFrame:CGRectMake(236, 18, 535, 93)];
    info.image = [UIImage imageNamed:@"infoView.png"];
    [configView addSubview:info];

    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(1024+481, 30, 64, 82)];
    logo.image = [UIImage imageNamed:@"logo.png"];
    [configView addSubview:logo];

    UIImageView *style = [[UIImageView alloc] initWithFrame:CGRectMake(1024+169, 38, 280, 55)];
    style.image = [UIImage imageNamed:@"style.png"];
    [configView addSubview:style];

    UIImageView *theme = [[UIImageView alloc] initWithFrame:CGRectMake(1024+575, 38, 306, 55)];
    theme.image = [UIImage imageNamed:@"theme.png"];
    [configView addSubview:theme];

    int configStyle = [[[configArray objectAtIndex:0] objectForKey:@"style"] intValue];

    _12h = [[UIButton alloc] initWithFrame:CGRectMake(1024+180, 47, 79, 37)];
    [_12h setImage:[UIImage imageNamed:@"12h.png"] forState:UIControlStateDisabled];
    [_12h setImage:[UIImage imageNamed:@"12hInative.png"] forState:UIControlStateNormal];
    [_12h addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventTouchUpInside];
    _12h.tag = 0;
    if(configStyle==0) _12h.enabled = NO;
    [configView addSubview:_12h];

    _24h = [[UIButton alloc] initWithFrame:CGRectMake(1024+271, 47, 79, 37)];
    [_24h setImage:[UIImage imageNamed:@"24h.png"] forState:UIControlStateDisabled];
    [_24h setImage:[UIImage imageNamed:@"24hInative.png"] forState:UIControlStateNormal];
    [_24h addTarget:self action:@selector(changeStyle:) forControlEvents:UIControlEventTouchUpInside];
    if(configStyle==1) _24h.enabled = NO;
    _24h.tag = 1;
    [configView addSubview:_24h];
    
    float position;
    if(configTheme==0) position = 664;
    if(configTheme==1) position = 664+55;
    if(configTheme==2) position = 664+55+55;
    if(configTheme==3) position = 664+55+55+55;
    
    mark = [[UIImageView alloc] initWithFrame:CGRectMake(1024+position-3, 47-3, 50, 43)];
    mark.image = [UIImage imageNamed:@"mark.png"];
    [configView addSubview:mark];
    
    white = [[UIButton alloc] initWithFrame:CGRectMake(1024+664, 47, 44, 37)];
    [white setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [white setImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateDisabled];
    [white addTarget:self action:@selector(changeTheme:) forControlEvents:UIControlEventTouchUpInside];
    white.tag = 0;
    if(configTheme==0) white.enabled = NO;
    [configView addSubview:white];

    dark = [[UIButton alloc] initWithFrame:CGRectMake(1024+664+55, 47, 44, 37)];
    [dark setImage:[UIImage imageNamed:@"dark.png"] forState:UIControlStateNormal];
    [dark setImage:[UIImage imageNamed:@"dark.png"] forState:UIControlStateDisabled];
    [dark addTarget:self action:@selector(changeTheme:) forControlEvents:UIControlEventTouchUpInside];
    dark.tag = 1;
    if(configTheme==1) dark.enabled = NO;
    [configView addSubview:dark];

    color = [[UIButton alloc] initWithFrame:CGRectMake(1024+664+55+55, 47, 44, 37)];
    [color setImage:[UIImage imageNamed:@"color.png"] forState:UIControlStateNormal];
    [color setImage:[UIImage imageNamed:@"color.png"] forState:UIControlStateDisabled];
    [color addTarget:self action:@selector(changeTheme:) forControlEvents:UIControlEventTouchUpInside];
    color.tag = 2;
    if(configTheme==2) color.enabled = NO;
    [configView addSubview:color];
    
    facebook = [[UIButton alloc] initWithFrame:CGRectMake(1024+664+55+55+55, 47, 44, 37)];
    [facebook setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
    [facebook setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateDisabled];
    [facebook addTarget:self action:@selector(changeTheme:) forControlEvents:UIControlEventTouchUpInside];
    facebook.tag = 3;
    if(configTheme==3) facebook.enabled = NO;
    [configView addSubview:facebook];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock) userInfo:nil repeats:YES];
    
    UIImageView *splash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    splash.image = [UIImage imageNamed:@"splash.png"];
    [self.view addSubview:splash];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:3];
    [UIView setAnimationDuration:1];
    splash.alpha = 0;
    [UIView commitAnimations];
    
    if (h<1024) {
        
        configView.frame = CGRectMake(0, -130, h, 130);
        configView.contentOffset = CGPointMake(h, 0);
        configView.contentSize = CGSizeMake(h*2, 130);
        
        infoButton.frame = CGRectMake(873/2+h, 153/2, 21, 23);
        infoButtonInactive.frame = CGRectMake(873/2, 153/2, 21, 23);
        configButton.frame = CGRectMake(810/2, 153/2, 21, 23);
        configButtonInactive.frame = CGRectMake(810/2+h, 153/2, 21, 23);
        info.frame = CGRectMake(30, 30, 682/2, 118/2);
        logo.frame = CGRectMake(20+h, 20, 64, 82);
        style.frame = CGRectMake(h+93, 16, 175, 35);
        theme.frame = CGRectMake(h+275, 16, 193, 35);
        _12h.frame = CGRectMake(h+100, 23, 50, 23);
        _24h.frame = CGRectMake(h+158, 23, 50, 23);
        
        if(configTheme==0) position = 329;
        if(configTheme==1) position = 329+34;
        if(configTheme==2) position = 329+34+34;
        if(configTheme==3) position = 329+34+34+34;
        
        mark.frame = CGRectMake(h+position, 20, 31, 27);
        
        white.frame = CGRectMake(h+331, 22, 27, 23);
        dark.frame = CGRectMake(h+331+34, 22, 27, 23);
        color.frame = CGRectMake(h+331+34+34, 22, 27, 23);
        facebook.frame = CGRectMake(h+331+34+34+34, 22, 27, 23);
        
        splash.image = [UIImage imageNamed:@"loaderMini.png"];
        splash.frame = CGRectMake((h/2)-(568/2), 0, 568, 320);
        
    }
    
    faceBook = [[UIButton alloc] initWithFrame:CGRectMake(230, 768, 564, 77)];
    faceBook.tag = 9999999;
    [faceBook addTarget:self action:@selector(openFacebookLink:) forControlEvents:UIControlEventTouchUpInside];
    faceBook.backgroundColor = [UIColor blackColor];
    [self.view addSubview:faceBook];
    
    UIImageView *bgFacebook = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 564, 77)];
    bgFacebook.image = [UIImage imageNamed:@"bgFacebook.png"];
    bgFacebook.tag = 1;
    [faceBook addSubview:bgFacebook];
    
    UIView *avatar = [[UIView alloc] initWithFrame:CGRectMake(11, 12, 56, 56)];
    avatar.tag = 12;
    [faceBook addSubview:avatar];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(94, 21, 413, 11)];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    name.tag = 1;
    [faceBook addSubview:name];
    
    UILabel *descricao = [[UILabel alloc] initWithFrame:CGRectMake(94, 35, 413, 30)];
    descricao.backgroundColor = [UIColor clearColor];
    descricao.textColor = [UIColor whiteColor];
    descricao.numberOfLines = 2;
    descricao.font = [UIFont fontWithName:@"Helvetica" size:12];
    descricao.lineBreakMode = UILineBreakModeTailTruncation;
    descricao.tag = 2;
    [faceBook addSubview:descricao];
    
    openLink = false;

}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    float x = [[[event allTouches] anyObject] locationInView:self.view].x;
    float y = [[[event allTouches] anyObject] locationInView:self.view].y;
    
    //NSLog(@"%f %f",x,faceBook.frame.origin.y);
    
    if (x>230 && x<(564+230) && openLink && y>(768-77)) {
        
        //NSURL *fanPageURL = [NSURL URLWithString:[linkURL stringByReplacingOccurrencesOfString:@"http://www.facebook.com/" withString:@"fb://"]];
        //NSLog(@"%@",fanPageURL);
        
        //if (![[UIApplication sharedApplication] openURL: fanPageURL]) {
            NSURL *webURL = [NSURL URLWithString:linkURL];
            [[UIApplication sharedApplication] openURL: webURL];
            //NSLog(@"%@",webURL);
        //}
        
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        
        [hourOne setNumber:10];
        hourOne.view.tag = 10;
        
        [hourTwo setNumber:11];
        hourTwo.view.tag = 11;
        
        [minuteOne setNumber:12];
        minuteOne.view.tag = 12;
        
        [minuteTwo setNumber:13];
        minuteTwo.view.tag = 13;
        
    }
    
}

-(BOOL)canBecomeFirstResponder {
	return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight );
}

-(void)viewWillAppear:(BOOL)animated
{
    [self becomeFirstResponder];
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

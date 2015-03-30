//
//  LoadImageViewController.m
//  Play
//
//  Created by Jonathan on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadImageViewController.h"

@implementation LoadImageViewController

@synthesize view;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        view.tag = 1;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadImageFromURL:(NSURL*)url {

    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //[loader setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
    //[self.view addSubview:loader];
    //[loader startAnimating];


}

- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    
    connection=nil;
    
    //[loader stopAnimating];
    //[loader removeFromSuperview];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
    imageView.alpha = 0;
    
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    imageView.frame = self.view.bounds;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    imageView.alpha = 1;
    [UIView commitAnimations];
    
    data=nil;
    
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

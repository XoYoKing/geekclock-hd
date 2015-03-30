//
//  LoadImageViewController.h
//  Play
//
//  Created by Jonathan on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadImageViewController : UIViewController {
    NSURLConnection* connection;
    NSMutableData* data;
    UIActivityIndicatorView *loader;

}

- (void)loadImageFromURL:(NSURL*)url;

@property (nonatomic,retain) UIView *loaded;

@end
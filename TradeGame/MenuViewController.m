//
//  MenuViewController.m
//  TradeGame
//
//  Created by Trevor Stevenson on 6/26/14.
//  Copyright (c) 2014 TStevenson Apps. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (IBAction)moreGames:(id)sender {
    
    NSURL *otherAppsURL = [NSURL URLWithString:@"https://itunes.apple.com/developer/trevor-stevenson/id904381709"];
    
    [[UIApplication sharedApplication] openURL:otherAppsURL];
    
}

- (IBAction)follow:(id)sender {
    
    NSURL *twitterURL = [NSURL URLWithString:@"twitter://user?screen_name=tstevensonapps"];
    
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL])
    {
        [[UIApplication sharedApplication] openURL:twitterURL];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/tstevensonapps"]];
    }
    
}

@end

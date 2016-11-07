//
//  MenuViewController.m
//  TradeGame
//
//  Created by Trevor Stevenson on 6/26/14.
//  Copyright (c) 2014 NCUnited. All rights reserved.
//

#import "MenuViewController.h"
#import <Chartboost/Chartboost.h>

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
    
    [Chartboost setDelegate:self];
    
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

-(void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward
{

    NSLog(@"completed");
    
    NSNumber *money = [NSNumber numberWithInt:[[[NSUserDefaults standardUserDefaults] objectForKey:@"moneyAdded"] intValue]];
    
    int newMoney = [money intValue] + 1000;
    
    NSNumber *moneyToAdd = [NSNumber numberWithInt:newMoney];
    
    [[NSUserDefaults standardUserDefaults] setObject:moneyToAdd forKey:@"moneyAdded"];
    
}

- (IBAction)moreGames:(id)sender {
    
    [Chartboost showMoreApps:CBLocationMainMenu];
    
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

- (IBAction)earnMoney:(id)sender {
    
    [Chartboost showRewardedVideo:CBLocationMainMenu];
    
}
@end

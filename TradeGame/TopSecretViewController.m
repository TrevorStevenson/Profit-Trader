//
//  TopSecretViewController.m
//  TradeGame
//
//  Created by Trevor Stevenson on 7/19/14.
//  Copyright (c) 2014 NCUnited. All rights reserved.
//

#import "TopSecretViewController.h"

@interface TopSecretViewController ()

@end

@implementation TopSecretViewController

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
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"didWin"];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHome:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end

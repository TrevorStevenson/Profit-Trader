//
//  OptionViewController.m
//  TradeGame
//
//  Created by Trevor Stevenson on 7/21/14.
//  Copyright (c) 2014 NCUnited. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController () <UIAlertViewDelegate>

@end

@implementation OptionViewController

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
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"newGame"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"newGame"] isEqualToString:@"YES"]) {
        
        self.buttonNewGame.enabled = YES;
        self.continueButton.enabled = NO;
        
        self.shouldPrompt = NO;
        
    }
    else
    {
        self.buttonNewGame.enabled = YES;
        self.continueButton.enabled = YES;
        
        self.shouldPrompt = YES;
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"newGame"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"newGame"];
        
    }
    else if ([[segue identifier] isEqualToString:@"continue"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"newGame"];
    }
    
    
}


- (IBAction)newGame:(UIButton *)sender
{
    if (self.shouldPrompt)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:@"You will lose all of the progress from your previous game and start over." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self performSegueWithIdentifier:@"newGame" sender:self];
            
        }]];
        
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"newGame" sender:self];
    }
}

- (IBAction)continueAction:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"continue" sender:self];
}

- (IBAction)backButton:(UIButton *)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end

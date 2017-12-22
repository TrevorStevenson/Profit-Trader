//
//  GameViewController.m
//  TradeGame
//
//  Created by Trevor Stevenson on 6/26/14.
//  Copyright (c) 2014 NCUnited. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
{
    //creates timer for the clock.
    NSTimer *clockTimer;
    NSTimer *priceTimer;
    
    UIAlertView *alert;
}

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [self stopEverything];
        [self resetClock];
        [self.beginButtonOutlet setTitle:@"Begin" forState:UIControlStateNormal];
        [self newGame];
        [self updateElements];
        
    }
    else if (buttonIndex == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"newGame"];

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    //checks the user device to see if they have played before or if it's a new game
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"newGame"] == nil || [[[NSUserDefaults standardUserDefaults] objectForKey:@"newGame"] isEqualToString:@"YES"])
    {
        //if it is a new game, call the new game method, which sets properties
        [self newGame];
        
    }
    //otherwise...
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"newGame"] isEqualToString:@"NO"])
    {
        //set properties to values saved after they last closed the app
        self.inventoryCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"inventory"] intValue];

        self.clockMinutes = [[[NSUserDefaults standardUserDefaults] objectForKey:@"minutes"] intValue];

        self.clockSeconds = [[[NSUserDefaults standardUserDefaults] objectForKey:@"seconds"] intValue];
        
        self.currentDay = [[[NSUserDefaults standardUserDefaults] objectForKey:@"day"] intValue];
        
        self.crashDay = [[[NSUserDefaults standardUserDefaults] objectForKey:@"crashDay"] intValue];
        
        self.rallyDay = [[[NSUserDefaults standardUserDefaults] objectForKey:@"rallyDay"] intValue];

        self.moneyCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"money"] floatValue] + [[[NSUserDefaults standardUserDefaults] objectForKey:@"moneyAdded"] floatValue];
        
        self.currentPrice = [[[NSUserDefaults standardUserDefaults] objectForKey:@"price"] floatValue];
        
        self.changeInPrice = [[[NSUserDefaults standardUserDefaults] objectForKey:@"changeInPrice"] floatValue];
        
        [[NSUserDefaults standardUserDefaults] setObject:0 forKey:@"moneyAdded"];
                
        if (self.clockSeconds != 0)
        {
            [self.beginButtonOutlet setTitle:@"Resume" forState:UIControlStateNormal];
        }
    }
    
    //sets the labels onscreen after properties have been set
    [self updateElements];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //called when the game screen goes away
    [self saveGameData];
    
    [self stopEverything];
}

-(void)newGame
{
    //sets all of the properties for a brand new game
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"moneyAdded"] == 0)
    {
        self.moneyCount = 100.00;
    }
    else
    {
        self.moneyCount = 100.00 + [[defaults objectForKey:@"moneyAdded"] floatValue];
    }
    
    [defaults setObject:0 forKey:@"moneyAdded"];
    
    
    self.inventoryCount = 0;
    self.currentPrice = 1.00;
    self.currentDay = 0;
    self.changeInPrice = 0.00;
    self.clockMinutes = 1;
    self.clockSeconds = 0;
    
    self.crashDay = arc4random()%6 + 10;
    self.rallyDay = arc4random()%11 + 16;
    
    if (!alert) {
        
        alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"Buy and sell items to make profit. The price fluctuates every 2 seconds.  You start with $100.00 and must make 1 million dollars. Each transaction has a 1 cent tax. There is a daily tax as well, which increases by 10 cents each day.  Good luck." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    }
    
    //tells the device to no longer make a new game
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"newGame"];
}

-(void)saveGameData
{
    //saves all the properties to the user's device
    NSNumber *inventory = [NSNumber numberWithInt:self.inventoryCount];
    
    NSNumber *minutes = [NSNumber numberWithInt:self.clockMinutes];
    
    NSNumber *seconds = [NSNumber numberWithInt:self.clockSeconds];
    
    NSNumber *day = [NSNumber numberWithInt:self.currentDay];
    
    NSNumber *crashDay = [NSNumber numberWithInt:self.crashDay];
    
    NSNumber *rallyDay = [NSNumber numberWithInt:self.rallyDay];
    
    NSNumber *money = [NSNumber numberWithFloat:self.moneyCount];
    
    NSNumber *price = [NSNumber numberWithFloat:self.currentPrice];
    
    NSNumber *changeInPrice = [NSNumber numberWithFloat:self.changeInPrice];
    
    [[NSUserDefaults standardUserDefaults] setObject:money forKey:@"money"];
    
    [[NSUserDefaults standardUserDefaults] setObject:inventory forKey:@"inventory"];
    
    [[NSUserDefaults standardUserDefaults] setObject:minutes forKey:@"minutes"];
    
    [[NSUserDefaults standardUserDefaults] setObject:seconds forKey:@"seconds"];
    
    [[NSUserDefaults standardUserDefaults] setObject:day forKey:@"day"];
    
    [[NSUserDefaults standardUserDefaults] setObject:price forKey:@"price"];
    
    [[NSUserDefaults standardUserDefaults] setObject:changeInPrice forKey:@"changeInPrice"];
    
    [[NSUserDefaults standardUserDefaults] setObject:crashDay forKey:@"crashDay"];
    
    [[NSUserDefaults standardUserDefaults] setObject:rallyDay forKey:@"rallyDay"];
}

-(void)startDayTimer
{
    //decreases the seconds by 1.
    self.clockSeconds--;
    
    //if the seconds are negative, i.e. after they were just zero, it resets it to 59 and decreases the minutes by 1, so long as the minutes are not zero, as we don't like negative time.
    if (self.clockSeconds < 0 && self.clockMinutes >= 0)
    {
        self.clockMinutes--;
        self.clockSeconds = 59;
    }

    //checks whether there are less than 10 seconds for aesthetic reasons.
    if (self.clockSeconds < 10 && self.clockSeconds >= 0)
    {
        //puts a zero in front of the seconds to look like a real clock. (5:03 instead of 5:3)
        self.clockLabel.text = [NSString stringWithFormat:@"%d:0%d", self.clockMinutes, self.clockSeconds];

    }
    else
    {
        //makes label minutes:seconds.
        self.clockLabel.text = [NSString stringWithFormat:@"%d:%d", self.clockMinutes, self.clockSeconds];
        
    }
    
    //if there is no time left, stop the timer.
    if (self.clockSeconds == 0 && self.clockMinutes == 0)
    {
        
        [self stopEverything];
        
        [self resetClock];
        
        self.dayInProgress = NO;
        
        self.moneyCount -= (0.10f * self.currentDay);
        
        [self bankruptcyCheck];
        
        if (self.currentDay == self.crashDay) {
            
            self.crashDay = self.currentDay + (arc4random()%11 + 3);

        }
        if (self.currentDay == self.rallyDay) {
            
            self.rallyDay = self.currentDay + (arc4random()%11 + 3);
            
        }
        
        if (self.currentPrice < 2.00)
        {
            self.rallyDay = self.currentDay + 1;
        }
        
        [self updateElements];
        
        [self.beginButtonOutlet setTitle:@"Begin" forState:UIControlStateNormal];
        
        [self saveGameData];
        
    }
}

-(void)updateElements
{
    
    if (self.dayInProgress)
    {
        if ((self.moneyCount - self.currentPrice) < .01f)
        {
            self.buyButtonOutlet.enabled = NO;
            self.buyAllOutlet.enabled = NO;
        }
        else
        {
            self.buyButtonOutlet.enabled = YES;
            self.buyAllOutlet.enabled = YES;

        }
        if (self.inventoryCount <= 0)
        {
            self.sellButtonOutlet.enabled = NO;
            self.sellAllOutlet.enabled = NO;
        }
        else
        {
            self.sellButtonOutlet.enabled = YES;
            self.sellAllOutlet.enabled = YES;
        }
    }
    else
    {
        self.buyButtonOutlet.enabled = NO;
        self.buyAllOutlet.enabled = NO;
        self.sellButtonOutlet.enabled = NO;
        self.sellAllOutlet.enabled = NO;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setMaximumFractionDigits:2];
    
    [formatter setMinimumFractionDigits:2];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    if (self.moneyCount < 0) {
        self.moneyCount = 0.00;
    }
    
    self.bankTotal.text = [NSString stringWithFormat:@"Bank: $%@", [formatter stringFromNumber:[NSNumber numberWithFloat:self.moneyCount]]];
    
    
    if (self.inventoryCount == 1)
    {
        self.inventoryLabel.text = [NSString stringWithFormat:@"%d item", self.inventoryCount];
    }
    else
    {
        self.inventoryLabel.text = [NSString stringWithFormat:@"%d items", self.inventoryCount];
    }
    
    self.priceChangeLabel.text = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithFloat:self.changeInPrice]]];

    self.dayLabel.text = [NSString stringWithFormat:@"Day %d", self.currentDay];
    
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithFloat:self.currentPrice]]];
    
    //checks whether there are less than 10 seconds for aesthetic reasons.
    if (self.clockSeconds < 10 && self.clockSeconds >= 0)
    {
        //puts a zero in front of the seconds to look like a real clock. (5:03 instead of 5:3)
        self.clockLabel.text = [NSString stringWithFormat:@"%d:0%d", self.clockMinutes, self.clockSeconds];
    }
    else
    {
        //makes label minutes:seconds.
        self.clockLabel.text = [NSString stringWithFormat:@"%d:%d", self.clockMinutes, self.clockSeconds];
    }
}

-(void)changePrice
{
    int volatility = (self.currentDay * 5) - 1;
    
    float random = arc4random()%(volatility + 1) + 1;
    
    self.changeInPrice = (random) / (100.0f);
    
    int sign = arc4random()%11;
    
    if (self.currentDay <= 5) {
        
        if (sign >= 8) {
            
            self.changeInPrice *= -1;
        }
    }
    else if (self.currentDay != self.crashDay && self.currentDay != self.rallyDay)
    {
        if (sign >= 6)
        {
            self.changeInPrice *= -1;
        }
        
    }
    else if (self.currentDay == self.crashDay)
    {
        if (sign >= 2) {
            
            self.changeInPrice *= -1;
        }
    }
    else if (self.currentDay == self.rallyDay)
    {
        if (sign >= 9) {
            
            self.changeInPrice *= -1;
        }
        
    }
    
    self.currentPrice += self.changeInPrice;
    
    if (self.currentPrice < 0)
    {
        self.currentPrice = 0.00;
    }
    if (self.currentPrice == 0.00)
    {
        [self stopEverything];
        
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Bankrupt!" message:@"The price has dropped to 0 and is no longer desirable.  Unfortunately, you never amassed 1 million dollars." delegate:self cancelButtonTitle:nil otherButtonTitles:@"New Game", @"Main Menu", nil];
        [alert2 show];
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setMinimumFractionDigits:2];
    
    [formatter setMaximumFractionDigits:2];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithFloat:self.currentPrice]]];
    
     self.priceChangeLabel.text = [NSString stringWithFormat:@"$%@", [formatter stringFromNumber:[NSNumber numberWithFloat:self.changeInPrice]]];
    
    if (self.changeInPrice >= 0)
    {
        self.priceChangeIndicator.image = [UIImage imageNamed:@"upArrow"];
    }
    else
    {
        self.priceChangeIndicator.image = [UIImage imageNamed:@"downArrow"];
    }
    
    [self updateElements];
    
}

-(void)beginTrading
{
    //sets off price change every two seconds

    priceTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePrice) userInfo:nil repeats:YES];
    
    [priceTimer fire];
}

-(void)buyItem
{
    //increment the inventory
    self.inventoryCount++;
    
    //subtract current price from total money
    self.moneyCount -= self.currentPrice;
 
    self.moneyCount -= 0.01f;
    
    [self bankruptcyCheck];
    
    //update labels
    [self updateElements];
    

}

-(void)sellItem
{
    //decrement the inventory
    self.inventoryCount--;
    
    if (self.inventoryCount < 0) {
        self.inventoryCount = 0;
    }
    
    //add current price to total money
    self.moneyCount += self.currentPrice;
    
    self.moneyCount -= 0.01f;
    
    [self bankruptcyCheck];
    
    //update labels
    [self updateElements];
    

}

-(void)startClock
{
    if (!clockTimer)
    {
        clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startDayTimer) userInfo:nil repeats:YES];
        
        [clockTimer fire];
        
    }
    
}

-(void)startPriceClock
{
    if (!priceTimer)
    {
        priceTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePrice) userInfo:nil repeats:YES];
    }
    
}

-(void)resetClock
{
    self.clockMinutes = 1;
    self.clockSeconds = 0;
    
    [self updateElements];
}
    
-(void)stopEverything
{
    [clockTimer invalidate];
    
    clockTimer = nil;
    
    [priceTimer invalidate];
    
    priceTimer = nil;
    
}
    
- (IBAction)beginDayButton:(UIButton *)sender
{    
    NSLog(@"Yes");
    self.beginButtonOutlet.enabled = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(enable) userInfo:nil repeats:NO];
    
    
    //checks the title on the label.
    if ([sender.titleLabel.text isEqualToString:@"Begin"])
    {
        //if they clicked 'begin', call methods to start the clock and start the price moving.
        self.dayInProgress = YES;
        
        [self startClock];
        
        self.currentDay++;
        
        [self performSelector:@selector(beginTrading) withObject:nil afterDelay:1.0];
        
        [self updateElements];
        
        //change the button to 'pause trading' as they have just began trading.
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"Pause"])
    {
        //if they clicked 'pause', pause the game.
        [self stopEverything];
        
        self.dayInProgress = NO;
        
        [sender setTitle:@"Resume" forState:UIControlStateNormal];
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"Resume"])
    {
        
        if (self.dayInProgress == NO)
        {
            [self startClock];
            
            if (self.clockSeconds % 2 == 0)
            {
                [self beginTrading];
            }
            else
            {
                [self performSelector:@selector(beginTrading) withObject:nil afterDelay:(self.clockSeconds % 2)];
            }
            
            [sender setTitle:@"Pause" forState:UIControlStateNormal];
            
            self.dayInProgress = YES;
        }
       
        
    }
    
}

-(void)enable
{
    self.beginButtonOutlet.enabled = YES;
}

- (IBAction)buyButton:(UIButton *)sender
{
    [self buyItem];
}

- (IBAction)sellButton:(UIButton *)sender
{
    [self sellItem];
    
}

- (IBAction)quitButton:(UIButton *)sender {
    
    //goes back to the main screen
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self stopEverything];
    
}

- (IBAction)buyAll:(UIButton *)sender {
    
    int numberToBuy = self.moneyCount / self.currentPrice;
    
    while ((self.moneyCount - (self.currentPrice * numberToBuy)) - (0.01f * numberToBuy) < 0)
    {
        numberToBuy--;
    }
    
    //increment the inventory
    self.inventoryCount += numberToBuy;
    
    //subtract current price from total money
    self.moneyCount -= (self.currentPrice * numberToBuy);
    
    self.moneyCount -= (0.01f * numberToBuy);
    
    [self bankruptcyCheck];
    
    //update labels
    [self updateElements];

    
}

- (IBAction)sellAll:(UIButton *)sender {
    
    int numberToSell = self.inventoryCount;
    
    //increment the inventory
    self.inventoryCount = 0;
    
    //subtract current price from total money
    self.moneyCount += (self.currentPrice * numberToSell);
    
    self.moneyCount -= (0.01f * numberToSell);
    
    [self bankruptcyCheck];
    
    //update labels
    [self updateElements];

}

-(void)bankruptcyCheck
{
    if (self.moneyCount < 0 || (self.moneyCount == 0 && self.inventoryCount == 0))
    {
        [self stopEverything];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setValue:0 forKey:@"money"];
        
        [defaults synchronize];
        
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Bankrupt!" message:@"You have run out of money and can no longer trade.  Unfortunately, you never amassed 1 million dollars." delegate:self cancelButtonTitle:nil otherButtonTitles:@"New Game", @"Main Menu", nil];
        [alert3 show];
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"didWin"])
    {
        if (self.moneyCount >= 1000000) {
            
            [self stopEverything];
            
            [self performSegueWithIdentifier:@"congrats" sender:self];
            
        }
    }
    
    

}

@end

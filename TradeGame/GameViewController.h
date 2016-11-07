//
//  GameViewController.h
//  TradeGame
//
//  Created by Trevor Stevenson on 6/26/14.
//  Copyright (c) 2014 NCUnited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UIAlertViewDelegate>

//labels
@property (weak, nonatomic) IBOutlet UILabel *bankTotal;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *inventoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

//image views
@property (weak, nonatomic) IBOutlet UIImageView *priceChangeIndicator;

//ints
@property (nonatomic) int clockMinutes;
@property (nonatomic) int clockSeconds;
@property (nonatomic) int inventoryCount;
@property (nonatomic) int currentDay;
@property (nonatomic) int crashDay;
@property (nonatomic) int rallyDay;


//floats
@property (nonatomic) float currentPrice;
@property (nonatomic) float changeInPrice;
@property (nonatomic) float moneyCount;
@property (nonatomic) float tax;


//bools
@property (nonatomic) BOOL dayInProgress;

//button actions
- (IBAction)beginDayButton:(UIButton *)sender;
- (IBAction)buyButton:(UIButton *)sender;
- (IBAction)sellButton:(UIButton *)sender;
- (IBAction)quitButton:(UIButton *)sender;
- (IBAction)buyAll:(UIButton *)sender;
- (IBAction)sellAll:(UIButton *)sender;

//button outlets
@property (weak, nonatomic) IBOutlet UIButton *beginButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *buyButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *sellButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *buyAllOutlet;
@property (weak, nonatomic) IBOutlet UIButton *sellAllOutlet;




@end

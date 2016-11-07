//
//  OptionViewController.h
//  TradeGame
//
//  Created by Trevor Stevenson on 7/21/14.
//  Copyright (c) 2014 NCUnited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonNewGame;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
- (IBAction)newGame:(UIButton *)sender;
- (IBAction)continueAction:(UIButton *)sender;
- (IBAction)backButton:(UIButton *)sender;
@property (nonatomic) BOOL shouldPrompt;


@end

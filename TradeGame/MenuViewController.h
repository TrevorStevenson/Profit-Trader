//
//  MenuViewController.h
//  TradeGame
//
//  Created by Trevor Stevenson on 6/26/14.
//  Copyright (c) 2014 NCUnited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Chartboost/Chartboost.h>

@interface MenuViewController : UIViewController <ChartboostDelegate>

- (IBAction)moreGames:(id)sender;
- (IBAction)follow:(id)sender;
- (IBAction)earnMoney:(id)sender;

@end

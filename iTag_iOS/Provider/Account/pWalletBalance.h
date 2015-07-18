//
//  UIViewController+WalletBalance.h
//  myaccount
//
//  Created by WENG Lili on 12/7/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpHelper.h"

@interface WalletBalance: UIViewController

@property (weak, nonatomic) IBOutlet UILabel *wallet_balance_label;
@property (weak, nonatomic) IBOutlet UILabel *money_label;
@property (weak, nonatomic) IBOutlet UIButton *transaction_details_label;
@property (weak, nonatomic) IBOutlet UIImageView *walletbalanceicon;

@property (nonatomic,strong) NSString *userID;

@end

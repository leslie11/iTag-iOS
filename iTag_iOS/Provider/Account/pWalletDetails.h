//
//  UITableViewController+WalletDetails.h
//  myaccount
//
//  Created by WENG Lili on 9/7/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpHelper.h"

@interface  WalletDetails:UITableViewController

@property (nonatomic, copy) NSMutableArray *transactionList;

@end

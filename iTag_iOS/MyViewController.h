//
//  MyViewController.h
//  DropdownMenu-Example
//
//  Created by Nils Mattisson on 1/13/14.
//  Copyright (c) 2014 Nils Mattisson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpHelper.h"

@interface MyViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *money_label;

@end

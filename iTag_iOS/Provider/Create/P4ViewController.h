//
//  UIViewController+P1ViewController.h
//  i-Tag_Provider
//
// Created by WENG Lilion 15/7/15.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpHelper.h"

#import "SCLAlertView.h"

#import "ProviderViewController.h"

@interface P4ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *P4TextView;

@property (nonatomic,copy) NSString *PostID;
@property (nonatomic,copy) NSString *UserID;

@end

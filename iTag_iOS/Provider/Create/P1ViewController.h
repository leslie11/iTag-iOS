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

@interface P1ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *P1TextView;

@property (weak, nonatomic) IBOutlet UITextField *oneTextField;
@property (weak, nonatomic) IBOutlet UITextField *twoTextField;
@property (weak, nonatomic) IBOutlet UITextField *threeTextField;
@property (weak, nonatomic) IBOutlet UITextField *fourTextField;

@property (nonatomic,copy) NSString *PostID;
@property (nonatomic,copy) NSString *UserID;

@end

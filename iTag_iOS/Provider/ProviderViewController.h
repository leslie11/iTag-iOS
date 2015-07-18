//
//  ViewController.h
//  i-Tag_Provider
//
// Created by WENG Lilion 15/6/18.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpHelper.h"

@interface ProviderViewController : UIViewController

@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *password;

@property (nonatomic,copy) NSString *UserID;
@end


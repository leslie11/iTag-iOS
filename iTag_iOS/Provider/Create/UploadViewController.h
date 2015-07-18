//
//  UIViewController+UploadViewController.h
//  i-Tag_Provider
//
// Created by WENG Lilion 15/7/13.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FUIButton.h"
#import "UIImage+FlatUI.h"
#import <FlatUIKit/UIColor+FlatUI.h>
#import "UIFont+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"

#import <QBImagePickerController.h>
#import "UIImageExtras.h"
#import "AFNetworking.h"

@interface UploadViewController : UIViewController

@property (weak, nonatomic) IBOutlet FUIButton *uploadButton;
- (IBAction)uploadImage:(id)sender;

@property (nonatomic,copy) NSString *PostID;
@property (nonatomic,copy) NSString *UserID;

@end

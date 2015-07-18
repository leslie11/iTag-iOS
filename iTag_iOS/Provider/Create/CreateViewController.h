//
//  UIViewController+CreateViewController.h
//  i-Tag_Provider
//
// Created by WENG Lili on 15/7/10
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HttpHelper.h"
#import "AFNetworking.h"

#import "FUIButton.h"
#import "UIImage+FlatUI.h"
#import <FlatUIKit/UIColor+FlatUI.h>
#import "UIFont+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "FUITextField.h"
#import "UISlider+FlatUI.h"
#import "FUIAlertView.h"

#import "PlaceholderTextView.h"
#import "HSDatePickerViewController.h"
#import "ASValuePopUpView.h"
#import "ASValueTrackingSlider.h"

#import "SCLAlertView.h"
#import "UploadViewController.h"

@interface CreateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)showDatePicker:(id)sender;
@property (weak, nonatomic) IBOutlet FUITextField *nameText;

@property (weak, nonatomic) IBOutlet FUITextField *budgetText;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *descriptText;
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *workerLevel;


@property (weak, nonatomic) IBOutlet FUIButton *FinishButton;
@property (weak, nonatomic) IBOutlet FUIButton *CancelButton;
- (IBAction)FinishAction:(id)sender;
- (IBAction)CancelAction:(id)sender;

@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *PostID;

@end

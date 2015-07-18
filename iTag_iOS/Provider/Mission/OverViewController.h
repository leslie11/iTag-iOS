//
//  UITableViewController+OverViewController.h
//  i-Tag_Provider
//
// Created by WENG Lili on 15/7/10
//

#import <UIKit/UIKit.h>
#import "providerMissionViewController.h"

@interface OverViewController : UITableViewController

@property (nonatomic,copy) NSString *PostID;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workerlvlLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptTextView;

@end

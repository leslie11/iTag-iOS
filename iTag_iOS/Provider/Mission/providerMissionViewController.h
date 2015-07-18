//
//  UITableViewController+MissionViewController.h
//  i-Tag_Provider
//
// Created by WENG Lili on 15/7/10
//

#import <UIKit/UIKit.h>
#import "MissionViewCell.h"
#import "HttpHelper.h"

#import "OverViewController.h"

@interface MissionViewController : UITableViewController

@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSDictionary *dic;

@end

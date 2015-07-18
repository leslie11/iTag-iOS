//
//  TableViewController.h
//  myaccount
//
//  Created by WENG Lili on 27/6/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpHelper.h"

@interface AccountViewController : UITableViewController
//@property(retain, atomic) NSMutableArray *section1Items;
//@property(retain, atomic) NSMutableArray *section2Items;


@property (weak, nonatomic) IBOutlet UILabel *Gender_Label;
@property (weak, nonatomic) IBOutlet UILabel *Email_Label;
@property (weak, nonatomic) IBOutlet UILabel *Level_Label;
@property (weak, nonatomic) IBOutlet UIProgressView *Level_Progress;
@property (weak, nonatomic) IBOutlet UIImageView *Avatar;

@property (weak, nonatomic) IBOutlet UILabel *Name_Label;

@property (nonatomic,strong) NSString *userID;

@end

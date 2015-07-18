//
//  UITableViewCell+TransactionTableviewCell.h
//  myaccount
//
//  Created by WENG Lili on 9/7/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionTableviewCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *target_Label;
@property (weak, nonatomic) IBOutlet UILabel *time_Label;
@property (weak, nonatomic) IBOutlet UILabel *amount_Label;
@property (weak, nonatomic) IBOutlet UILabel *type_Label;
@property (weak, nonatomic) IBOutlet UILabel *missionid_Label;



@end

//
//  UITableViewCell+MissionViewCell.h
//  i-Tag_Provider
//
// Created by WENG Lili on 15/7/10
//

#import <UIKit/UIKit.h>

@interface MissionViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
//@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *picLabel;
@property (weak, nonatomic) IBOutlet UILabel *workerlvlLabel;

@property (weak, nonatomic) IBOutlet UILabel *Reward;
@property (weak, nonatomic) IBOutlet UILabel *Level;
@property (weak, nonatomic) IBOutlet UILabel *Pics;

@property (nonatomic,strong) NSString *PostID;
@end

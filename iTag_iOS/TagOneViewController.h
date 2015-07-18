//
//  TagOneViewController.h
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/12.

//

#import "WorkerMissionViewController.h"
#import "BButton.h"
//#import "MissionOneViewController.h"
NSString *transfered;

int counter1;

@interface TagOneViewController : WorkerMissionViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *ImageBorder;
@property (weak, nonatomic) IBOutlet UILabel *counter;

@property (nonatomic, strong) NSString *transfered;
@property (nonatomic, strong) NSString *q1;
@property (nonatomic, strong) NSString *q2;
@property (nonatomic, strong) NSString *q3;
@property (nonatomic, strong) NSString *q4;
@property (nonatomic, strong) NSString *transferedPosttype;
@property (nonatomic, strong) NSString *urltest;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, strong) NSArray *urlArray;
@property (nonatomic, strong) NSArray *ridArray;
@property (weak, nonatomic) IBOutlet UILabel *doneLabel;
@property (weak, nonatomic) IBOutlet UIButton *tag1;
@property (weak, nonatomic) IBOutlet UIButton *tag2;
@property (weak, nonatomic) IBOutlet UIButton *tag3;
@property (weak, nonatomic) IBOutlet UIButton *tag4;
@property (weak, nonatomic) IBOutlet BButton *backForP2;
@property (weak, nonatomic) IBOutlet BButton *backForP1;
@property (weak, nonatomic) IBOutlet BButton *backForP4;
@property (weak, nonatomic) IBOutlet UITextField *textFieldForP2;
@property (weak, nonatomic) IBOutlet UILabel *questionForP2;
@property (weak, nonatomic) IBOutlet UIButton *submitForP2;
@property (nonatomic, strong) NSString *transferedPostid1;
@property (nonatomic, strong) NSString *transferedPostType1;
@property (nonatomic, strong) NSString *transferedPostid2;
@property (nonatomic, strong) NSString *transferedPostType2;
@property (nonatomic, strong) NSString *transferedPostid3;
@property (nonatomic, strong) NSString *transferedPostType3;

@end

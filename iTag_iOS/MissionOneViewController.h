//
//  MissionOneViewController.h
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/10.

//

#import <UIKit/UIKit.h>
#import "BButton.h"
#import "NSString+FontAwesome.h"
#import "httpHelper.h"
#import "TagOneViewController.h"
#import "FavorViewController.h"


NSString *missionOneTitle;
NSString *missionOneUid;
NSString *missionOneDescription;
NSString *missionOneType;
NSString *missionTwoTitle;
NSString *missionTwoUid;
NSString *missionTwoDescription;
NSString *missionTwoType;
NSString *missionThreeTitle;
NSString *missionThreeUid;
NSString *missionThreeDescription;
NSString *missionThreeType;
NSString *missionOneType;
NSString *missionTwoType;
NSString *missionThreeType;
NSString *postid1;
NSString *postid2;
NSString *postid3;
NSString *transfer;



@interface MissionOneViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *Provider;
@property (weak, nonatomic) IBOutlet UILabel *Description;
@property (weak, nonatomic) IBOutlet UILabel *missionTwoTitle;
@property (weak, nonatomic) IBOutlet UILabel *missionTwoProvider;
@property (weak, nonatomic) IBOutlet UILabel *MissionTwoDescription;
@property (weak, nonatomic) IBOutlet UILabel *missionThreeTitle;
@property (weak, nonatomic) IBOutlet UILabel *missionThreeDescription;
@property (weak, nonatomic) IBOutlet UILabel *missionThreeProvider;
@property (weak, nonatomic) IBOutlet UILabel *type1;

@property (weak, nonatomic) IBOutlet UILabel *type2;
@property (weak, nonatomic) IBOutlet UILabel *type3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;

//@property (weak, nonatomic) IBOutlet BButton *start1;
@property (weak, nonatomic) IBOutlet BButton *start2;
@property (weak, nonatomic) IBOutlet BButton *start3;
@property (weak, nonatomic) IBOutlet UILabel *Reward;
@property (weak, nonatomic) IBOutlet UILabel *Pics;
@property (weak, nonatomic) IBOutlet UILabel *Level;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *level2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UILabel *pics2;
@property (weak, nonatomic) IBOutlet UILabel *reward2;
@property (weak, nonatomic) IBOutlet UILabel *Reward3;
@property (weak, nonatomic) IBOutlet UILabel *Pics3;
@property (weak, nonatomic) IBOutlet UILabel *Level3;
@property (weak, nonatomic) IBOutlet UILabel *budget1;
@property (weak, nonatomic) IBOutlet UILabel *budget2;
@property (weak, nonatomic) IBOutlet UILabel *budget3;
@property (weak, nonatomic) IBOutlet UILabel *PicNumber1;
@property (weak, nonatomic) IBOutlet UILabel *PicNumber2;
@property (weak, nonatomic) IBOutlet UILabel *PicNumber3;
@property (weak, nonatomic) IBOutlet UILabel *workerLevel1;
@property (weak, nonatomic) IBOutlet UILabel *workerLevel2;
@property (weak, nonatomic) IBOutlet UILabel *workerLevel3;


- (void)login_callBack:(id)value;
@end

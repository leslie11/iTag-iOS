//
//  FavorViewController.h
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/16.

//

#import "WorkerMissionViewController.h"
#import "TagOneViewController.h"

@interface FavorViewController : WorkerMissionViewController
@property (weak, nonatomic) IBOutlet UIButton *mission1;
@property (weak, nonatomic) IBOutlet UIButton *mission2;
@property (nonatomic, strong) NSString *transferedType1;
@property (nonatomic, strong) NSString *transferedCover1;
@property (nonatomic, strong) NSString *transferedType2;
@property (nonatomic, strong) NSString *transferedCover2;
@property (nonatomic, strong) NSString *transferedType3;
@property (nonatomic, strong) NSString *transferedCover3;
@property (nonatomic, strong) NSString *transferedFlag1;
@property (nonatomic, strong) NSString *transferedFlag2;
@property (nonatomic, strong) NSString *transferedFlag3;
@property (nonatomic, strong) NSString *transferedPostid1;
@property (nonatomic, strong) NSString *transferedPostType1;
@property (nonatomic, strong) NSString *transferedPostid2;
@property (nonatomic, strong) NSString *transferedPostType2;
@property (nonatomic, strong) NSString *transferedPostid3;
@property (nonatomic, strong) NSString *transferedPostType3;


@property (weak, nonatomic) IBOutlet UIButton *mission3;

@property (weak, nonatomic) IBOutlet UILabel *type1;
@property (weak, nonatomic) IBOutlet UILabel *type2;
@property (weak, nonatomic) IBOutlet UILabel *type3;


@end

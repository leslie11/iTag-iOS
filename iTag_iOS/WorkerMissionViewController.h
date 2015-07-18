//
//  WorkerMissionViewController.h
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/12.

//

#import "MyViewController.h"
#import "httpHelper.h"
#import <QuartzCore/QuartzCore.h>


@interface WorkerMissionViewController : MyViewController
@property (strong, nonatomic) IBOutlet UILabel *Title;

@property (weak, nonatomic) IBOutlet UILabel *border;
@property (weak, nonatomic) IBOutlet UILabel *border2;
@property (weak, nonatomic) IBOutlet UILabel *border3;

@end

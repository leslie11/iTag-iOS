//
//  FavorViewController.m
//  itagWorker
//
//  Created by Leslie-AIR on 15/7/16.

//

#import "FavorViewController.h"
#import "TagOneViewController.h"

@interface FavorViewController ()

@end

@implementation FavorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.type1.hidden = YES;
    self.type2.hidden = YES;
    self.mission1.hidden = YES;
    self.mission2.hidden = YES;
    self.type3.hidden = YES;
    self.mission3.hidden = YES;
    NSString *url1 = _transferedCover1;//[NSString stringWithFormat:@"%@/%@", urlPrefix1, cover1];
    //NSLog(@"%@",url1);
    NSURL *imageUrl = [NSURL URLWithString:url1];
    UIImage *image11 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    [self.mission1 setBackgroundImage:image11 forState:UIControlStateNormal];
    NSString *url2 = _transferedCover2;//[NSString stringWithFormat:@"%@/%@", urlPrefix1, cover1];
    //NSLog(@"%@",url1);
    NSURL *imageUrl2 = [NSURL URLWithString:url2];
    UIImage *image12 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl2]];
    [self.mission2 setBackgroundImage:image12 forState:UIControlStateNormal];
    NSString *url3 = _transferedCover3;//[NSString stringWithFormat:@"%@/%@", urlPrefix1, cover1];
    //NSLog(@"%@",url1);
    NSURL *imageUrl3 = [NSURL URLWithString:url3];
    UIImage *image13 = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl3]];
    [self.mission3 setBackgroundImage:image13 forState:UIControlStateNormal];
    
    if ([_transferedFlag1 isEqualToString:@"YES"]) {
        self.mission1.hidden = NO;
        self.type1.hidden = NO;
        self.type1.text = @"Classify";
    }
    if ([_transferedFlag2 isEqualToString:@"YES"]) {
        self.mission2.hidden = NO;
        self.type2.hidden = NO;
        self.type2.text = @"Tag";
    }
    if ([_transferedFlag3 isEqualToString:@"YES"]) {
        self.mission3.hidden = NO;
        self.type3.hidden = NO;
        self.type3.text = @"Answer";
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"favorToTag1"]) {
//        NSLog(@"prepare to transfer %@",postid1);
        TagOneViewController *destViewController = segue.destinationViewController;
        destViewController.transfered = _transferedPostid1;
        destViewController.transferedPosttype = _transferedPostType1;
        
        
    }
    if ([segue.identifier isEqualToString:@"favorToTag2"]) {
        //        NSLog(@"prepare to transfer %@",postid1);
        TagOneViewController *destViewController = segue.destinationViewController;
        destViewController.transfered = _transferedPostid2;
        destViewController.transferedPosttype = _transferedPostType2;
        
    }
    if ([segue.identifier isEqualToString:@"favorToTag3"]) {
        //        NSLog(@"prepare to transfer %@",postid1);
        TagOneViewController *destViewController = segue.destinationViewController;
        destViewController.transfered = _transferedPostid3;
        destViewController.transferedPosttype = _transferedPostType3;
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

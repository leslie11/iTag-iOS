//
//  UIViewController+UploadViewController.m
//  i-Tag_Provider
//
// Created by WENG Lilion 15/7/13.
// Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import "UploadViewController.h"

#import "P1ViewController.h"
#import "P2ViewController.h"
#import "P3ViewController.h"
#import "P4ViewController.h"

@interface UploadViewController ()

@property (nonatomic, strong) NSMutableArray *imageDataArray;

@end

@implementation UploadViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg1.png"] ];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismiss)];
    
    _uploadButton.buttonColor = [UIColor peterRiverColor];//turquoiseColor,wisteriaColor
    _uploadButton.shadowColor = [UIColor belizeHoleColor];//cloudsColor
    _uploadButton.shadowHeight = 3.0f;
    _uploadButton.cornerRadius = 6.0f;
    _uploadButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [_uploadButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [_uploadButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.imageDataArray = [NSMutableArray array];
    
    NSLog(@"PostID: %@",_PostID);
    NSLog(@"UserID: %@",_UserID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonItemToDismiss{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)uploadImage:(id)sender {
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = 6;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    NSLog(@"Selected assets:");
    NSLog(@"%@", assets);
    PHImageManager *imageManager = [PHImageManager new];
    
    for (PHAsset *asset in assets) {
        [imageManager requestImageDataForAsset:asset
                                       options:0
                                 resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                                     UIImage *originalImage = [UIImage imageWithData:imageData];
                                     
                                     // Do something with image 得到图片的缓存数据
                                     NSData * imagedata = UIImageJPEGRepresentation([originalImage imageByScalingAndCroppingForSize:CGSizeMake(originalImage.size.width, originalImage.size.height)], 0.5);
                                     static int index = 1;
                                     NSString * newImageName = [NSString stringWithFormat:@"%d.jpg", index];
                                     NSString  *jpgPath = NSHomeDirectory();
                                     jpgPath = [jpgPath stringByAppendingPathComponent:@"Documents"];
                                     jpgPath = [jpgPath stringByAppendingPathComponent:newImageName];
                                     [imagedata writeToFile:jpgPath atomically:YES];
                                     
                                     [self.imageDataArray addObject:imagedata];
                                     index ++ ;
                                 }];
    }
    [self uploadImagetoServer];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Canceled.");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) uploadImagetoServer
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //需要上传服务器的参数
    [parameters setValue:_PostID forKey:@"PostID"];
    [parameters setValue:@"uploadImage" forKey:@"function"];
    [parameters setValue:_UserID forKey:@"UserID"];
    NSString *url = @"http://147.8.138.16:8080/ios/";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    /**
     *  post : 上传的网址
     *
     *  parameters 服务器需要上传的参数
     *
     */
    //[manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        /*   参数说明：
         1. fileData:   要上传文件的数据
         2. name:       负责上传文件的远程服务中接收文件使用的字段名称
         3. fileName：   要上传文件的文件名
         4. mimeType：   要上传文件的文件类型
         */
        // 1) 取当前系统时间
        NSDate *date = [NSDate date];
        // 2) 使用日期格式化工具
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        // 3) 指定日期格式
        [formatter setDateFormat:@"yyyy_MM_dd_"];
        NSString *dateStr = [formatter stringFromDate:date];
        
        for (int i = 0; i < _imageDataArray.count; i++) {
            NSData * imageData = [self.imageDataArray objectAtIndex: i];
            // 4) 使用系统时间生成一个文件名
            NSString *Name = [NSString stringWithFormat:@"%@%d", dateStr,i + 1];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            [formData appendPartWithFileData:imageData name:@"Files" fileName:fileName mimeType:@"image/jpg"];
        }
    }success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Success: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender
{
    NSLog(@"prepare segue");
    if ([[segue identifier] isEqualToString:@"P1Segue"]) {
        P1ViewController *vc = (P1ViewController *)[[segue destinationViewController] topViewController];
        vc.PostID = _PostID;
        vc.userID = _UserID;
    }
    if ([[segue identifier] isEqualToString:@"P2Segue"]) {
        P2ViewController *vc = (P2ViewController *)[[segue destinationViewController] topViewController];
        vc.PostID = _PostID;
        vc.userID = _UserID;
    }
    if ([[segue identifier] isEqualToString:@"P3Segue"]) {
        P3ViewController *vc = (P3ViewController *)[[segue destinationViewController] topViewController];
        vc.PostID = _PostID;
        vc.userID = _UserID;
    }
    if ([[segue identifier] isEqualToString:@"P4Segue"]) {
        P4ViewController *vc = (P4ViewController *)[[segue destinationViewController] topViewController];
        vc.PostID = _PostID;
        vc.userID = _UserID;
    }
}

@end

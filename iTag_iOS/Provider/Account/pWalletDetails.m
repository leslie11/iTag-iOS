//
//  UITableViewController+WalletDetails.m
//  myaccount
//
//  Created by WENG Lili on 9/7/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//

#import "pWalletDetails.h"
#import "pTransactionTableviewCell.h"
#import "pTransaction.h"
#import "HttpHelper.h"


Transaction *transaction;
NSString *test1;
NSString *test2;
NSString *test3;
NSString *test4;


@implementation WalletDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonItemToDismiss)];
     _transactionList = [[NSMutableArray alloc] init];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];



    
    
    [self getData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonItemToDismiss{
    NSLog(@"Back");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"row: %ld", (long)indexPath.row);
    TransactionTableviewCell *cell = (TransactionTableviewCell *)[tableView dequeueReusableCellWithIdentifier:@"transactionCell"];
    Transaction *transaction = (self.transactionList)[indexPath.row];
    cell.target_Label.text = transaction.poster_id;
    cell.time_Label.text = transaction.amount;
    cell.amount_Label.text = transaction.created_time;
    cell.type_Label.text = transaction.type;
    
    if([transaction.type isEqualToString:@"Earning"]){
        cell.amount_Label.textColor = [UIColor colorWithRed:(30/255.f) green:(180/255.f) blue:(150/255.f) alpha:1];
        cell.type_Label.textColor = [UIColor colorWithRed:(30/255.f) green:(180/255.f) blue:(150/255.f) alpha:1];
    }else{
        cell.amount_Label.textColor = [UIColor redColor];
        cell.type_Label.textColor = [UIColor redColor];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.transactionList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void) getData
{
    NSString *url = @"http://147.8.138.16:8080/ios/";
    NSString *function = @"wallet";
    NSString *uid = @"2";
    NSLog(@"Login Test");
    
    //加入参数
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:function forKey:@"function"];
    [params setValue:uid forKey:@"uid"];
    
    //有网络才发送请求
    if([HttpHelper NetWorkIsOK]){
        
        [HttpHelper post:url RequestParams:params FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {//传回来的数据存在，则执行改回调函数
            if(data){
                //子线程通知主线程更新UI，selector中是要执行的函数，data是传给这个函数的参数
                //login_callBack就处理返回来的消息，这里就简单的输出，登录成功
                
                
                NSError *error = nil;
                NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
    
                for(NSDictionary *jsonParsed in jsonArray) {
                    Transaction *transaction = [[Transaction alloc] init];
                    transaction.poster_id = jsonParsed[@"missionid"];
                    transaction.created_time = jsonParsed[@"settletime"];
                    transaction.amount = jsonParsed[@"amount"];
                    transaction.type = jsonParsed[@"transaction_type"];
                    [self.transactionList addObject:transaction];
//                    test1 = jsonParsed[@"missionid"];
//                    test2 = jsonParsed[@"settletime"];
//                    test3 = jsonParsed[@"amount"];
//                    test4 = jsonParsed[@"transaction_type"];
//                    NSLog(@"%@",test1);
                    

                }
                
                NSLog(@"response = %@",jsonArray);
                
                
                NSLog(uid);
                
                [self.tableView reloadData];

            [self performSelectorOnMainThread:@selector(login_callBack:) withObject:data waitUntilDone:YES];    
            }
            else{
                NSLog(@"Invalid Data");
            }
        }];
    }
}

- (void)login_callBack:(id)value{
    NSLog(@"Login Successed");
//    Transaction *transaction = [[Transaction alloc] init];
//    transaction.poster_id = test1;
//    transaction.created_time = test2;
//    transaction.amount = test3;
//    transaction.type = test4;
//    [self.transactionList addObject:transaction];
    [self.tableView reloadData];

}


@end

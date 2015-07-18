//
//  Transaction.h
//  myaccount
//
//  Created by WENG Lili on 9/7/15.
//  Copyright (c) 2015 WENG Lili. All rights reserved.
//
#import "UIKit/UIKit.h"

@interface Transaction : NSObject

@property (nonatomic, copy) NSString *poster_id;
@property (nonatomic, copy) NSString *worker_id;
@property (nonatomic, copy) NSString *transaction_id;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *resource_id;
@property (nonatomic, copy) NSString *created_time;
@property (nonatomic, copy) NSString *type;





@end
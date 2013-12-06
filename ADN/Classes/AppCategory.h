//
//  Category.h
//  ADN
//
//  Created by Le Ngoc Duy on 11/20/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCategory : NSObject
@property (nonatomic, strong) NSNumber *cat_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *update_date;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) id banner;
@end

//
//  Apprecord.h
//  ADN
//
//  Created by Dao Pham Hoang Duy on 11/20/13.
//  Copyright (c) 2013 Le Ngoc Duy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apprecord : NSObject
@property (strong, nonatomic) NSString *app_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *official_link;
@property (strong, nonatomic) NSNumber *cat_id;
@property (strong, nonatomic) NSString *cat_n;
@property (strong, nonatomic) NSString *cat_name;
@property (strong, nonatomic) NSString *dev_n;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *ver_n;
@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *downloads;
@property (strong, nonatomic) NSString *rate;
@property (strong, nonatomic) NSString *rate_c;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *date_add;
@property (strong, nonatomic) NSString *package;
@property (strong, nonatomic) NSString *src;
@property (strong, nonatomic) NSString *d_src;
@property (strong, nonatomic) NSString *d_size;
@property (strong, nonatomic) NSString *d_folder;
@property (strong, nonatomic) NSString *ver_c;
//property get at detail app record
@property (strong, nonatomic) NSString *trailer;
@property (strong, nonatomic) id ratings;
@property (strong, nonatomic) id images;
@property (strong, nonatomic) NSString *des;
@end

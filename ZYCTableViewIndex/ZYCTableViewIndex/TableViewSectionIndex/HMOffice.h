//
//  HMOffice.h
//  HospitalMedical
//
//  Created by 赵永昌 on 2017/5/10.
//  Copyright © 2017年 chengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMOffice : NSObject

@property (nonatomic,copy)    NSString *letter;
@property (nonatomic,strong)  NSMutableArray *kindArray;

@end

@interface HMKindOffice : NSObject

@property (nonatomic,copy) NSString *officeId;
@property (nonatomic,copy) NSString *officename;
@property (nonatomic,copy) NSString *officeDescription;

+ (HMKindOffice *)kindOfficeWithDictionary:(NSDictionary *)dictionary;
- (void)kindOfficeWithDictionary:(NSDictionary *)dic;


+ (HMKindOffice *)kindOfficeWithId:(NSString *)officeId officeName:(NSString *)name officeDes:(NSString *)description;


@end

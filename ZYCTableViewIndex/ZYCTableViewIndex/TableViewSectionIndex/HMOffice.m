//
//  HMOffice.m
//  HospitalMedical
//
//  Created by 赵永昌 on 2017/5/10.
//  Copyright © 2017年 chengzhen. All rights reserved.
//

#import "HMOffice.h"

@implementation HMOffice


@end






@implementation HMKindOffice

+ (HMKindOffice *)kindOfficeWithDictionary:(NSDictionary *)dictionary
{
    HMKindOffice *office = [[HMKindOffice alloc] init];
    [office kindOfficeWithDictionary:dictionary];
    return office;
}
- (void)kindOfficeWithDictionary:(NSDictionary *)dic
{
    if (dic[@"id"] && ![dic[@"id"] isKindOfClass:[NSNull class]]) {
        self.officeId = [NSString stringWithFormat:@"%@",dic[@"id"]];
    }
    //
    if (dic[@"name"] && ![dic[@"name"] isKindOfClass:[NSNull class]]) {
        self.officename = [NSString stringWithFormat:@"%@",dic[@"name"]];
    }
    //
    if (dic[@"describ"] && ![dic[@"describ"] isKindOfClass:[NSNull class]]) {
        self.officeDescription = [NSString stringWithFormat:@"%@",dic[@"describ"]];
    }
}

+ (HMKindOffice *)kindOfficeWithId:(NSString *)officeId officeName:(NSString *)name officeDes:(NSString *)description
{
    HMKindOffice *office = [[HMKindOffice alloc] init];
    office.officeId = officeId;
    office.officename = name;
    office.officeDescription = description;
    return office;
}

@end

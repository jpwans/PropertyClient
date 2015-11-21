//
//  ResponeBase.m
//  UnisouthParents
//
//  Created by neo on 14-3-25.
//  Copyright (c) 2014年 unisouth. All rights reserved.
//

#import "ResponeBase.h"
#import "TestBean.h"
//#import "Contact.h"




@implementation ResponeBase





- (NSDictionary *)objectClassInArrayOneOfMany:(NSString*)classNameOneOfMany
{
    NSDictionary *dicClass = @{@"TestBean" : [TestBean class]};
    Class objectClass = [dicClass objectForKey:classNameOneOfMany];
    return @{@"data" : objectClass};
}


- (NSDictionary *)objectClassInArray
{
      
      return @{@"data" : [TestBean class]};
}



@end

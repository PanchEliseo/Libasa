//
//  LManagedObject.m
//  Libasa
//
//  Created by Carlos molina on 16/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LManagedObject.h"

@implementation LManagedObject

+ (instancetype)sharedInstance
{
    static LManagedObject * shared = nil;
    if (!shared)
    {
        
        shared = [[self alloc] initPrivate];
    }
    //    if(![NSThread isMainThread])
    //    {
    //
    //        [shared sendException];
    //    }
    return shared;
}

- (instancetype)initPrivate
{
    self = [super init];
    return self;
}

@end
//
//  EDownladServiceManager.h
//  Equipos
//
//  Created by Carlos molina on 09/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EServiceObject;

typedef enum
{
    SSServiceLogin = 0,
    
} SSServices;

@interface EDownloadServiceManager : NSObject
+ (instancetype)sharedInstance;
- (void)downloadJsonPOSTWithServiceObject:(EServiceObject *)object;
- (void)downloadJsonGETWithServiceObject:(EServiceObject *)object;
@end
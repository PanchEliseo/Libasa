//
//  EServiceObject.h
//  Equipos
//
//  Created by Carlos molina on 09/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDownladServiceManager.h"

typedef enum
{
    EServicePetitionGET = 0,
    EServicePetitionPOST,
    
    
} SSServicePetition;

typedef void(^SSServiceObjectBlock)(NSDictionary * json, NSError * error);
@interface EServiceObject : NSObject

@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSMutableDictionary * jsonRequest;
@property (nonatomic) SSServicePetition typePetition;
@property (nonatomic) SSServices typeService;
@property (strong, nonatomic) NSURL * urlService;
@property (nonatomic, copy) SSServiceObjectBlock customBlock;
- (void)startDownload;
- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error;

- (NSDate *)dateFromJsonString: (NSString *) dateString;

@end

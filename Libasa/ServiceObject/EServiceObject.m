//
//  EServiceObject.m
//  Equipos
//
//  Created by Carlos molina on 09/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EServiceObject.h"
#import "EDownladServiceManager.h"

@implementation EServiceObject

- (NSURL *)urlService
{
    if (!_urlService)
    {
        _urlService = [[NSURL alloc] init];
    }
    return _urlService;
}

- (NSString *)url
{
    if (!_url)
    {
        _url = [[NSString alloc] init];
    }
    return _url;
}

- (void)startDownload
{
    if (self.typePetition == EServicePetitionPOST)
    {
        [[EDownloadServiceManager sharedInstance] downloadJsonPOSTWithServiceObject:self];
    }
    else
    {
        [[EDownloadServiceManager sharedInstance] downloadJsonGETWithServiceObject:self];
    }
}

- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error
{
    if (error)
    {
        self.customBlock(nil, error);
    }
    else
    {
        NSLog(@"super");
    }
}

- (NSDate *) dateFromJsonString: (NSString *) dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [dateFormatter dateFromString:dateString];
    return date;
    
}

@end
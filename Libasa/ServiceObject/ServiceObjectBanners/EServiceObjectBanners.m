//
//  EServiceObjectBanners.m
//  Equipos
//
//  Created by Carlos molina on 09/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EServiceObjectBanners.h"

@implementation EServiceObjectBanners

- (id)initDownload{
    self = [super init];
    if (self)
    {
        NSString *url = @"http://sicksadworld.com.mx/libasa_ligas_deportivas/servicios/banners.php";
        self.urlService = [NSURL URLWithString:url];
        //self.jsonRequest = [self createJsonPostUser: usuario];
        self.typePetition = EServicePetitionGET;
        //self.typeService = SSServiceLogin;
        
    }
    return self;
}

- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;
{
    self.customBlock = block;
    [super startDownload];
    
}

- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^
     {
         self.customBlock(json,error);
         
     }];
    
}

@end
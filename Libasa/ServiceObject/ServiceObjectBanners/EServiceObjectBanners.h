//
//  EServiceObjectBanners.h
//  Equipos
//
//  Created by Carlos molina on 09/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EServiceobject.h"

@interface EServiceObjectBanners : EServiceObject

- (id)initDownload;
- (void)startDownloadWithCompletionBlock:(void (^) (NSDictionary * response, NSError * error))block;

@end
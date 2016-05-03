//
//  LUtils.h
//  Libasa
//
//  Created by Francisco Hernandez on 02/05/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PQFCustomLoaders.h"

@interface LUtils : NSObject

- (void)setTitleText:(NSString *) title viewController:(UIViewController*)viewController;
- (UIViewController *) viewControllerForStoryBoardName:(NSString *) storyBoardName;
- (PQFBouncingBalls *) showLoader:(UIView *)view loader:(PQFBouncingBalls *)loader;

@end

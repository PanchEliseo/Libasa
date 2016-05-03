//
//  LUtils.m
//  Libasa
//
//  Created by Francisco Hernandez on 02/05/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUtils.h"

@implementation LUtils

//metodo que le coloca texto a los controladores
- (void)setTitleText:(NSString *) title viewController:(UIViewController*)viewController
{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    view.text = title;
    view.textColor = [UIColor blackColor];
    view.textAlignment = NSTextAlignmentCenter;
    view.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    viewController.navigationItem.titleView = view;
    
}

- (UIViewController *) viewControllerForStoryBoardName:(NSString *) storyBoardName
{
    UIStoryboard * story = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    return [story instantiateInitialViewController];
}

- (PQFBouncingBalls *) showLoader:(UIView *)view loader:(PQFBouncingBalls *)loader{
    
    loader = [PQFBouncingBalls createLoaderOnView:view];
    loader.jumpAmount = 50;
    loader.zoomAmount = 50;
    loader.loaderColor = [UIColor blueColor];
    [loader showLoader];
    return loader;
    
}

@end
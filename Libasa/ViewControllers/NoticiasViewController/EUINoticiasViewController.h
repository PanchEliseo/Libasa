//
//  EUINoticiasViewController.h
//  Equipos
//
//  Created by Carlos molina on 07/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface EUINoticiasViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UICollectionView *carouselCollection;
@property (weak, nonatomic) IBOutlet UIView *viewCarousel;

@end

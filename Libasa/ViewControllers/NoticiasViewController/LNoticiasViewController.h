//
//  LNoticiasViewController.h
//  Equipos
//
//  Created by Control-z on 07/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNoticiasViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UICollectionView *carouselCollection;
@property (weak, nonatomic) IBOutlet UIView *viewCarousel;
@property (weak, nonatomic) IBOutlet UICollectionView *noticiasCollectionView;

@end

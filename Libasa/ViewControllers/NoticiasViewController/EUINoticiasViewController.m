//
//  EUINoticiasViewController.m
//  Equipos
//
//  Created by Carlos molina on 07/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EUINoticiasViewController.h"
#import "EUICellNoticias.h"
#import "EServiceObjectBanners.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"

@interface EUINoticiasViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray * arrayImages;
@property (nonatomic, strong) NSMutableArray * arrayImagenesNoticias;
@end

@implementation EUINoticiasViewController

- (NSMutableArray *)arrayImages:(NSString *)urlImage{
    if(!_arrayImages){
        //_arrayImages = [[NSMutableArray alloc] initWithObjects:@"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", nil];
        //_arrayImages = [[NSMutableArray alloc] initWithObjects:@"fondo.png", @"fondo.png", @"fondo.png", @"fondo.png", @"fondo.png", @"fondo.png", @"fondo.png", @"fondo.png", @"fondo.png", @"fondo.png", nil];
        _arrayImages = [[NSMutableArray alloc] init];
    }
    if (![urlImage isEqualToString:@""]) {
        [_arrayImages addObject:urlImage];
    }
    return _arrayImages;
}

- (NSMutableArray *)arrayImagenesNoticias{
    if (!_arrayImagenesNoticias){
        _arrayImagenesNoticias = [[NSMutableArray alloc] initWithObjects:@"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", @"page.png", nil];
    }
    return _arrayImagenesNoticias;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.carouselCollection.delegate = self;
    self.carouselCollection.dataSource = self;
    EServiceObjectBanners * service = [[EServiceObjectBanners alloc] initDownload];
    [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
        for(int cont = 0; cont < [response[keyJsonBanners] count]; cont++){
            NSLog(@"la respuesta del json %@", [[response[keyJsonBanners] objectAtIndex:cont] objectForKey:keyJsonImgPreview]);
            [self arrayImages:[[response[keyJsonBanners] objectAtIndex:cont] objectForKey:keyJsonImgPreview]];
            [self.carouselCollection reloadData];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CollectionView methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.carouselCollection == collectionView)
        return [self arrayImages:@""].count;
    else
        return [self arrayImagenesNoticias].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //se crea un identificador
    if(self.carouselCollection == collectionView){
        static NSString *identifier = @"EUICellCarousel";
        EUICellNoticias *cell = (EUICellNoticias *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        NSLog(@"la url %@", [[self arrayImages:@""] objectAtIndex:indexPath.row]);
        NSString * direccion = @"www.sicksadworld.com.mx/libasa_ligas_deportivas/uploads/noticias/multimedia/page.png";
        direccion = [direccion stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:direccion];
        [cell.imageCarousel sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"error %@", error);
        }];
        return cell;
    }else{
        static NSString *identifier = @"EUICellNoticias";
        EUICellNoticias *cell = (EUICellNoticias *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.imageViewCell.image = [UIImage imageNamed:[[self arrayImagenesNoticias] objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.carouselCollection == collectionView){
        NSLog(@"el seleccionado en el carousel %ld", (long)indexPath.row);
    }else{
        NSLog(@"el seleccionado en el collection %ld", (long)indexPath.row);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(self.carouselCollection != collectionView)
        return 50.0;
    else
        return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:
(NSIndexPath *)indexPath{
    if(self.carouselCollection == collectionView){
        return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height - 64);
    }else{
        CGFloat heightCell = collectionView.frame.size.height / 2;
        return CGSizeMake(self.view.frame.size.width, heightCell);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.carouselCollection == scrollView){
        CGPoint scrollVelocity = [self.carouselCollection.panGestureRecognizer
                                  velocityInView:self.carouselCollection.superview];
        CGFloat x = scrollView.contentOffset.x;
        CGFloat widthCell = self.carouselCollection.frame.size.width;
        double index = 0.0;
        if(scrollVelocity.x > 0.0f){
            //NSLog(@"scroll right");
            index = floor(x / widthCell);
            //NSLog(@"el index r %f", index);
            if(index == 0){
                NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                [self.carouselCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
        }else if(scrollVelocity.x < 0.0f){
            //NSLog(@"scroll left");
            index = ceil(x / widthCell);
            //NSLog(@"el index l %f", index);
        }
        if(index > 0 && index < self.arrayImages.count){
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [self.carouselCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

@end
//
//  EUINoticiasViewController.m
//  Equipos
//
//  Created by Carlos molina on 07/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNoticiasViewController.h"
#import "EUICellNoticias.h"
#import "LServiceObjectNoticias.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"
#import "LUtils.h"
#import "LDetalleNoticiasViewController.h"
#import <PQFCustomLoaders/PQFCustomLoaders.h>
#import "LManagedObject.h"
#import "Noticias.h"
#import "UIViewController+ECSlidingViewController.h"

@interface LNoticiasViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) BOOL wrap;
@property (strong, nonatomic) NSMutableArray * arrayBanners;
@property (nonatomic, strong) NSMutableArray * arrayNoticias;
@property (nonatomic, strong) PQFBouncingBalls *bouncingBalls;
@property () BOOL flagBanner;
@property () BOOL flagNoticia;
@property (nonatomic, strong) LUtils *utils;
@end

@implementation LNoticiasViewController

- (NSMutableArray *)arrayBanners:(Noticias *)noticia{
    if (!_arrayBanners) {
        _arrayBanners = [[NSMutableArray alloc] init];
    }
    if (noticia) {
        [_arrayBanners addObject:noticia];
    }
    return _arrayBanners;
}

//arreglo que contiene la informacion necesaria del json de noticias
- (NSMutableArray *)arrayNoticias:(Noticias *)noticia{
    if (!_arrayNoticias){
        _arrayNoticias = [[NSMutableArray alloc] init];
    }
    if(noticia){
        [_arrayNoticias addObject:noticia];
    }
    return _arrayNoticias;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //LContainerViewController * container = [[LContainerViewController alloc] init];
    NSLog(@"a ver que trae %@", self.parentViewController.parentViewController);
    self.navigationItem.leftBarButtonItem = [self addLeftBarButton];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.carouselCollection.delegate = self;
    self.carouselCollection.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.utils = [[LUtils alloc] init];
    //LContainerViewController * container = [[LContainerViewController alloc] init];
    self.bouncingBalls = [self.utils showLoader:self.view loader:self.bouncingBalls];
    //primero se le agrega una imagen al banner para que muestre una en lo que se hace la descarga
    Noticias * noticia = [[Noticias alloc] init];
    noticia.img_preview = @"fondo.png";
    [self arrayBanners:noticia];
    self.flagBanner = YES;
    LServiceObjectNoticias * service = [[LServiceObjectNoticias alloc] initDownload];
    [service startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
        self.arrayBanners = nil;
        self.flagBanner = NO;
        for(int cont = 0; cont < [response[keyJsonBanners] count]; cont++){
            [self parseJSON:[response[keyJsonBanners] objectAtIndex:cont] tipo:@"banner"];
            [self.carouselCollection reloadData];
        }
    }];
    Noticias * note = [[Noticias alloc] init];
    note.img_preview = @"fondo.png";
    [self arrayNoticias:noticia];
    [self arrayNoticias:note];
    self.flagNoticia = YES;
    LServiceObjectNoticias * serviceNoticias = [[LServiceObjectNoticias alloc] initDownloadNoticias];
    [serviceNoticias startDownloadWithCompletionBlock:^(NSDictionary *response, NSError *error) {
        self.arrayNoticias = nil;
        self.flagNoticia = NO;
        for(int cont = 0; cont < [response[keyJsonBanners] count]; cont++){
            [self parseJSON:[response[keyJsonBanners] objectAtIndex:cont] tipo:@"noticia"];
            [self.noticiasCollectionView reloadData];
        }
        [self.bouncingBalls removeLoader];
    }];
    [self.utils setTitleText:@"Noticias" viewController:self];
    
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
        return [self arrayBanners:nil].count;
    else
        return [self arrayNoticias:nil].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //se crea un identificador
    if(self.carouselCollection == collectionView){
        static NSString *identifier = @"EUICellCarousel";
        EUICellNoticias *cell = (EUICellNoticias *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if(self.flagBanner){
            Noticias * noticia = [[self arrayBanners:nil] objectAtIndex:indexPath.row];
            
            cell.imageCarousel.image = [UIImage imageNamed:noticia.img_preview];
        }else{
            Noticias * noticia = [[self arrayBanners:nil] objectAtIndex:indexPath.row];
            NSString * direccion = noticia.img_preview;
            NSString * urlImage = [NSString stringWithFormat:@"%@%@", keyHttp, direccion];
            //urlImage = [urlImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlImage];
            NSLog(@"la url %@", url);
            [cell.imageCarousel sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"error %@", error);
            }];
            cell.celdaDescripcion.text = noticia.titulo;
        }
        return cell;
    }else{
        static NSString *identifier = @"EUICellNoticias";
        EUICellNoticias *cell = (EUICellNoticias *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //cell.imageViewCell.image = [UIImage imageNamed:[[self arrayImagenesNoticias:@""] objectAtIndex:indexPath.row]];
        if(self.flagNoticia){
            Noticias * noticia = [[self arrayNoticias:nil] objectAtIndex:indexPath.row];
            cell.imageViewCell.image = [UIImage imageNamed:noticia.img_preview];
        }else{
            Noticias * noticia = [[self arrayNoticias:nil] objectAtIndex:indexPath.row];
            NSString * direccion = noticia.img_preview;
            NSString * urlImage = [NSString stringWithFormat:@"%@%@", keyHttp, direccion];
            //urlImage = [urlImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:urlImage];
            [cell.imageViewCell sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"error %@", error);
            }];
            cell.celdaTituloNoticias.text = noticia.titulo;
        }
        return cell;
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDetalleNoticiasViewController * vc = (LDetalleNoticiasViewController *)[self.utils viewControllerForStoryBoardName:@"DetalleNoticia"];
    Noticias * noticia;
    if (self.carouselCollection == collectionView)
        noticia = [[self arrayBanners:nil] objectAtIndex:indexPath.row];
    else
        noticia = [[self arrayNoticias:nil] objectAtIndex:indexPath.row];
    vc.noticia = noticia;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(self.carouselCollection != collectionView)
        return 0.0;
    else
        return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:
(NSIndexPath *)indexPath{
    if(self.carouselCollection == collectionView){
        return CGSizeMake(collectionView.frame.size.width, self.carouselCollection.frame.size.height);
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
        if(index > 0 && index < [self arrayBanners:nil].count){
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [self.carouselCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

- (void) parseJSON:(NSDictionary *)json tipo:(NSString *)tipo{
    Noticias * noticia = [[Noticias alloc] init];
    noticia.idNoticia = [json objectForKey:keyJsonId];
    noticia.titulo = [json objectForKey:keyJsonTitulo];
    noticia.nota = [json objectForKey:keyJsonNota];
    noticia.descripcion = [json objectForKey:keyJsonDescripcion];
    noticia.short_descripcion = [json objectForKey:keyJsonShortDescription];
    noticia.fecha = [json objectForKey:keyJsonFecha];
    noticia.img_preview = [json objectForKey:keyJsonImgPreview];
    noticia.tipo_multimedia = [json objectForKey:keyJsonTipoMultimedia];
    noticia.multimedia = [json objectForKey:keyJsonMultimedia];
    [tipo isEqualToString:@"banner"] ? [self arrayBanners:noticia] : [self arrayNoticias:noticia];
}

- (UIBarButtonItem *) addLeftBarButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIImage *background = [UIImage imageNamed:@"icon_menu"];
    [button setBackgroundImage:background forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    barButton.tintColor = [UIColor blueColor];
    
    return barButton;
}

- (void)openMenu
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered)
    {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
    else
    {
        [self.slidingViewController resetTopViewAnimated:YES];
    }
}

@end
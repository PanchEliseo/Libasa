//
//  LDetalleNoticiasViewController.m
//  Libasa
//
//  Created by Control-z on 16/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDetalleNoticiasViewController.h"
#import "EUICellNoticias.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "LCellDescripcionNoticia.h"

@interface LDetalleNoticiasViewController()

@property (strong, nonatomic) NSMutableArray * arrayNoticias;
@property (strong, nonatomic) NSMutableArray * arrayDetalleNoticia;

@end

@implementation LDetalleNoticiasViewController

//aqui se llena el arreglo que tendra las imagenes de las noticias
- (NSMutableArray *)arrayNoticias{
    if (!_arrayNoticias){
        //se inicializa el arreglo
        _arrayNoticias = [[NSMutableArray alloc] init];
        //se recorre la entidad que tiene los datos de las imagenes que se mostraran en el carrucel
        for(int cont = 0; cont < [self.noticia.multimedia count]; cont++){
            [_arrayNoticias addObject:[[self.noticia.multimedia objectAtIndex:cont] objectForKey:@"url"]];
        }
    }
    return _arrayNoticias;
}

- (NSMutableArray *)arrayDetalleNoticia{
    if (!_arrayDetalleNoticia) {
        _arrayDetalleNoticia = [[NSMutableArray alloc] initWithObjects:self.noticia.nota, nil];
        //_arrayNoticias = [[NSMutableArray alloc] init];
        //[_arrayNoticias addObject:self.noticia.descripcion];
    }
    return  _arrayDetalleNoticia;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.textoDescripcion.text = self.noticia.nota;
    
    //self.tableView.delegate = self;
    //self.tableView.dataSource = self;
    //UIScrollView *myScroll = [[UIScrollView alloc] init];
    //self.scrollView.frame = self.view.bounds; //scroll view occupies full parent view!
    //specify CGRect bounds in place of self.view.bounds to make it as a portion of parent view!
    
    //self.scrollView.contentSize = CGSizeMake(800, 800);   //scroll view size
    
    //self.scrollView.backgroundColor = [UIColor grayColor];
    
    //self.scrollView.showsVerticalScrollIndicator = YES;    // to hide scroll indicators!
    
    //self.scrollView.showsHorizontalScrollIndicator = YES; //by default, it shows!
    
    //self.scrollView.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    //[self.viewDetalle addSubview:myScroll];
    //[myScroll addSubview:self.textoDescripcion];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.constanteHeight.constant = 0;
    self.textoDescripcion.text = self.noticia.nota;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma CollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self arrayNoticias].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"EUICellNoticias";
    EUICellNoticias *cell = (EUICellNoticias *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //se obtiene la imagen del arreglo
    NSString * direccion = [[self arrayNoticias] objectAtIndex:indexPath.row];
    NSString * urlImage = [NSString stringWithFormat:@"%@%@", keyHttp, direccion];
    //urlImage = [urlImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlImage];
    NSLog(@"la url %@", url);
    //se utiliza la clase para descargar la imagen de internet y colocarla en el imageVIew
    [cell.imageViewCell sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"error %@", error);
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:
(NSIndexPath *)indexPath{
    //el error de constraints que aparece en consola es por la altura de la celda del collection, si se le restan 70, deja de de mostrar el error
    return CGSizeMake(collectionView.frame.size.width, self.collectionView.frame.size.height - 64);
    //return collectionView.frame.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint scrollVelocity = [self.collectionView.panGestureRecognizer
                              velocityInView:self.collectionView.superview];
    CGFloat x = scrollView.contentOffset.x;
    CGFloat widthCell = self.collectionView.frame.size.width;
    double index = 0.0;
    if(scrollVelocity.x > 0.0f){
        //NSLog(@"scroll right");
        index = floor(x / widthCell);
        //NSLog(@"el index r %f", index);
        if(index == 0){
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }else if(scrollVelocity.x < 0.0f){
        //NSLog(@"scroll left");
        index = ceil(x / widthCell);
        //NSLog(@"el index l %f", index);
    }
    if(index > 0 && index < [self arrayNoticias].count){
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

#pragma TableView
/*-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self arrayDetalleNoticia].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdasProductos"];
    LCellDescripcionNoticia *cell = [tableView dequeueReusableCellWithIdentifier:@"LCellDescripcionNoticia"];
    
    if(cell == nil){
        //cell = [[UISeleccionadorProductosPlanos alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celdasProductos"];
        [tableView registerNib:[UINib nibWithNibName:@"LCellDescripcionNoticia" bundle:nil] forCellReuseIdentifier:@"LCellDescripcionNoticia"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"LCellDescripcionNoticia"];
    }
    //cell.text.text = [self.array objectAtIndex:indexPath.row];
    //cell.image.image = [UIImage imageNamed:[self.arrayImage objectAtIndex:indexPath.row]];
    cell.textDescription.text = [[self arrayDetalleNoticia] objectAtIndex:indexPath.row];
    
    return cell;
    
    //return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.frame.size.height;
}*/

@end

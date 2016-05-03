//
//  LDetalleNoticiasViewController.h
//  Libasa
//
//  Created by Control-z on 16/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Noticias.h"

@interface LDetalleNoticiasViewController : UIViewController<UICollectionViewDataSource>

@property (strong, nonatomic) Noticias * noticia;
@property (weak, nonatomic) IBOutlet UIView *viewNoticia;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewDetalle;
@property (weak, nonatomic) IBOutlet UITextView *textoDescripcion;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constanteHeight;

@end
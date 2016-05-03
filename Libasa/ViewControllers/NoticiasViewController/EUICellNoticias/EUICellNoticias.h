//
//  EUICellNoticias.h
//  Equipos
//
//  Created by Carlos molina on 07/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EUICellNoticias : UICollectionViewCell

//propiedades celdas notcias carrucel
@property (weak, nonatomic) IBOutlet UIImageView *imageCarousel;
@property (weak, nonatomic) IBOutlet UILabel *celdaDescripcion;

//propiedades celdas notcias
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *celdaTituloNoticias;

@end

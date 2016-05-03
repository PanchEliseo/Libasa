//
//  Noticias.h
//  Libasa
//
//  Created by Control-z on 17/03/16.
//  Copyright © 2016 Control-z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Noticias : NSObject

@property (strong, nonatomic) NSString * idNoticia;
@property (strong, nonatomic) NSString * titulo;
@property (strong, nonatomic) NSString * nota;
@property (strong, nonatomic) NSString * descripcion;
@property (strong, nonatomic) NSString * short_descripcion;
@property (strong, nonatomic) NSString * fecha;
@property (strong, nonatomic) NSString * img_preview;
@property (strong, nonatomic) NSString * tipo_multimedia;
@property (strong, nonatomic) NSMutableArray * multimedia;

@end

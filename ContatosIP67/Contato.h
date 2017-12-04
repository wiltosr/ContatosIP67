//
//  Contato.h
//  ContatosIP67
//
//  Created by Wilton Ravelha on 08/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contato : NSObject

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *endereco;
@property (strong) NSString *site;
@property (strong) NSString *email;
@property (strong) UIImage *foto;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;

@end

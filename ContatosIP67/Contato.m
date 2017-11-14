//
//  Contato.m
//  ContatosIP67
//
//  Created by Wilton Ravelha on 08/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(NSString *) description{
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Endereço: %@, Site: %@, Email: %@", self.nome, self.telefone, self.endereco, self.site, self.email];
}

@end

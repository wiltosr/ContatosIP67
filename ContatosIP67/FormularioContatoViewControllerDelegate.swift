//
//  FormularioContatoViewControllerDelegate.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 21/11/2017.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import Foundation

protocol FormularioContatoViewControllerDelegate{
    
    func contatoAdicionado(_ contato: Contato)
    func contatoAtualizado(_ contato: Contato)
}

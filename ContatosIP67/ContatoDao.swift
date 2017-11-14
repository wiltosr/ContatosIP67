//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 12/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import Foundation

class ContatoDao: NSObject {

    var contatos: Array<Contato>
    static private var defaultDao:ContatoDao!
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)        
    }
    
    func remove(_ posicao:Int){
        contatos.remove(at: posicao)
    }
    
    func buscaContatoNaPosicao(_ posicao:Int) -> Contato{
        return contatos[posicao]
    }
    
    func listaTodos() -> [Contato]{
        return contatos
    }
    
    static func sharedInstance() -> ContatoDao{
        if(defaultDao == nil){
            defaultDao = ContatoDao()
        }
        return defaultDao
    }
    
    override init() {
        self.contatos = Array()
        super.init()
    }

}

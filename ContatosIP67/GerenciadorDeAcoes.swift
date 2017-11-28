//
//  GerenciadorDeAcoes.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 22/11/2017.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import UIKit

class GerenciadorDeAcoes: NSObject {
    
    var controller:UIViewController!
    let contato:Contato
    
    init(do contato:Contato){
        self.contato = contato
    }
    
    func exibirAcoes(em controller:UIViewController){
        self.controller = controller
    
        let alertView = UIAlertController(title: self.contato.nome, message: nil, preferredStyle: .actionSheet)
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let ligarParaContato = UIAlertAction(title: "Ligar", style: .default){ action in self.ligar()}
        let exibirContatoNoMapa = UIAlertAction(title: "Visualizar no mapa", style: .default){action in self.abrirNoMapa()}
        let exibirSiteDoContato = UIAlertAction(title: "Visualizar site", style: .default){action in self.abrirNavegador()}
        
        alertView.addAction(cancelar)
        alertView.addAction(ligarParaContato)
        alertView.addAction(exibirContatoNoMapa)
        alertView.addAction(exibirSiteDoContato)
        
        self.controller.present(alertView, animated: true, completion: nil)
        
    }
    
    private func ligar(){
        let device = UIDevice.current
        
        if device.model == "iPhone"{
            print("UUID \(device.identifierForVendor!)")
            abrirAplicativo(com: "tel:" + self.contato.telefone!)
        }else{
            let alert = UIAlertController(title: "Impossível fazer ligações", message: "Seu dispositivo não é um iPhone", preferredStyle: .alert)
            self.controller.present(alert, animated: true, completion: nil)
        }
    }
    
    private func abrirNavegador(){
        var url = contato.site!
        
        if !url.hasPrefix("http://"){
            url = "http://" + url
        }
        abrirAplicativo(com: url)
    }
    
    private func abrirNoMapa(){
        let url = ("http://maps.google.com/maps?q=" + self.contato.endereco!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        abrirAplicativo(com: url)
    }
    
    private func abrirAplicativo(com url:String){
        UIApplication
            .shared
            .open(URL(string:url)!, options: [:], completionHandler: nil)
    }

}

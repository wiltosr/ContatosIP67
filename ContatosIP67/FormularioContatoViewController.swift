//
//  ViewController.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 07/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {

    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    @IBOutlet var email: UITextField!

    var dao:ContatoDao!
    var contato:Contato!
    var delegate:FormularioContatoViewControllerDelegate?
    
    func pegaDadosDoFormulario(){
        
        if(contato == nil){
            self.contato = Contato()
        }
        
        contato.nome = self.nome.text!
        contato.endereco = self.endereco.text!
        contato.telefone = self.telefone.text!
        contato.email = self.email.text!
        contato.site = self.site.text!
    }
    
    @objc func criaContato(){
        pegaDadosDoFormulario()
        dao.adiciona(contato)
        self.delegate?.contatoAdicionado(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func atualizaContato(){
        pegaDadosDoFormulario()
        self.delegate?.contatoAtualizado(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        if contato != nil{
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            self.email.text = contato.email
            
            rightBarButton.title = "Confirmar"
            rightBarButton.action = #selector(atualizaContato)
            
        }else{
            rightBarButton.title = "Adicionar"
            rightBarButton.action = #selector(criaContato)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


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
    
    @IBAction func criaContato(){
        self.pegaDadosDoFormulario()
                dao.adiciona(contato)
//        print(contato)
//        print(dao.listaTodos())
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func atualizaContato(){
        pegaDadosDoFormulario()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contato != nil{
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            self.email.text = contato.email
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
            
        }else{
        
            let botaoAdicionar = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(criaContato))
        
            self.navigationItem.rightBarButtonItem = botaoAdicionar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


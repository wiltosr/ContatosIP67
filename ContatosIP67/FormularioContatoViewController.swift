//
//  ViewController.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 07/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var foto: UIImageView!

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
        contato.foto = self.foto.image
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
    
    @objc func selecionarFoto(sender:AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
        }else{
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.foto.image = imagemSelecionada
        }
        picker.dismiss(animated: true, completion: nil)
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
            
            if let foto = self.contato.foto{
                self.foto.image = foto
            }
            
            rightBarButton.title = "Confirmar"
            rightBarButton.action = #selector(atualizaContato)
            
        }else{
            rightBarButton.title = "Adicionar"
            rightBarButton.action = #selector(criaContato)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionarFoto(sender:)))
        self.foto.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


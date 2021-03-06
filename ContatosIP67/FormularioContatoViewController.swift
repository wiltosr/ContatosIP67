//
//  ViewController.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 07/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nome: UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var site: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var foto: UIImageView!
    @IBOutlet var latitude: UITextField!
    @IBOutlet var longitude: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!

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
        
        if let latitude = Double(self.latitude.text!){
            self.contato.latitude = latitude as NSNumber
        }
        
        if let longitude = Double(self.longitude.text!){
            self.contato.longitude = longitude as NSNumber
        }
        
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
            
            let alert = UIAlertController(title: "Escolha a foto do contato", message: self.contato.nome, preferredStyle: .actionSheet)
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            let tirarFoto = UIAlertAction(title: "Tirar foto", style: .default){(action) in self.pegarImage(da: .camera)}
            let escolherFoto = UIAlertAction(title: "Escolher da biblioteca", style: .default) {(action) in self.pegarImage(da: .photoLibrary)}
            
            alert.addAction(cancelar)
            alert.addAction(tirarFoto)
            alert.addAction(escolherFoto)
            
            self.present(alert, animated: true, completion: nil)
        
        }else{
            pegarImage(da: .photoLibrary)
        }
    }
    
    private func pegarImage(da sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.foto.image = imagemSelecionada
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buscarCoordenadas(sender: UIButton){
        
        self.loading.startAnimating()
        sender.isEnabled = false
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(self.endereco.text!){(resultado, error) in
            
            if error == nil && resultado?.count != 0 {
                let placemark = resultado![0]
                let coordenada = placemark.location!.coordinate
                
                self.latitude.text = coordenada.latitude.description
                self.longitude.text = coordenada.longitude.description
            }
            
            self.loading.stopAnimating()
            sender.isEnabled = true
        }
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
            self.latitude.text = contato.latitude?.description
            self.longitude.text = contato.longitude?.description
            
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


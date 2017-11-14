//
//  ListaContatosViewController.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 12/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import UIKit

class ListaContatosViewController: UITableViewController {
    
    var dao:ContatoDao
    static let cellIdentifier:String = "cell"
    
    required init?(coder aDecoder: NSCoder) {
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.listaTodos().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contato:Contato = self.dao.buscaContatoNaPosicao(indexPath.row)
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ListaContatosViewController.cellIdentifier)
        
        if(cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier:ListaContatosViewController.cellIdentifier)
        }
        cell!.textLabel?.text = contato.nome
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:  UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.dao.remove(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contatoSelecionado = dao.buscaContatoNaPosicao(indexPath.row)
        self.exibeFormulario(contatoSelecionado)
    }
    
    func exibeFormulario(_ contato:Contato){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let formulario = storyboard.instantiateViewController(withIdentifier: "Form-Contato") as! FormularioContatoViewController
        formulario.contato = contato
        self.navigationController?.pushViewController(formulario, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

}

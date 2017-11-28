//
//  ListaContatosViewController.swift
//  ContatosIP67
//
//  Created by Wilton Ravelha on 12/11/17.
//  Copyright © 2017 Wilton Ravelha. All rights reserved.
//

import UIKit

class ListaContatosViewController: UITableViewController, FormularioContatoViewControllerDelegate {
    
    var dao:ContatoDao
    static let cellIdentifier:String = "cell"
    var linhaDestaque: IndexPath?
    
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
        formulario.delegate = self
        formulario.contato = contato
        self.navigationController?.pushViewController(formulario, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if let linha = self.linhaDestaque{
            self.tableView.selectRow(at: self.linhaDestaque!, animated: true, scrollPosition: .middle)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                self.tableView.deselectRow(at: self.linhaDestaque!, animated: true)
                self.linhaDestaque = Optional.none
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(exibirMaisAcoes(gesture:)))
        self.tableView.addGestureRecognizer(longPress)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Segue"{
            if let formulario = segue.destination as? FormularioContatoViewController{
                formulario.delegate = self
            }
//        }
    }
    
    func contatoAtualizado(_ contato: Contato) {
        self.linhaDestaque = IndexPath(row: dao.buscaPosicaoDoContato(contato: contato), section: 0)
    }
    
    func contatoAdicionado(_ contato: Contato) {
        self.linhaDestaque = IndexPath(row: dao.buscaPosicaoDoContato(contato: contato), section: 0)
    }
    
    @objc func exibirMaisAcoes(gesture: UIGestureRecognizer){
        
        if gesture.state == .began{
            
            let ponto = gesture.location(in: self.tableView)
            if let indexPath:IndexPath? = self.tableView.indexPathForRow(at: ponto){
                let contato = self.dao.buscaContatoNaPosicao(indexPath!.row)
                let acoes = GerenciadorDeAcoes(do:contato)
                acoes.exibirAcoes(em: self)
            }
        }
    }
}

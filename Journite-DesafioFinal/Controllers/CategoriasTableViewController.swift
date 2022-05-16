//
//  CategoriasTableViewController.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 11/05/22.
//

import UIKit

class CategoriasTableViewController: UITableViewController {
    
    let categorias = CategoriaRepository.getCategorias()
    
    var escolhaCategoria : ((Categoria)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EscolhaCategoriaCell", for: indexPath)
        let categoria = categorias[indexPath.row]
        cell.textLabel?.text = categoria.tipo
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoria = categorias[indexPath.row]
        self.escolhaCategoria!(categoria)
        self.navigationController?.popViewController(animated: true)
    }
}

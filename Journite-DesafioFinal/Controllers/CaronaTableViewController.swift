//
//  CaronaTableViewController.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 09/05/22.
//

import UIKit

//let paloma = Aluno(nome: "Paloma", ra: "9999999", faculdade: "UFABC")
//
//let categoria = Categoria(tipo: "A pé", cor: UIColor.purple)
//
//let caronas: [Carona] = [
//    Carona(aluno: paloma, data: Date(), localInicio: "Av Paes de Barros", localFim: "Rua Tobias Barreto", categoria: categoria, preco: 0.00, acompanhantes: 1, lotacaoMaxima: 5 )
//]

class CaronaTableViewController: UITableViewController {
    
    private var selectedIndexPath: IndexPath?
    private var caronas: [Carona] = []
    
    private var dateFormatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.caronas = CaronaRepository.instance.getCarona()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        caronas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaronaCell", for: indexPath) as! CaronaTableViewCell
        let carona = caronas[indexPath.row]
        
        cell.delegate = self
        
        dateFormatter.dateFormat = "HH:mm"
        cell.horaLabel.text = dateFormatter.string(from: carona.data)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.dataLabel.text = dateFormatter.string(from: carona.data)
        
        cell.categoriaNameLabel.text = carona.categoria.tipo
        
        cell.categoriaView.backgroundColor = carona.categoria.cor
        
        cell.acompanhantesLabel.text = String(carona.acompanhantes)
        
        cell.lotacaoMaximaLabel.text = String(carona.lotacaoMaxima)
        
        cell.precoLabel.text = String(carona.preco)
        
        cell.nomeAlunoLabel.text = carona.aluno.nome
        
        cell.raAlunoLabel.text = carona.aluno.ra
        
        cell.faculdadeLabel.text = carona.aluno.faculdade
        
        cell.localInicioLabel.text = carona.localInicio
        
        cell.localFimLabel.text = carona.localFim

        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRouteSegue",
            let indexPath = sender as? IndexPath,
           let mapsViewController = segue.destination as? MapaViewController
        {
            let carona = caronas[indexPath.row]
            mapsViewController.carona = carona
        }
        
        if segue.identifier == "evaluateSegue",
           let indexPath = sender as? IndexPath,
          let starRatingViewController = segue.destination as? StarRatingViewController
       {
           let carona = caronas[indexPath.row]
           starRatingViewController.carona = carona
       }
    }
    
    
}


extension CaronaTableViewController: CaronaTableViewCellDelegate{
    func didTapEvaluateAction(sender: UITableViewCell, button: UIButton) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        performSegue(withIdentifier: "evaluateSegue", sender: indexPath)
    }
    
    func didTapViewRoute(sender: UITableViewCell, button: UIButton) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        performSegue(withIdentifier: "viewRouteSegue", sender: indexPath)
    }
    
    func didTapAddIntegrante(sender: UITableViewCell, button: UIButton) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let carona = caronas[indexPath.row]
        if(carona.acompanhantes < carona.lotacaoMaxima){
            carona.acompanhantes+=1
        } else {
            let alerta = UIAlertController(title: "Erro", message: "A carona já está em sua capacidade máxima, tente outra carona disponível.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta,animated: true, completion: nil)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

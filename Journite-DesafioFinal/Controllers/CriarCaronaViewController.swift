//
//  CriarCaronaViewController.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 10/05/22.
//

import UIKit

class CriarCaronaViewController : UITableViewController, UITextFieldDelegate {
    
    private let datePicker: UIDatePicker = UIDatePicker()
    private var dateFormatter = DateFormatter()
    
    var caronaRepository = CaronaRepository.instance
    
    var carona: Carona = Carona(aluno: Aluno(nome: "", ra: "", faculdade: ""), data: Date(), localInicio: "", localFim: "", categoria: Categoria(tipo: "Selecione uma categoria", cor: UIColor.black), preco: 0.00, acompanhantes: 1, lotacaoMaxima: 5)
    
    private var selectedIndexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Nome do aluno"
        case 1:
            return "Número da matrícula(RA)"
        case 2:
            return "Nome da faculdade"
        case 3:
            return "Endereço do local de partida"
        case 4:
            return "Endereço do local de destino"
        case 5:
            return "Categoria"
        case 6:
            return "Número de acompanhantes"
        case 7:
            return "Capacidade"
        case 8:
            return "Preço"
        default:
            return "Data"
        }
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NomeCell", for: indexPath) as! NomeAlunoTableViewCell
            cell.nomeAlunoTextField.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RaCell", for: indexPath) as! RaAlunoTableViewCell
            cell.raAlunoTextField.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaculdadeCell", for: indexPath) as! FaculdadeTableViewCell
            cell.faculdadeTextField.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocalInicioCell", for: indexPath) as! LocalInicioTableViewCell
            cell.localInicioTextField.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocalFimCell", for: indexPath) as! LocalFimTableViewCell
            cell.localFimTextField.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriaCell", for: indexPath) as! CategoriaTableViewCell
            cell.textLabel?.text = self.carona.categoria.tipo
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcompanhantesCell", for: indexPath) as! AcompanhantesTableViewCell
            cell.acompanhantesTextField.delegate = self
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LotacaoMaximaCell", for: indexPath) as! LotacaoMaximaTableViewCell
            cell.lotacaoMaximaTextField.delegate = self
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrecoCell", for: indexPath) as! PrecoTableViewCell
            cell.precoTextField.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataTableViewCell
            cell.dataTextField.inputView = datePicker
            cell.dataTextField.delegate = self
            cell.dataTextField.inputAccessoryView = acessoryView()
            
            return cell
        }
    }
    
    @IBAction func cliqueSalvar(_ sender: Any) {
        caronaRepository.salvar(carona: carona)
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? DataTableViewCell
        if let dataCell = cell {
            self.selectedIndexPath = tableView.indexPath(for: dataCell)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let nomeAluno = textField.superview?.superview as? NomeAlunoTableViewCell
        if let nomeCell = nomeAluno {
            self.selectedIndexPath = tableView.indexPath(for: nomeCell)
            self.carona.aluno.nome = textField.text!
        }
            
        let raAluno = textField.superview?.superview as? RaAlunoTableViewCell
            if let raCell = raAluno {
                self.selectedIndexPath = tableView.indexPath(for: raCell)
                self.carona.aluno.ra = textField.text!
        }
        
        let faculdade = textField.superview?.superview as? FaculdadeTableViewCell
            if let faculdadeCell = faculdade {
                self.selectedIndexPath = tableView.indexPath(for: faculdadeCell)
                self.carona.aluno.faculdade = textField.text!
        }
        
        let localInicio = textField.superview?.superview as? LocalInicioTableViewCell
            if let partidaCell = localInicio {
                self.selectedIndexPath = tableView.indexPath(for: partidaCell)
                self.carona.localInicio = textField.text!
        }
        
        let localFim = textField.superview?.superview as? LocalFimTableViewCell
            if let destinoCell = localFim {
                self.selectedIndexPath = tableView.indexPath(for: destinoCell)
                self.carona.localFim = textField.text!
        }
        
        let acompanhantes = textField.superview?.superview as? AcompanhantesTableViewCell
            if let acompanhantesCell = acompanhantes {
                self.selectedIndexPath = tableView.indexPath(for: acompanhantesCell)
                let acompanhante = (textField.text ?? "") as String
                self.carona.acompanhantes = Int(acompanhante) ?? 0
                if(self.carona.acompanhantes == 0){
                    let alerta = UIAlertController(title: "Error", message: "O usuário deve informar um número no campo de acompanhantes", preferredStyle: UIAlertController.Style.alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alerta,animated: true, completion: nil)
                }
        }
        
        let lotacaoMaxima = textField.superview?.superview as? LotacaoMaximaTableViewCell
            if let lotacaoMaximaCell = lotacaoMaxima {
                self.selectedIndexPath = tableView.indexPath(for: lotacaoMaximaCell)
                let lotacaoMaximaModificada = (textField.text ?? "") as String
                self.carona.lotacaoMaxima = Int(lotacaoMaximaModificada) ?? 0
                if(self.carona.lotacaoMaxima == 0){
                    let alerta = UIAlertController(title: "Error", message: "O usuário deve informar um número no campo de capacidade máxima", preferredStyle: UIAlertController.Style.alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alerta,animated: true, completion: nil)
                }
        }
        
        let preco = textField.superview?.superview as? PrecoTableViewCell
            if let precoCell = preco {
                self.selectedIndexPath = tableView.indexPath(for: precoCell)
                let precoModificado = (textField.text ?? "") as String
                self.carona.preco = Float(precoModificado) ?? 0.00
        }
    }
    
    func acessoryView() -> UIView {
        let toolBar = UIToolbar()
               toolBar.barStyle = .default
               toolBar.isTranslucent = true
               let barItemSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
               let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(CriarCaronaViewController.selectDate))
               toolBar.setItems([barItemSpace,doneButton], animated: true)
               toolBar.isUserInteractionEnabled = true
               toolBar.sizeToFit()
               return toolBar
    }
    
    @objc func selectDate(){
            if let indexPath = self.selectedIndexPath {
                let cell = tableView.cellForRow(at: indexPath) as? DataTableViewCell
                if let dataCell = cell {
                    dataCell.dataTextField.text = dateFormatter.string(from: datePicker.date)
                    self.view.endEditing(true)
                    self.carona.data = datePicker.date
                }
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ParaCategoriasTableViewController" {
            let categoriasController = segue.destination as! CategoriasTableViewController
            categoriasController.escolhaCategoria = { categoria in
                    self.carona.categoria = categoria
                self.tableView.reloadData()
            }
        }
    }
}

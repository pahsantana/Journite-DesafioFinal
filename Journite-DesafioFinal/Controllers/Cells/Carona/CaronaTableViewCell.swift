//
//  CaronaTableViewCell.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 09/05/22.
//

import UIKit

protocol CaronaTableViewCellDelegate: AnyObject {
    func didTapAddIntegrante(sender: UITableViewCell, button: UIButton)
    func didTapViewRoute(sender: UITableViewCell, button: UIButton)
    func didTapEvaluateAction(sender: UITableViewCell, button: UIButton)
}

class CaronaTableViewCell: UITableViewCell {
    @IBOutlet weak var horaLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var categoriaNameLabel: UILabel!
    @IBOutlet weak var acompanhantesLabel: UILabel!
    @IBOutlet weak var lotacaoMaximaLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var categoriaView: UIView!
    @IBOutlet weak var nomeAlunoLabel: UILabel!
    @IBOutlet weak var raAlunoLabel: UILabel!
    @IBOutlet weak var faculdadeLabel: UILabel!
    @IBOutlet weak var localInicioLabel: UILabel!
    @IBOutlet weak var localFimLabel: UILabel!
    
    weak var delegate: CaronaTableViewCellDelegate?
    
    @IBAction func addIntegranteAction(_ sender: UIButton) {
        delegate?.didTapAddIntegrante(sender: self, button: sender)
    }
    
    @IBAction func viewRouteAction(_ sender: UIButton) {
        delegate?.didTapViewRoute(sender: self, button: sender)
    }
    
    @IBAction func evaluateAction(_ sender: UIButton) {
        delegate?.didTapEvaluateAction(sender: self, button: sender)
    }
}

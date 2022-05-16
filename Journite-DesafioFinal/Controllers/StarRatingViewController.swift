//
//  StartRatingViewController.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 11/05/22.
//

import Foundation
import Cosmos
import TinyConstraints


class StarRatingViewController: UIViewController {
    
    var carona: Carona?
    var avaliacao: Avaliacao = Avaliacao()
    
    @IBOutlet weak var avaliacaoTextField: UITextView!
    
    @IBOutlet weak var detalhesExperienciaRegistradasText: UILabel!
    
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        view.settings.filledImage = UIImage(named:"RatingStarFilled")?.withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = UIImage(named:"RatingStarEmpty")?.withRenderingMode(.alwaysOriginal)
        view.settings.starSize = 30
        view.settings.starMargin = 5
        view.settings.totalStars = 5
        view.settings.starMargin = 3.3
        view.settings.fillMode = .precise
        
        view.text = "Rate me"
        view.settings.textColor = .red
        view.settings.textMargin = 10
        
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detalhesExperienciaRegistradasText.text = ""
        for i in 0..<(carona?.avaliacoes.count ?? 0) {
            detalhesExperienciaRegistradasText.text! += "\( carona?.avaliacoes[i].description ?? ""). Nota: \(carona?.avaliacoes[i].rating ?? 0.0)\n"
        }
        
        
        
        view.addSubview(cosmosView)
        cosmosView.centerInSuperview()
        
        cosmosView.didTouchCosmos = { [self]
            rating in self.avaliacao.rating = Float(rating)
        }
        
    }
    @IBAction func tapSaveAvaliacao(_ sender: Any) {
        avaliacao.description = avaliacaoTextField.text
        carona?.avaliacoes.append(avaliacao)
        self.navigationController?.popViewController(animated: true)
    }
}


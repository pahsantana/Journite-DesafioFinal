//
//  CaronaRepository.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 11/05/22.
//

//Singleton
import Foundation
import UIKit

class CaronaRepository {
    static let instance: CaronaRepository = CaronaRepository()
    
    private var caronas: [Carona]
    
//    private let defaults = UserDefaults.standard
//
//    private let keyCaronas = "caronas"
    
    private init(){
        self.caronas = []
    }
    
    func salvar(carona: Carona){
        self.caronas.append(carona)
//       defaults.set(caronas, forKey: keyCaronas)
    }
    
    func atualizar(caronaParaAtualizar: Carona) {
        let caronaIndice = caronas.firstIndex{
            (carona)->Bool in
            carona.id == caronaParaAtualizar.id
        }
        caronas.remove(at: caronaIndice!)
    }
    
    
    func getCarona()->[Carona]{
        self.caronas
        //= (defaults.value(forKey: keyCaronas) as? Array ?? [])
        //return self.caronas
    }
}

//
//  CategoriaRepository.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 11/05/22.
//

import Foundation
import UIKit

class CategoriaRepository {
    static func getCategorias()->[Categoria]{
        let categorias = [
            Categoria(tipo:"A pé", cor: UIColor.green),
            Categoria(tipo:"Trem", cor: UIColor.blue),
            Categoria(tipo:"Metrô", cor: UIColor.yellow),
            Categoria(tipo:"Ônibus", cor: UIColor.red),
            Categoria(tipo:"Fretado", cor: UIColor.purple),
            Categoria(tipo:"Carro", cor: UIColor.cyan),
            Categoria(tipo:"Aplicativos", cor: UIColor.orange)
        ]
        
        return categorias
    }
}

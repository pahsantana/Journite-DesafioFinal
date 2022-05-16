//
//  Carona.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 09/05/22.
//

import Foundation

class Carona {
    var id = UUID()
    var aluno: Aluno
    var data: Date
    var localInicio: String
    var localFim: String
    var categoria: Categoria
    var preco: Float
    var acompanhantes: Int
    var lotacaoMaxima: Int
    var avaliacoes: [Avaliacao] = []
    
    init(aluno: Aluno, data:Date, localInicio:String, localFim: String, categoria: Categoria, preco: Float, acompanhantes:Int, lotacaoMaxima: Int){
        self.aluno = aluno
        self.data = data
        self.localInicio = localInicio
        self.localFim = localFim
        self.categoria = categoria
        self.preco = preco
        self.acompanhantes = acompanhantes
        self.lotacaoMaxima = lotacaoMaxima
    }
}

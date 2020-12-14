//
//  Model.swift
//  Pokedex
//
//  Created by ali on 12/1/20.
//

import Foundation



struct Pokemon: Codable {
    var name: String
    var url: String
}


struct PokemonList: Codable {
    var results: [Pokemon]
}


struct PokemonData: Codable {
    var id: Int
}


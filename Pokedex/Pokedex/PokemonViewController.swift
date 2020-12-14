//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by ali on 12/1/20.
//

import UIKit



class PokemonViewController: UIViewController {
    
    var pokemon: Pokemon!
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = pokemon.name
        detailLabel.text = ""
        
        guard let url = URL(string: pokemon.url) else {
            print("URL is not valid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Request Failed")
                return
            }
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                
                DispatchQueue.main.async {
                    self.detailLabel.text = String(format: "#%03d", pokemonData.id)
                }
                
                
   
            } catch let error {
                print("\(error)")
            }
        }.resume()
        
//        detailLabel.text = String(pokemon.id)
    }
    
}

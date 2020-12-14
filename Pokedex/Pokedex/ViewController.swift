//
//  ViewController.swift
//  Pokedex
//
//  Created by ali on 12/1/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151po") else {
            print("URL is not valid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Request Failed")
                return
            }
            do {
                let pokemons = try JSONDecoder().decode(PokemonList.self, from: data)
                
                self.pokemons = pokemons.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch let error {
                print("\(error)")
            }
        }.resume()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = pokemons[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let vc = segue.destination as? PokemonViewController {
                guard let index = tableView.indexPathForSelectedRow?.row else {
                    print("Error")
                    return
                }
                vc.pokemon = pokemons[index]
            }
            
        }
    }
    
    
}


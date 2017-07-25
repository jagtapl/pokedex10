//
//  PokemonDetailVC.swift
//  pokedex10
//
//  Created by LALIT JAGTAP on 7/24/17.
//  Copyright © 2017 LALIT JAGTAP. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainDescrLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokeIndexLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexid)")
        mainImage.image = img
        currentEvoImg.image = img
        pokeIndexLbl.text = "\(pokemon.pokedexid)"
        
        pokemon.downloadPokemonDetail {
            // whatever we write here is called after network call is complete
            self.updateUI()
        }

    }
    
    func updateUI() {
        print("pokemon JSON download completed..now updating UI with the pokemon data as")
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        typeLbl.text = pokemon.type
        mainDescrLbl.text = pokemon.description
        
        print("height is \(pokemon.height)")
        print("weight is \(pokemon.weight)")
        print("base attack is \(pokemon.attack)")
        print("defense is \(pokemon.defense)")
        print("type is \(pokemon.type)")
        print("desc is \(pokemon.description)")
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No evolutions"
            nextEvoImg.isHidden = true
        }
        else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evoLbl.text = str
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

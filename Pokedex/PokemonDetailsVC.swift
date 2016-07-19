//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Jason Piao on 2016-07-15.
//  Copyright © 2016 Jason Piao. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var pokemonDesc: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var baseEvolutionImg: UIImageView!
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    @IBOutlet weak var evolutionLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokeId)")
        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = img
        baseEvolutionImg.image = img
        
        
        pokemon.downloadPokeDetails {
            self.updateUI()
            
        }
    }

    func updateUI() {
        
        nameLbl.text = pokemon.name
        pokemonDesc.text = pokemon.pokeDesc
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexID.text = "\(pokemon.pokeId)"
        attackLbl.text = pokemon.attack
        
        if pokemon.nextEvoId == "" {
            nextEvolutionImg.hidden = true
            evolutionLbl.text = "NO EVOLUTION"
        } else {
            nextEvolutionImg.hidden = false
            nextEvolutionImg.image = UIImage(named: "\(pokemon.nextEvoId)")
            evolutionLbl.text = "Next Evolution: \(pokemon.nextEvolutionTxt)"
        }
        
    }
    
    @IBAction func backBtnPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
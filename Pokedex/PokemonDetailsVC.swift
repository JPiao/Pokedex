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
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var baseEvolutionImg: UIImageView!
    
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = UIImage(named: "\(pokemon.pokeId)")
        
        pokemon.downloadPokeDetails { 
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }



}

//
//  PokeCell.swift
//  Pokedex
//
//  Created by Jason Piao on 2016-07-13.
//  Copyright © 2016 Jason Piao. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var pokeLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        thumbImg.image = UIImage(named: "\(pokemon.pokeId)")
        pokeLbl.text = pokemon.name
    }
    
}
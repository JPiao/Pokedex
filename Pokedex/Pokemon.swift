//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jason Piao on 2016-07-12.
//  Copyright © 2016 Jason Piao. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokeId: Int!
    
    var name: String {
        return _name
    }
    
    var pokeId: Int {
        return _pokeId
    }
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
    }
}
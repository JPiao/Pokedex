//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jason Piao on 2016-07-12.
//  Copyright © 2016 Jason Piao. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    //Data encapsulation
    private var _name: String!
    private var _pokeId: Int!
    private var _pokeDesc: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokeURL: String!
    private var _nextEvoId: String!
    private var _moves: String!
    
    var name: String {
        return _name
    }
    
    var pokeId: Int {
        return _pokeId
    }
    
    var pokeDesc: String {
        if _pokeDesc == nil {
            _pokeDesc = ""
        }
        return _pokeDesc
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        } 
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var moves: String {
        if _moves == nil {
            _moves = ""
        }
        return _moves
    }
    
    init(name: String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
        
        _pokeURL = "\(URL_BASE)\(POKE_URL)\(_pokeId)/"
    }
    
    func downloadMoves(completed: DLComplete) {
        let url = NSURL(string: _pokeURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            var str: String!
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let moves = dict["moves"] as? [Dictionary<String, AnyObject>] where moves.count > 0 {
                    if let move = moves[0]["name"] as? String {
                        str = move    
                    }
                    
                    if moves.count > 1  {
                        for x in 1 ..< moves.count {
                            str! += ", \(moves[x]["name"])"
                            let str1 = str!.stringByReplacingOccurrencesOfString("Optional", withString: "")
                            let str2 = str1.stringByReplacingOccurrencesOfString("(", withString: "")
                            let str3 = str2.stringByReplacingOccurrencesOfString(")", withString: "")
                            self._moves = str3
                        }
                        print(self._moves)
                    }
                }
            }
        }
    }
    
    func downloadPokeDetails(completed: DLComplete) {
        let url = NSURL(string: _pokeURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._pokeDesc = description.stringByReplacingOccurrencesOfString("POKMON", withString: "pokemon")
                                    print(self._pokeDesc)
                                }
                            }
                            
                            completed()
                        }
                    }
                    
                } else {
                    self._pokeDesc = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        //Can't support mega pokemon right now but
                        //api still has mega data
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvoId = num
                                self._nextEvolutionTxt = to
                                
                                print(self._nextEvoId)
                                print(self._nextEvolutionTxt)
             
                            }
                        } 
                    }      
                }
            }  
        } 
    }
}

//
//  Pokemon.swift
//  pokedex10
//
//  Created by LALIT JAGTAP on 7/22/17.
//  Copyright © 2017 LALIT JAGTAP. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    var _name: String!              //i m not using private accessor
    var _pokedexid: Int!
    var _description: String!
    var _type: String!
    var _defense: String!
    var _height: String!
    var _weight: String!
    var _attack: String!
    var _nextEvolutionTxt: String!
    var _nextEvolutionName: String!
    var _nextEvolutionId: String!
    var _nextEvolutionLevel: String!
    var _pokemonURL: String!
    
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
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
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var name: String {
        return _name
    }
    
    var pokedexid: Int {
        return _pokedexid
    }
    
    init(name: String, pokedexid: Int) {
        self._name = name
        self._pokedexid = pokedexid
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexid)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        print("download pokemon data using URL \(self._pokemonURL)")
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            //print(response.result.value!)
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    if let descRsrcURI = descArr[0]["resource_uri"] {
                        // fetch desc using this uri
                        let descURL = "\(URL_BASE)\(descRsrcURI)"
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let desc = descDict["description"] as? String {
                                    
                                    let newDescription = desc.replacingOccurrences(of: "POKEMON", with: "Pokemon")
        
                                    self._description = newDescription
                                    print(self._description)
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExists = evolutions[0]["level"] {
                                    
                                    if let lvl = lvlExists as? Int {
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                    print("evolution data found")
                    print(self.nextEvolutionLevel)
                    print(self.nextEvolutionName)
                    print(self.nextEvolutionId)
                }
            }
            completed()
        }
    }
}

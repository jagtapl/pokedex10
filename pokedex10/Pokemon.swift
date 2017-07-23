//
//  Pokemon.swift
//  pokedex10
//
//  Created by LALIT JAGTAP on 7/22/17.
//  Copyright © 2017 LALIT JAGTAP. All rights reserved.
//

import Foundation

class Pokemon {
    var _name: String!              //i m not using private accessor
    var _pokedexid: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexid: Int {
        return _pokedexid
    }
    
    init(name: String, pokedexid: Int) {
        self._name = name
        self._pokedexid = pokedexid
    }
    

}

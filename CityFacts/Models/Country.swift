//
//  Country.swift
//  CityFacts
//
//  Created by Tai Chin Huang on 2021/9/14.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var population: Int
    var area: Double?
    var region: String
    var currencies: [Currency]
    var flag: String
}

struct Currency: Codable{
    let name: String?
}

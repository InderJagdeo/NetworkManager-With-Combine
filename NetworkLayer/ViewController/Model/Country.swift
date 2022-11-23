//
//  Country.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import Foundation

struct Country: Codable, CustomStringConvertible {
    let name: CountryName
    let region: String
    let population: Int
}

struct CountryName: Codable, CustomStringConvertible {
    let official: String
}

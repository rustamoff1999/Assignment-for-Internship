//
//  Data.swift
//  my-App
//
//  Created by User on 29.07.2021.
//

import Foundation

//Decodable protocol hepls to parse json
struct JsonData : Decodable {
    let id : Int
    let title : String
    let content : String
}

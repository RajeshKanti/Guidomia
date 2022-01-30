//
//  CarListModels.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-27.
//

import Foundation

enum CarList {
    
    enum LoadScene {
        
        struct Request {
            let searchedMakeName: String?
            let searchedModelName: String?
        }
        
        struct Response {
            let carList: [CarModel]
        }
        
        struct ViewModel {
            let carList: [CarCellModel]
        }
    }
}

struct CarModel: Codable {
    let make: String
    let model: String
    let customerPrice: Int
    let marketPrice: Int
    let rating: Int
    let prosList: [String]
    let consList: [String]
}

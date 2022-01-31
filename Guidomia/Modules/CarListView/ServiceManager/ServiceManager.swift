//
//  ServiceManager.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-28.
//

import Foundation

protocol ServiceManagerProtocol {
    func fetchCarList(completionHandler: (Result<[CarModel], Error>) -> Void)
}

class ServiceManager: ServiceManagerProtocol {
    
    func fetchCarList(completionHandler: (Result<[CarModel], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "car_list", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CarModel].self, from: data)
                completionHandler(.success(jsonData))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
    }

}

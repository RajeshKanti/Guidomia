//
//  CarListInteractor.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-27.
//

import Foundation

protocol CarListBusinessLogic {
    func loadScene()
}

protocol CarListDataStore {
    
}

class CarListInteracter: CarListBusinessLogic, CarListDataStore {
    var presenter: CarListPresentationLogic?
    private var carList: [CarModel] = []
    
    func loadScene() {
        
        let serviceManager = ServiceManager()
        serviceManager.fetchCarList { [weak self] result in
            
            switch result {
            case .success(let carList):
                self?.carList = carList
                let response = CarList.LoadScene.Response(searchedMakeName: "", searchedModelName: "", carList: carList)
                presenter?.presentLoadScene(response)
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

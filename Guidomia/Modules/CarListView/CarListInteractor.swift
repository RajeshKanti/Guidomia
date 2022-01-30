//
//  CarListInteractor.swift
//  Guidomia
//
//  Created by Rajesh Ghosh on 2022-01-27.
//

import Foundation

protocol CarListBusinessLogic {
    func loadScene(_ request: CarList.LoadScene.Request)
}

protocol CarListDataStore {
    
}

class CarListInteracter: CarListBusinessLogic, CarListDataStore {
    var presenter: CarListPresentationLogic?
    private var carList: [CarModel] = []
    
    func loadScene(_ request: CarList.LoadScene.Request) {
        
        let serviceManager = ServiceManager()
        serviceManager.fetchCarList { [weak self] result in
            
            switch result {
            case .success(let carList):
                self?.carList = carList
                self?.filterCarList(request, carList: self?.carList ?? [CarModel]())                                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func filterCarList(_ request: CarList.LoadScene.Request, carList: [CarModel]) {
        
        if let searchedMakeName = request.searchedMakeName, let searchedModelName = request.searchedModelName, searchedMakeName != "", searchedModelName != "" {
            let filterData = carList.filter { ($0.make.range(of: searchedMakeName) != nil) && ($0.model.range(of: searchedModelName) != nil) }
            let filterResponse = CarList.LoadScene.Response(carList: filterData )
            presenter?.presentLoadScene(filterResponse)
        } else if let searchedMakeName = request.searchedMakeName, searchedMakeName != "" {
            let filterData = carList.filter { ($0.make.range(of: searchedMakeName) != nil) }
            let filterResponse = CarList.LoadScene.Response(carList: filterData )
            presenter?.presentLoadScene(filterResponse)
        } else if let searchedModelName = request.searchedModelName, searchedModelName != "" {
            let filterData = carList.filter { ($0.model.range(of: searchedModelName) != nil) }
            let filterResponse = CarList.LoadScene.Response(carList: filterData )
            presenter?.presentLoadScene(filterResponse)
        } else {
            let filterResponse = CarList.LoadScene.Response(carList: carList )
            presenter?.presentLoadScene(filterResponse)
        }
    }
}

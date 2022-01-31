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
    var carList: [CarModel]? { get set }
}

class CarListInteracter: CarListBusinessLogic, CarListDataStore {
    var carList: [CarModel]?
    
    var presenter: CarListPresentationLogic?
    private var coreDataManager = CoreDataManager()
    
    func loadScene(_ request: CarList.LoadScene.Request) {
        carList?.removeAll()
        carList = [CarModel]()

        //Fetch from cached data from Core Data
        if let carsManagedObj = coreDataManager.fetchCarInfosFromCoreData(), carsManagedObj.count > 0 {
            for car in carsManagedObj {
                if let carMake = car.value(forKeyPath: "make") as? String,
                let carModel = car.value(forKeyPath: "model") as? String,
                let customerPrice = car.value(forKeyPath: "customerPrice") as? Int,
                let marketPrice = car.value(forKeyPath: "marketPrice") as? Int,
                let rating = car.value(forKeyPath: "rating") as? Int,
                let prosList = car.value(forKeyPath: "prosList") as? [String],
                let consList = car.value(forKeyPath: "consList") as? [String] {
                    let carObj = CarModel(make: carMake, model: carModel, customerPrice: customerPrice, marketPrice: marketPrice, rating: rating, prosList: prosList, consList: consList)
                    carList?.append(carObj)
                }
            }
            filterCarList(request, carList: carList ?? [CarModel]())
        } else {
            //Fetch from local json file
            let serviceManager = ServiceManager()
            serviceManager.fetchCarList { [weak self] result in
                
                switch result {
                case .success(let carList):
                    self?.carList = carList
                    coreDataManager.saveCarInfosToData(carList: self?.carList ?? [CarModel]())
                    self?.filterCarList(request, carList: self?.carList ?? [CarModel]())
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
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

//
//  DataService.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation
import Combine

// MARK: - DataServiceProtocol

protocol DataServiceProtocol {
    var data: [Package] { get }
    func initData() -> AnyPublisher<[Package], Error>
}

// MARK: - DataService

final class DataService: DataServiceProtocol {
    
    // main data
    var data = [Package]()
    
    // Appconfig for json file name
    private let appConfig: AppConfigProtocol
    
    init(appConfig: AppConfigProtocol = AppConfig()) {
        self.appConfig = appConfig
    }
    
    // start loading data and return a publisher
    func initData() -> AnyPublisher<[Package], Error> {
        return Future<[Package], Error> { promise in
            DispatchQueue.global(qos: .utility).async {
                let data  = self.loadJsonData()
                DispatchQueue.main.async {
                    promise(.success(data))
                }
            }
        }
        .subscribe(on: Scheduler.backgroundWorkScheduler)
        .receive(on: Scheduler.mainScheduler)
        .eraseToAnyPublisher()
    }
    
    // load data from json file
    private func loadJsonData() -> [Package] {
        
        if let url = Bundle.main.url(forResource: self.appConfig.jsonFile, withExtension: "json") {
            do {
                let jsondata = try Data(contentsOf: url)
                let data = try JSONDecoder().decode([Package].self, from: jsondata)
                
                return data
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        return []
    }
}

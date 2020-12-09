//
//  PackageViewModel.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation
import Combine

// MARK: - PackageViewModelProtocol

protocol PackageViewModelProtocol {
    var data: [PackageItemViewModelProtocol] { get set }
    var delegate: PackageViewModelDelegate? { get set }
    func initData()
}

// MARK: - PackageViewModelDelegate

protocol PackageViewModelDelegate: AnyObject {
    func loadDataComplete()
}

// MARK: - PackageViewModel

final class PackageViewModel: PackageViewModelProtocol {
    // main data
    var data = [PackageItemViewModelProtocol]()
    // delegate
    weak var delegate: PackageViewModelDelegate?
    // dataService
    var dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }
    
    func initData() {
        // cal DataService for data
        let _ = self.dataService.initData().sink(receiveCompletion: { completion in
        }) {  [weak self] data in
            guard let self = self else { return }
            // transform to ItemViewModel
            self.data = data.map(PackageItemViewModel.init)
            // notify the UI
            self.delegate?.loadDataComplete()
        }
    }
}

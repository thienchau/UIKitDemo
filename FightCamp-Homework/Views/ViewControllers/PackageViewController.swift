//
//  PackageViewController.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

// MARK: - PackageViewController

class PackageViewController: UIViewController {
    
    // SubViews
    var tableView: UITableView!
    
    // ViewModel
    private var viewModel: PackageViewModelProtocol? = PackageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.delegate = self
        self.viewModel?.initData()
    }
    
    // MARK: loadView
    
    override func loadView() {
        setupView()
        setupLayout()
    }
    
    // MARK: setupView
    
    private func setupView() {
        view = UIView()
        view.backgroundColor = .secondaryBackground
        // init tableView
        tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PackageCell.self, forCellReuseIdentifier: PackageCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
    }
    
    // MARK: setupLayout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            //layout tableView
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PackageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageCell.identifier, for: indexPath) as! PackageCell
        cell.selectionStyle = .none
        cell.viewModel = self.viewModel?.data[indexPath.row] ?? nil
        return cell
    }
    
    // padding in bottom with footer heiht
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .packageSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: CGRect.zero)
    }
}

// MARK: - Conform PackageViewModelDelegate

extension PackageViewController : PackageViewModelDelegate {
    // reload UI
    func loadDataComplete() {
        self.tableView.reloadData()
    }
}

//
//  PackageCell.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

// MARK: - PackageCell

class PackageCell: UITableViewCell {
    
    // ViewModel
    var viewModel: PackageItemViewModelProtocol? {
        didSet {
            if let viewModel = viewModel {
                packageView.viewModel = viewModel
            }
        }
    }
    
    // SubViews
    lazy var packageView: PackageView = {
        let packageView = PackageView()
        packageView.translatesAutoresizingMaskIntoConstraints = false
        return packageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    // MARK: setupView
    
    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(packageView)
        setupLayout()
    }
    
    // MARK: setupLayout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            packageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .packageSpacing),
            packageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.packageSpacing),
            packageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .packageSpacing),
            
            contentView.bottomAnchor.constraint(equalTo: packageView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // identifier for reusing in TableView
    static var identifier: String {
        return String(describing: self)
    }
    
}

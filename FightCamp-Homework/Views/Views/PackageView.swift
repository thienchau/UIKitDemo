//
//  PackageView.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

// MARK: - PackageView

class PackageView: UIView {
    
    // ViewModel
    var viewModel: PackageItemViewModelProtocol? {
        didSet {
            guard let viewModel = viewModel else { return }
            loadData(viewModel)
        }
    }
    
    // Title Label
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .title
        titleLabel.textAlignment = .left
        titleLabel.textColor = .brandRed
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    // Desc Label
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = .body
        descLabel.textAlignment = .left
        descLabel.textColor = .label
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        return descLabel
    }()
    
    // Image Group View
    lazy var thumbGroupView: ThumbnailGroupView = {
        let thumbGroupView = ThumbnailGroupView()
        thumbGroupView.delegate = self
        thumbGroupView.translatesAutoresizingMaskIntoConstraints = false
        return thumbGroupView
    }()
    
    // Included Label
    lazy var includedLabel: UILabel = {
        let includedLabel = UILabel()
        includedLabel.font = .body
        includedLabel.textAlignment = .left
        includedLabel.textColor = .label
        includedLabel.numberOfLines = 0
        includedLabel.translatesAutoresizingMaskIntoConstraints = false
        return includedLabel
    }()
    
    // Excluded Label
    lazy var excludedLabel: UILabel = {
        let excludedLabel = UILabel()
        excludedLabel.font = .body
        excludedLabel.textAlignment = .left
        excludedLabel.textColor = .disabledLabel
        excludedLabel.numberOfLines = 0
        excludedLabel.translatesAutoresizingMaskIntoConstraints = false
        return excludedLabel
    }()
    
    // Payment Type Label
    lazy var paymentLabel: UILabel = {
        let paymentLabel = UILabel()
        paymentLabel.font = .body
        paymentLabel.textAlignment = .center
        paymentLabel.textColor = .label
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        return paymentLabel
    }()
    
    // Price Label
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .price
        priceLabel.textAlignment = .center
        priceLabel.textColor = .label
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
    
    // Package Detail Button
    lazy var viewButton: UIButton = {
        let viewButton = UIButton()
        viewButton.titleLabel?.font = .button
        viewButton.showsTouchWhenHighlighted = true
        viewButton.backgroundColor = .brandRed
        viewButton.layer.cornerRadius = .buttonRadius
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        return viewButton
    }()
    
    // Verticel StackView
    lazy var contentView: UIStackView = {
        // StackView for includedLabel, excludedLabel
        let infoStactView = UIStackView(arrangedSubviews: [includedLabel, excludedLabel])
        infoStactView.axis = .vertical
        infoStactView.translatesAutoresizingMaskIntoConstraints = false
        // StackView for paymentLabel, priceLabel
        let priceStactView = UIStackView(arrangedSubviews: [paymentLabel, priceLabel])
        priceStactView.axis = .vertical
        priceStactView.spacing = .priceSpacing
        priceStactView.translatesAutoresizingMaskIntoConstraints = false
        // Main StackView
        let contentView = UIStackView(arrangedSubviews: [titleLabel, descLabel, thumbGroupView, infoStactView, priceStactView, viewButton])
        contentView.axis = .vertical
        contentView.spacing = .packageSpacing
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: setupView
    
    private func setupView() {
        backgroundColor = .primaryBackground
        layer.cornerRadius = .packageRadius
        addSubview(contentView)
        setupLayout()
        setupActions()
    }
    
    // MARK: setupLayout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            viewButton.heightAnchor.constraint(equalToConstant: .buttonHeight),
            
            //layout contentView
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: .packageSpacing),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.packageSpacing),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .packageSpacing),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.packageSpacing)
        ])
    }
    
    // MARK: setupActions
    
    private func setupActions() {
        viewButton.addTarget(self, action: #selector(self.viewButtonClicked), for: .touchUpInside)
    }
    
    @objc func viewButtonClicked()
    {
        print("View Package Action")
    }
    
    private func loadData(_ viewModel: PackageItemViewModelProtocol) {
        titleLabel.text = viewModel.title
        descLabel.text = viewModel.desc
        descLabel.setLineSpacing(lineHeightMultiple: .lineHeightMultiple)
        thumbGroupView.imageUrls = viewModel.thumbnails
        thumbGroupView.selected = viewModel.selected
        includedLabel.text = viewModel.included
        includedLabel.setLineSpacing(lineHeightMultiple: .lineHeightMultiple)
        excludedLabel.attributedText = viewModel.excluded
        excludedLabel.setLineSpacing(lineHeightMultiple: .lineHeightMultiple)
        paymentLabel.text = viewModel.payment
        priceLabel.text = viewModel.price
        viewButton.setTitle(viewModel.action, for: .normal)
    }
}

// MARK: - Conform ThumbnailGroupViewDelegate

extension PackageView : ThumbnailGroupViewDelegate {
    // save selected index into ViewModel
    func select(index: Int) {
        viewModel?.selected = index
    }
}

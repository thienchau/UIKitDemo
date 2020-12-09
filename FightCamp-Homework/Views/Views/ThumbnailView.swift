//
//  ThumbnailView.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

// MARK: - ThumbnailViewDelegate

protocol ThumbnailViewDelegate: AnyObject {
    func selectThumb(view: ThumbnailView, urlString: String?)
}

// MARK: - ThumbnailView

class ThumbnailView: UIView {
    
    // url string
    var urlString: String? {
        didSet {
            if let url = urlString {
                imageView.loadImage(withUrl: url)
            }
        }
    }
    
    // selected status
    private var selected: Bool = false
    
    // delegate
    weak var delegate: ThumbnailViewDelegate?
    
    // imageview to display image
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = .thumbnailRadius
        imageView.layer.borderWidth = .thumbnailBorderWidth
        imageView.layer.borderColor = UIColor.thumbnailBorder(selected: selected).cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Init
    
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
        backgroundColor = .clear
        layer.cornerRadius = .thumbnailRadius
        clipsToBounds = true
        addSubview(imageView)
        setupLayout()
        setupActions()
    }
    
    // MARK: setupLayout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            //layout imageView
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: setupActions
    
    private func setupActions() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.clicked(_:))))
    }
    
    @objc private func clicked(_ sender:UITapGestureRecognizer){
        select(true)
        delegate?.selectThumb(view: self, urlString: urlString)
    }
    
    // UnSelect action
    func unSelect() {
        select(false)
    }
    
    // Save Selected status
    func select(_ select: Bool) {
        guard self.selected != select else { return }
        self.selected = select
        imageView.layer.borderColor = UIColor.thumbnailBorder(selected: self.selected).cgColor
    }
}

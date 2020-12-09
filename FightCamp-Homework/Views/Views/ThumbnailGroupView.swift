//
//  ThumbnailGroupView.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

// MARK: - ThumbnailGroupViewDelegate

protocol ThumbnailGroupViewDelegate: AnyObject {
    func select(index: Int)
}

// MARK: - ThumbnailGroupView

class ThumbnailGroupView: UIView {
    
    // Thumbnail number
    var appConfig: AppConfigProtocol = AppConfig()
    
    // delegate
    weak var delegate: ThumbnailGroupViewDelegate?
    
    // ImageUrls
    var imageUrls: [String]? {
        didSet {
            // update the image url for all thumnails
            guard let images = imageUrls else { return }
            for i in 0..<thumbViews.count {
                if images.indices.contains(i) {
                    thumbViews[i].urlString = images[i]
                } else {
                    thumbViews[i].urlString = ""
                }
                thumbViews[i].select(false)
            }
        }
    }
    
    // Selected Status
    var selected: Int? = 0 {
        didSet {
            // update selected status of every thumbnail
            guard let selected = selected else { return }
            for i in 0..<thumbViews.count {
                if selected == thumbViews[i].tag {
                    thumbViews[i].select(true)
                    if let images = imageUrls, images.indices.contains(i) {
                        imageView.loadImage(withUrl: imageUrls?[i] ?? "")
                    }
                } else {
                    thumbViews[i].select(false)
                }
            }
        }
    }
    
    // Main ImageView
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.layer.cornerRadius = .thumbnailRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Thumbnails Image
    lazy var thumbViews: [ThumbnailView] = {
        var thumbViews = [ThumbnailView]()
        for i in 0..<appConfig.THUMB_NUM {
            let thumbView = ThumbnailView()
            thumbView.delegate = self
            thumbView.tag = i
            thumbView.translatesAutoresizingMaskIntoConstraints = false
            thumbViews.append(thumbView)
        }
        return thumbViews
    }()
    
    // StackView to consist thumbnails
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: thumbViews)
        stackView.axis = .horizontal
        stackView.spacing = .thumbnailSpacing
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - setupView
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(imageView)
        addSubview(stackView)
        setupLayout()
    }
    
    // MARK: - setupLayout
    
    private func setupLayout() {
        
        var constraintArray = [
            
            //layout main ImageView
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .thumbnailHeight),
            
            // layout stact view for thumbnails
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .thumbnailSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ]
        
        // constraint thumbnails height = width
        thumbViews.forEach { thumbView in
            constraintArray.append(thumbView.heightAnchor.constraint(equalTo: thumbView.widthAnchor))
        }
        
        NSLayoutConstraint.activate(constraintArray)
    }
}

// MARK: - Conform ThumbnailViewDelegate

extension ThumbnailGroupView : ThumbnailViewDelegate {
    // receive selectect thumb event
    func selectThumb(view: ThumbnailView, urlString: String?) {
        guard let url = urlString else { return }
        // update main imageview
        imageView.loadImage(withUrl: url)
        thumbViews.forEach { thumbView in
            if view.tag != thumbView.tag {
                thumbView.select(false)
            }
        }
        // notify to delegate
        self.delegate?.select(index: view.tag)
    }
}

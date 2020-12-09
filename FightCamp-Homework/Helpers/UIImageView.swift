//
//  UIImageView.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation
import UIKit

// temp Cache to store Image
let imageCache = NSCache<NSString, UIImage>()

// MARK: - UIImageView

extension UIImageView {
    
    // load image from url string
    func loadImage(withUrl urlString : String) {
        
        guard let url = URL(string: urlString) else { return }
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard error == nil, let data = data else {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}

//
//  UIImageView+Extensions.swift
//  Interlude
//
//  Created by Gerson Noboa on 04/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImage(urlString: String?, placeholderImageName: String = "personDetailsImagePlaceholder") {
        guard let urlString = urlString else {
            self.image = UIImage(named: placeholderImageName)
            
            return
        }
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.image = UIImage(named: placeholderImageName)
                
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            imageCache.setObject(image, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()

    }
}

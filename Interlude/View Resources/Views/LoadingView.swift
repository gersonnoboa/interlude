//
//  LoadingView.swift
//  Interlude
//
//  Created by Gerson Noboa on 03/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    @IBOutlet weak var loadingContainerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = Constants.backgroundColor
        loadingContainerView.layer.cornerRadius = 20
        loadingContainerView.clipsToBounds = true
        loadingContainerView.layer.borderWidth = 1.0
        loadingContainerView.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
        loadingIndicator.startAnimating()
    }
}

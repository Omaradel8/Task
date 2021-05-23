//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by Aya on 10/27/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class FoodLandAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor     = .white
        layer.cornerRadius  = 25
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

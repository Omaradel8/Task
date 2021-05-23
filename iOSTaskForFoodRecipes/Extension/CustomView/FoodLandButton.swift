//
//  GFButton.swift
//  GHFollowers
//
//  Created by Aya on 10/8/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class FoodLandButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title : String , backgroundColor : UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
        
    }
    private func configure() {
        layer.cornerRadius = 20
        titleLabel?.font   = UIFont.preferredFont(forTextStyle: .headline)
        
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func set(backgrounColor: UIColor, title: String){
        self.backgroundColor = backgrounColor
        self.setTitle(title, for: .normal)
    }
}

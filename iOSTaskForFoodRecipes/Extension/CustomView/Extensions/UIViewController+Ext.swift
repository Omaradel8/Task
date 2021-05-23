//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Aya on 10/9/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController{
    
    func presentWaitersAlert(message : String, grayButtonTitle : String, secondButtonTitle : String, alertImage: UIImage, needSecondButton: Bool, first: @escaping (()->()), second: @escaping (()->()))  {
        let alerVC = FoodLandAlertVC(message: message, firstButtonTitle: grayButtonTitle, secondButtonTitle: secondButtonTitle, image: alertImage, needSecondButton: needSecondButton , first: first, second: second)
        alerVC.modalPresentationStyle = .overFullScreen
        alerVC.modalTransitionStyle = .crossDissolve
        self.present(alerVC,animated: true)
    }
}

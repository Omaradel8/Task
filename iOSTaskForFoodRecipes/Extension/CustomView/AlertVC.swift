//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Aya on 10/9/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {
    let containerView   = FoodLandAlertContainerView()
    let alertImage      = UIImageView()
    let messageLabel    = FoodLandBodyLabel(textAlignment: .center)
    let buttonStack     = UIStackView()
    let grayButton      = FoodLandButton(title: "Cancel", backgroundColor: .lightGray)
    let primaryButton   = FoodLandButton(title: "Ok", backgroundColor: UIColor.black)
    
    var alertTitle          : String?
    var message             : String?
    var buttonTitle         : String?
    var secButtonTitle      : String?
    var image               : UIImage?
    let padding             = 20
    var secondButtonNeeded  : Bool?
    var first               : (()->())?
    var second              : (()->())?
    
    init( message: String,firstButtonTitle: String,secondButtonTitle: String,image:UIImage, needSecondButton: Bool, first: @escaping (()->()), second: @escaping (()->())) {
        super.init(nibName: nil, bundle: nil)
        self.message        = message
        self.buttonTitle    = firstButtonTitle
        self.image          = image
        self.secButtonTitle = secondButtonTitle
        self.secondButtonNeeded = needSecondButton
        self.first                  = first
        self.second                 = second
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView,alertImage,buttonStack,messageLabel)
        configurecontainerView()
        configureAlertImage()
        configureButtonStack()
        configureactionButton()
        cinfigureSecondActionButton()
        configuremessageLabel()
    }
    
    
    func configurecontainerView(){
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func configureAlertImage() {
        alertImage.image = image
        alertImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            alertImage.widthAnchor.constraint(equalToConstant: 60),
            alertImage.heightAnchor.constraint(equalToConstant: 60),
            alertImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    
    func configureButtonStack()  {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStack.addArrangedSubview(grayButton)
        buttonStack.addArrangedSubview(primaryButton)
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 20
        
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            buttonStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
            buttonStack.heightAnchor.constraint(equalToConstant: 40),
            buttonStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    func configureactionButton()  {
        grayButton.setTitle(buttonTitle, for: .normal)
        grayButton.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside )
        grayButton.isHidden = !secondButtonNeeded!
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
        
    }
    
    func cinfigureSecondActionButton()  {
        primaryButton.setTitle(secButtonTitle, for: .normal)
        primaryButton.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside )
    }
    
    func configuremessageLabel(){
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: grayButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func firstButtonAction(){
        self.dismiss(animated: true)
        self.first?()
    }
    
    @objc func secondButtonAction(){
        self.dismiss(animated: true)
        self.second?()
    }
}

//
//  ViewController.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 22/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.instance.saveNewItem(title: "Test")
        print(CoreDataManager.instance.fetchHistory())
    }


}


//
//  HomeViewController.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 23/05/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchMessage: UILabel!
    
    var searchHistory: [RecipeHistory]?
    var recipesResult: RecipesResultModel?
    
    var fromItemNumber = 0
    var requestMore: Bool {
        return recipesResult?.more ?? false
    }
    
    var typeOfView: TypeOfView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


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
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            searchTextField.delegate = self
            searchTextField.returnKeyType = .search
        }
    }
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchMessage: UILabel!
    
    var searchHistory: [RecipeHistory]?{
        didSet{
            if searchHistory?.count == 0 {
                tableView.isHidden = true
                searchView.isHidden = false
            }else{
                tableView.isHidden = false
                searchView.isHidden = true
            }
        }
    }
    var recipesResult: RecipesResultModel?{
        didSet{
            if recipesResult?.hits?.count == 0 {
                tableView.isHidden = true
                searchView.isHidden = false
            }else{
                tableView.isHidden = false
                searchView.isHidden = true
            }
        }
    }
    
    var fromItemNumber = 0
    var requestMore: Bool {
        return recipesResult?.more ?? false
    }
    
    var typeOfView: TypeOfView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search For Recipe"
    }
}


//
//  RecipeDetailsViewController.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 24/05/2021.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var recipeDetailsTableView: UITableView!{
        didSet{
            recipeDetailsTableView.delegate = self
            recipeDetailsTableView.dataSource = self
        }
    }
    
    var recipeId: String?
    var recipeDetails: Recipe?
    var vc = AppStoryboard.RecipeDetails.viewController(viewControllerClass: HeaderDetailsView.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        recipeDetailsTableView.reloadData()
        configureHeader()
    }
    
    private func setupHeader() {
        addChild(vc)
        headerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        vc.view.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0).isActive = true
    }

    private func configureHeader() {
        vc.recipeImage.load(url: URL(string: recipeDetails?.image ?? "")!)
        vc.recipeTitle.text = recipeDetails?.label
    }
}

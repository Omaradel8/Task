//
//  Home+Api.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 24/05/2021.
//

import UIKit

extension HomeViewController {
    func getRecipes(q: String) {
        RecipesResultModel.getRecipesResult(q: q, from: fromItemNumber == 0 ? fromItemNumber : (fromItemNumber + 1), to: fromItemNumber == 0 ? (fromItemNumber + 10) : ((fromItemNumber + 1)) + 10) { [weak self] result in
            switch result {
            case .success(let data):
                if self?.recipesResult != nil {
                    self?.recipesResult?.hits?.append(contentsOf: data.hits!)
                    self?.tableView.stopSpinner()
                }else{
                    self?.recipesResult = data
                }
                self?.typeOfView = .newResult
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

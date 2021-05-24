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
                if (data.hits?.count ?? 0) > 0 {
                    CoreDataManager.instance.saveNewItem(title: self?.searchTextField.text ?? "")
                }
                self?.typeOfView = .newResult
                self?.tableView.reloadData()
            case .failure(let error):
                if error == .decodingError {
                    self?.presentAlert(message: "Response Was in invalide Format", grayButtonTitle: "", secondButtonTitle: NSLocalizedString("Ok", comment: ""), alertImage: UIImage(named: "90")!, needSecondButton: false, first: {}, second: {})
                }else if error == .domainError {
                    self?.presentAlert(message: "Server Error", grayButtonTitle: "", secondButtonTitle: NSLocalizedString("Ok", comment: ""), alertImage: UIImage(named: "90")!, needSecondButton: false, first: {}, second: {})
                }else{
                    self?.presentAlert(message: "URL is Invalid", grayButtonTitle: "", secondButtonTitle: NSLocalizedString("Ok", comment: ""), alertImage: UIImage(named: "90")!, needSecondButton: false, first: {}, second: {})
                }
            }
        }
    }
}

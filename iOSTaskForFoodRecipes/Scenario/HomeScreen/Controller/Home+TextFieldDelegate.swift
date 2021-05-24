//
//  Home+TextFieldDelegate.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 24/05/2021.
//

import UIKit

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            self.recipesResult = nil
            self.fromItemNumber = 0
            self.searchHistory = CoreDataManager.instance.fetchHistory()
            self.typeOfView = .history
            tableView.reloadData()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            self.searchHistory = CoreDataManager.instance.fetchHistory()
            self.recipesResult = nil
            self.fromItemNumber = 0
            self.typeOfView = .history
            tableView.isHidden = false
            searchView.isHidden = true
            tableView.reloadData()
        }else{
            tableView.isHidden = true
            searchView.isHidden = false
            searchMessage.text = "Find Your Recipe"
            self.searchHistory = nil
            self.recipesResult = nil
            self.fromItemNumber = 0
            self.typeOfView = .history
            tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getRecipes(q: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}

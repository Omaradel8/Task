//
//  Home+TableDelegate.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 23/05/2021.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeOfView == TypeOfView.history {
            return searchHistory?.count ?? 0
        }else{
            return recipesResult?.hits?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if typeOfView == TypeOfView.history {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
            cell.configure(data: searchHistory?[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
            cell.configure(data: recipesResult?.hits?[indexPath.row])
            return cell
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y        //how you scrolled up and down
        let contentHeight = scrollView.contentSize.height     // entire scrollview
        let height        = scrollView.frame.size.height      //height of your screen
        
        if offsetY > contentHeight - (height + 250) {
            if requestMore{
                fromItemNumber += 10
                self.tableView.startSpinnerIndicator()
                getRecipes(q: self.searchTextField.text ?? "")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if typeOfView == TypeOfView.history {
            searchTextField.text = searchHistory?[indexPath.row].title
            searchTextField.endEditing(true)
            tableView.isHidden = true
            getRecipes(q: searchTextField.text ?? "")
        }else{
            let vc = AppStoryboard.RecipeDetails.viewController(viewControllerClass: RecipeDetailsViewController.self)
            vc.recipeDetails = self.recipesResult?.hits?[indexPath.row].recipe
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

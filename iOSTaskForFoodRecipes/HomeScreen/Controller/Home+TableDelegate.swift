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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ((recipesResult?.count ?? 0) - 1), requestMore{
            
        }
    }
}

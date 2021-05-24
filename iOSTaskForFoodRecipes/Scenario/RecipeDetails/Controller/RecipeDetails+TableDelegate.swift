//
//  RecipeDetails+TableDelegate.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 24/05/2021.
//

import UIKit
import SafariServices

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipeDetails?.ingredients?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as! ingredientsCell
        if indexPath.row < recipeDetails?.ingredients?.count ?? 0{
            cell.ingredientLabel.text = recipeDetails?.ingredients?[indexPath.row].text
            cell.ingredientLabel.textColor = .black
        }else{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.underlineColor: UIColor.blue.cgColor] as [NSAttributedString.Key : Any]
            let underlineAttributedString = NSAttributedString(string: recipeDetails?.source ?? "", attributes: underlineAttribute)
            cell.ingredientLabel.attributedText = underlineAttributedString
            cell.ingredientLabel.textColor = .blue
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= recipeDetails?.ingredients?.count ?? 0 {
            let url = recipeDetails?.url ?? ""
            if let url = URL(string: url) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                self.present(vc, animated: true)
            }
        }
    }
}

extension RecipeDetailsViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}

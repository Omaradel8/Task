//
//  ItemCell.swift
//  iOSTaskForFoodRecipes
//
//  Created by Omar on 23/05/2021.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemSource: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: Hit?) {
        itemImage.load(url: URL(string: data?.recipe?.image ?? "")!)
        itemTitle.text = data?.recipe?.label
        itemSource.text = data?.recipe?.source
        healthLabel.text = data?.recipe?.healthLabels?.joined(separator: ", ")
    }
}

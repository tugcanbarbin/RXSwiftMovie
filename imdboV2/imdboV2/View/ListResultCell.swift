//
//  ListResultCell.swift
//  imdboV2
//
//  Created by Tugcan barbin on 3/9/23.
//

import Foundation
import UIKit

class ListResultCell: UITableViewCell {
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var nameAndYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public var item: SearchResult!
    {
        didSet{

            DispatchQueue.global().async
            {
                let data = try! Data(contentsOf: URL(string: self.item.poster)!) //arka planda calisacak, multi threding ***
                        
                DispatchQueue.main.async
                {
                    self.filmImageView.image = UIImage(data: data)
                }
            }
            
            self.nameAndYearLabel.text = item.title + " "  + item.year

        }
    }

}


//
//  DisconnectionsCell.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 03/11/2022.
//

import UIKit

class DisconnectionsCell: UITableViewCell {
    
    struct ViewModel {
        let time:String
        let occurrences:String
        
    }
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var occurrencesLabel: UILabel!
    static let nibName = "DisconnectionsCell"
    static let cellReuseIdentifier = "DisconnectionsCell"
    static var cellHeight:CGFloat = 30
    
    
    static var registerCell:UINib {
        let uiNib = UINib(nibName: nibName, bundle: nil)
        return uiNib
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
    
    //MARK:Set data to each cell
    func setup(data:ViewModel) {
        timeLabel.text = data.time
        occurrencesLabel.text = data.occurrences
        
        
        
    }
}

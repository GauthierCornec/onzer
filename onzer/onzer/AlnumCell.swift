//
//  AlnumCell.swift
//  onzer
//
//  Created by Merwan Laouini on 06/04/2022.
//

import UIKit

class AlnumCell: UITableViewCell {
    
    @IBOutlet weak var SongName: UILabel!
    @IBOutlet weak var AlbumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  MapTableViewCell.swift
//  SplitViewControllerTest
//
//  Created by kokome maxkit on 2020/4/20.
//  Copyright © 2020 fredshao. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var mapFunctionName: UILabel!
    @IBOutlet weak var indicatorImage: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - Public Methods

extension MapTableViewCell {
    func updateCell(_ type: MapFunctionType) {
        switch type {
            
        case .ELECTR_FENCE:
            mapFunctionName.text = str_map_electrFence
            
        case .REAL_TIME_POSITION:
            mapFunctionName.text = str_map_realTimePositioning
            
        case .TEMPORARY_GROUP:
            mapFunctionName.text = str_map_temporaryGroup
        }
    }
}

// MARK: - Private Methods

extension MapTableViewCell {
    private func updateUI() {
        indicatorImage.image = UIImage(named: "icon_next")
    }
}

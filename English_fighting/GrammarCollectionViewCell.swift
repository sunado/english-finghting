//
//  GrammarCollectionViewCell.swift
//  English_fighting
//
//  Created by sunado on 8/3/17.
//  Copyright © 2017 hnc. All rights reserved.
//

import UIKit

class GrammarCollectionViewCell: UICollectionViewCell {
    var delegate :GrammarAnswerDelegate?
    @IBOutlet weak var wordButton: UIButton!
    var index: Int?
    @IBAction func perform(_ sender: UIButton) {
        self.wordButton.setTitleColor( UIColor.cyan, for: .normal)
        if let index = index {
            delegate?.send(result: index)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

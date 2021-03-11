//
//  AddMedicationTableCell.swift
//  RelaxNow
//
//  Created by Pritrum on 06/03/21.
//

import UIKit

class AddMedicationTableCell: UITableViewCell {
    @IBOutlet weak var perDayCountTextField: UITextField!
    
    @IBOutlet weak var numberOfDayCountTextField: UITextField!
    @IBOutlet weak var addNoteTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    
    
    private func setUpUI(){
        perDayCountTextField.layer.masksToBounds = true
        addNoteTextField.layer.masksToBounds = true
        perDayCountTextField.layer.masksToBounds = true

        perDayCountTextField.layer.borderColor = UIColor.systemGray.cgColor
        numberOfDayCountTextField.layer.borderColor = UIColor.systemGray.cgColor
        addNoteTextField.layer.borderColor = UIColor.systemGray.cgColor
        perDayCountTextField.layer.borderWidth = 1
        numberOfDayCountTextField.layer.borderWidth = 1
        addNoteTextField.layer.borderWidth = 1


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

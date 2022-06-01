//
//  ViewTextFieldTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit

class ViewTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var vBorderTf: UIView!
    @IBOutlet weak var tfEnter: UITextField!
    
    var dict : [Dict] = []
    var getString = ""
    var str  = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorderTF()
        tfEnter.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setBorderTF() {
        vBorderTf.layer.cornerRadius = 15
        vBorderTf.layer.shadowOffset = CGSize(width: 0, height: 4)
        vBorderTf.layer.shadowOpacity = 0.3
        vBorderTf.layer.shadowColor = UIColor.gray.cgColor
//        vBorderTf.layer.masksToBounds = true
    }
    
    func setPlaceHolder(string: String) {
        tfEnter.placeholder = string
        str = string
    }
    
}
extension ViewTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Get Data textField
        getString = textField.text ?? ""
        for i in 0..<dict.count {
            if dict[i].index == str {
                dict[i].value = getString
            }
        }
//        print("did Edit")
//        print("DID \(dict[0].value)")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

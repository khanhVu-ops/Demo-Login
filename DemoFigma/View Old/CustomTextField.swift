//
//  CustomTextField.swift
//  DemoFigma
//
//  Created by KhanhVu on 4/11/22.
//

import UIKit
protocol CustomTextFieldDelegate{
    func textFieldDidDelete(_ textField: CustomTextField)
}
class CustomTextField: UITextField {
    
    var myCustomTextFieldDelegate : CustomTextFieldDelegate?
    var check : Bool = true
    override func deleteBackward() {
        super.deleteBackward()


        if let custom = myCustomTextFieldDelegate {
            custom.textFieldDidDelete(self)
            
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

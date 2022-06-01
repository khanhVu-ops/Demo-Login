//
//  OTPViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 4/12/22.
//

import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var OTPView: UIView!
    @IBOutlet weak var resendBtn: UIButton!
    
    var diction : [Dict] = []
    var arrayTF : [CustomTextField] = []
    var indexTF: Int = 0
    var check = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(diction[0].value)
        
        setKeyboard()
        initSetUp()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:))))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
            self?.arrayTF[0].becomeFirstResponder()

        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        underline1.frame = CGRect(x: CGFloat, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//    }
    
    
    
    func initSetUp() {
        OTPView.backgroundColor = UIColor.black
        
        let underline1 = UIView(frame: CGRect(x: 0, y: OTPView.frame.height, width: 52, height: 1))
        let underline2 = UIView(frame: CGRect(x: 92, y: OTPView.frame.height, width: 52, height: 1))
        let underline3 = UIView(frame: CGRect(x: 182, y: OTPView.frame.height, width: 52, height: 1))
        let underline4 = UIView(frame: CGRect(x: 272, y: OTPView.frame.height, width: 52, height: 1))
        
        underline1.backgroundColor = .white
        underline2.backgroundColor = .white
        underline3.backgroundColor = .white
        underline4.backgroundColor = .white

        OTPView.addSubview(underline1)
        OTPView.addSubview(underline2)
        OTPView.addSubview(underline3)
        OTPView.addSubview(underline4)
        
        let code1TF = CustomTextField(frame: CGRect(x: 0, y: 0, width: 52, height: 43))
        let code2TF = CustomTextField(frame: CGRect(x: 92, y: 0, width: 52, height: 43))
        let code3TF = CustomTextField(frame: CGRect(x: 182, y: 0, width: 52, height: 43))
        let code4TF = CustomTextField(frame: CGRect(x: 272, y: 0, width: 52, height: 43))
        
        arrayTF = [code1TF, code2TF, code3TF, code4TF]
        
        setAttributeTf(arrayTF)
        
        OTPView.addSubview(code1TF)
        OTPView.addSubview(code2TF)
        OTPView.addSubview(code3TF)
        OTPView.addSubview(code4TF)
        
        
        
        //toolBar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
           //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
     
        toolbar.setItems([flexSpace, doneBtn], animated: false)
       
           
        toolbar.sizeToFit()
           //setting toolbar as inputAccessoryView
        code1TF.inputAccessoryView = toolbar
        code2TF.inputAccessoryView = toolbar
        code3TF.inputAccessoryView = toolbar
        code4TF.inputAccessoryView = toolbar  
        
    }
    
    @objc func doneButtonAction() {
       self.view.endEditing(true)
    }
    
    func setAttributeTf(_ textfield: [CustomTextField]) {
        textfield.enumerated().forEach({ index, tf in
            tf.textAlignment = .center
            tf.textColor = .white
            tf.keyboardType = .numberPad
            tf.myCustomTextFieldDelegate = self
            tf.delegate = self
            tf.tag = index+1
        })
        
    }

    @IBAction func didTapCancel(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setKeyboard() {
        resendBtn.layer.cornerRadius = 10
      NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)


    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        
        if let keyBoardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyBoardHeight = keyBoardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (resendBtn.frame.origin.y + resendBtn.frame.height + 10)
            
//            print(bottomSpace)
            print(resendBtn.bounds.height)
            print(self.view.frame.maxY)
            print(self.view.convert(CGPoint(x: 0, y: self.view.frame.maxY), to: resendBtn).y - resendBtn.bounds.height)

            let space = keyBoardHeight-bottomSpace

            let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0

                    // Animation cho việc đẩy CommentView lên
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
                if keyBoardHeight > bottomSpace && self.view.frame.origin.y == 0 {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -space)
                }

            }, completion: nil)
            
        }
        
        
    }
    @objc func keyBoardWillHide(notification: NSNotification) {
        let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0

                // Animation cho việc đẩy CommentView lên
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
}

extension OTPViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if arrayTF[3].text?.count != 0 {
            check = false
            DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
                            self?.arrayTF[3].becomeFirstResponder()
            }
        }
        for i in 0...3 {
            if arrayTF[i].text?.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
                    self?.arrayTF[i].becomeFirstResponder()

                }
                break

            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        let nextTag = textField.tag + 1
        if nextTag == 5 && textField.text?.count == 1 && string.count == 1  {
            textField.text = string
            textField.superview?.viewWithTag(4)?.resignFirstResponder()
        }
        if textField.text?.count == 0 && string.count == 1 {
            
            textField.text = string
            if nextTag == 5 {
                textField.superview?.viewWithTag(4)?.resignFirstResponder()
            }
            else {
                textField.superview?.viewWithTag(nextTag)?.becomeFirstResponder()
            }
            
        }
        return true
    }
}

extension OTPViewController: CustomTextFieldDelegate {
    func textFieldDidDelete(_ textField: CustomTextField) {
        var index = textField.tag - 1
        print("index: \(index)")
        if(textField.text?.count == 0) {
            print("NIL")
            index = index - 1
            if index>=0  && check {
                arrayTF[index].text = ""
                arrayTF[index].becomeFirstResponder()

            } else if !check {
                check = true
            }
            
            

        }
    }
}

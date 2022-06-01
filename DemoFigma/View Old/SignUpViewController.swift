//
//  SignUpViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 4/10/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var enterNumberTF: UITextField!
    
    @IBOutlet weak var enterNameTF: UITextField!
    
    @IBOutlet weak var enterCityTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var indexTf: Int = 0
    var arrayTf: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initSetUp()
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self)
//    }
    private func setupViews() {
        arrayTf = [enterNumberTF, enterNameTF, enterCityTF]
        
        signUpBtn.layer.cornerRadius = 10
        signUpBtn.layer.backgroundColor = UIColor.gray.cgColor
        setUpKeyboard()
        layerViewSignUp()
        
        arrayTf.forEach({
            $0.delegate = self
            layerTextField($0)
        })
    }
    
    
    func layerViewSignUp() {
        viewSignUp.layer.cornerRadius = 20
        viewSignUp.layer.borderColor = UIColor.gray.cgColor
        viewSignUp.layer.shadowColor = UIColor.black.cgColor
        viewSignUp.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        viewSignUp.layer.shadowOpacity = 0.5
        viewSignUp.layer.shadowRadius = 20
        
    }
    
    func layerTextField(_ textField: UITextField) {
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.attributedPlaceholder?.accessibilityFrame = CGRect(x: 20, y: 0, width: textField.frame.width, height: textField.frame.height)
        
    }
    
    func initSetUp() {
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: inputAccessoryView
    
    func setUpKeyboard() {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 40))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        let nextBT = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(didTapNextBT))
        
        let previousBT = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(didTapPreviousBT))
        
        nextBT.width = 30
        previousBT.width = 30
        toolbar.setItems([previousBT, nextBT, flexSpace, doneBtn], animated: false)
        
        
        arrayTf.forEach({
            $0.inputAccessoryView = toolbar
        })
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    @objc func didTapNextBT() {
        
        if indexTf < arrayTf.count-1 {
            indexTf += 1
            arrayTf[indexTf].becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        
    }
    @objc func didTapPreviousBT() {
        
        if indexTf > 0 {
            indexTf -= 1
            arrayTf[indexTf].becomeFirstResponder()
        }
        
    }
    
    //MARK: Keyboard
    @objc func hideKeyBoard() {
        self.view.endEditing(true)
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
    
        if let keyBoardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyBoardHeight = keyBoardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (viewSignUp.frame.origin.y + signUpBtn.frame.origin.y + signUpBtn.frame.height + 10)
            
            let space = (keyBoardHeight-bottomSpace)
            
            let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            
            // Animation cho việc đẩy CommentView lên
            UIView.animate(withDuration: animationDuration, delay: 2, options: .curveEaseOut, animations: {
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
    
    //MARK: UIAction
    
    @IBAction func didTapBtnSignUp(_ sender: Any) {
        view.endEditing(true)
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        self.navigationController?.show(vc, sender: nil)
    }
    
}

//MARK: UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for i in 0..<arrayTf.count {
            if textField == arrayTf[i] {
                indexTf = i
                break
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case enterNumberTF:
            enterNameTF.becomeFirstResponder()
        case enterNameTF:
            enterCityTF.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            
        }
        return false
    }
}

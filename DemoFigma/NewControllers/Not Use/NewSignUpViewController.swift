//
//  NewSignUpViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit

class NewSignUpViewController: UIViewController {

    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfSelectType: UITextField!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var vFirstName: UIView!
    @IBOutlet weak var vLastName: UIView!
    @IBOutlet weak var vSelectType: UIView!
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vPassword: UIView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContentView()
        setKeyboard()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:))))
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    func setUpViewTF(view: UIView) {
        view.layer.cornerRadius = 15
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
    }
    func setUpContentView() {
        setUpViewTF(view: vFirstName)
        setUpViewTF(view: vLastName)
        setUpViewTF(view: vSelectType)
        setUpViewTF(view: vEmail)
        setUpViewTF(view: vPassword)
        
        btnSubmit.layer.cornerRadius = 20
    }
    
    func setKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)


    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        
        if let keyBoardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyBoardHeight = keyBoardFrame.cgRectValue.height
//            let bottomSpace = self.view.frame.height - (resendBtn.frame.origin.y + resendBtn.frame.height + 10)
//
////            print(bottomSpace)
//            print(resendBtn.bounds.height)
//            print(self.view.frame.maxY)
            let bottomSpace = self.view.convert(CGPoint(x: 0, y: self.view.frame.maxY), to: btnSubmit).y - btnSubmit.bounds.height

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

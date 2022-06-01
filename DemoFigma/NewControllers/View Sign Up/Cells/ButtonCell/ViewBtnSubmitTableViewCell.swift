//
//  ViewBtnSubmitTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit
import FBSDKLoginKit
class ViewBtnSubmitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbFacebook: UILabel!
    @IBOutlet weak var vLoginFB: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var array: [String] = []
    var dict: [Dict] = []
    var controller = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnSubmit.layer.cornerRadius = 20
        btnSubmit.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnSubmit.layer.shadowColor = UIColor.gray.cgColor
        btnSubmit.layer.shadowOpacity = 0.3
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateButton(isLoggedIn: Bool) {
        // Update Label in button login
        let title = isLoggedIn ? "Log out 👋🏻" : "Log in 👍🏻"
        lbFacebook.text = title
    }
    
    @IBAction func didTapBtnLoginWithFB(_ sender: Any) {
        let loginManager = LoginManager()
        
        
        if let _ = AccessToken.current {
            //Log out fb
            loginManager.logOut()
            print("Log out FB")

            
        } else {
            // Login Fb
            loginManager.logIn(permissions: [], from: controller) { [weak self] (result, error) in
                
                // 4
                // Check for error
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    return
                }
                
                // 5
                // Check for cancel
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
            // Login successfully
                let st = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = st.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
                self?.controller.navigationController?.pushViewController(vc, animated: true)
                
                self?.updateButton(isLoggedIn: true)
                    
            }
        }
    }
        @IBAction func didTapBtnSubmit(_ sender: Any) {
            print("submit")
            let st = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = st.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            vc.diction = dict
            controller.navigationController?.pushViewController(vc, animated: true)
        }
    }

//
//  SignUpTableViewViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit
import FBSDKLoginKit
class SignUpTableViewViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var dicData: [Dict] = [Dict(index: "First Name", value: ""), Dict(index: "Last Name", value: ""), Dict(index: "Select User Type", value: ""), Dict(index: "E-mail Address", value: ""), Dict(index: "Password", value: "")]
    
    let arrayPlaceHolder = ["First Name", "Last Name", "Select User Type", "E-mail Address", "Password"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = AccessToken.current,!token.isExpired {
            // Code
        }
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:))))
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // Register Cell
        myTableView.register(UINib(nibName: "ViewTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewTextFieldTableViewCell")
        myTableView.register(UINib(nibName: "ViewBtnSubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewBtnSubmitTableViewCell")
    }
    

}

extension SignUpTableViewViewController: UITableViewDelegate {
    
    
}
extension SignUpTableViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell TextField
        let cell = myTableView.dequeueReusableCell(withIdentifier: "ViewTextFieldTableViewCell", for: indexPath) as! ViewTextFieldTableViewCell
        if indexPath.row < 5 {
            let data = arrayPlaceHolder[indexPath.row]
            cell.dict = dicData
            cell.setPlaceHolder(string: data)
        }
        else if indexPath.row == 5 {
            
            // Cell buttons
            let cell = myTableView.dequeueReusableCell(withIdentifier: "ViewBtnSubmitTableViewCell", for: indexPath) as! ViewBtnSubmitTableViewCell
            cell.controller = self
            cell.dict = dicData
            return cell
        }
        return cell
        
        
    }
}

extension SignUpTableViewViewController: UITextFieldDelegate {
    //Estimated
}



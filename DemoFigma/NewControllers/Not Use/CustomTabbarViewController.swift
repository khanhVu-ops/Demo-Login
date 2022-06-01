//
//  CustomTabbarViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit

class CustomTabbarViewController: UIViewController {

    @IBOutlet weak var vContent: UIView!
   
    @IBOutlet weak var vLineSignUp: UIView!
    @IBOutlet weak var vLineSignIn: UIView!
    
    @IBOutlet weak var myPageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentView()
        myPageControl.currentPage = 0
        myPageControl.numberOfPages = 2
        // Do any additional setup after loading the view.
    }
    func setContentView() {
        
        updateColorLineView(view1: vLineSignIn, view2: vLineSignUp)
        
    }
    
    func updateColorLineView(view1: UIView, view2: UIView) {
        view1.backgroundColor = .blue
        view2.backgroundColor = .white
    }
    
    
    
    @IBAction func didTapBtnSignUp(_ sender: Any) {
        updateColorLineView(view1: vLineSignUp, view2: vLineSignIn)
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "SignUpTableViewViewController") as! SignUpTableViewViewController
        
        myPageControl.addSubview(vc.view)
        
        
                   
    }
    
    @IBAction func didTapBtnSignIn(_ sender: Any) {
       
        updateColorLineView(view1: vLineSignIn, view2: vLineSignUp)
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

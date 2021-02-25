//
//  SideMenuViewController.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 2/24/21.
//

import UIKit
import FirebaseAuth


class SideMenuViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
        Utilities.styleHeaderLabel(headerLabel)
        Utilities.styleFilledButton(logoutBtn)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        do
        {
            print("signing out")
            try Auth.auth().signOut()

        }
        catch let error as NSError
        {
            self.showError(message: error.localizedDescription)
        }
    }
    

}

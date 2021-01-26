//
//  Extensions.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 1/26/21.
//

import Foundation
import UIKit
import SideMenu

extension UIViewController {
    func navigationBarSetup() {
        //Set title
        let label = UILabel()
        label.text = "Heartadvisor"
        let title = UIBarButtonItem(customView: label)
        navigationItem.leftItemsSupplementBackButton = true
        
        //Set sidemenu bar button
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(sideMenuTapped))
        
        navigationItem.leftBarButtonItems = [menuButton, title]

    }
    
    @objc func sideMenuTapped() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenu") as! SideMenuNavigationController
        
        present(menu, animated: true, completion: nil)
    }
}

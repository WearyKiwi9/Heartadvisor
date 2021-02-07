//
//  ExerciseViewController.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 1/26/21.
//

import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationBarSetup()
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleSubHeaderLabel(tempLabel)
    }

}

//
//  MentalSettingsViewController.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 2/18/21.
//

import UIKit
import TagListView

class MentalSettingsViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    var tagArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tagListView.addTags(["Relax", "Energetic", "Flow", "Energy Healing"])
        tagListView.textFont = UIFont(name: Constants.largeFont, size: CGFloat(Constants.largeFontSize))!;
        tagListView.delegate = self
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if(tagView.isSelected == true) {
            tagView.isSelected = false
            if let index = tagArray.firstIndex(of: title) {
                tagArray.remove(at: index)
            }
        } else {
            tagView.isSelected = true
            tagArray.append(title)
        }
    }

    override func viewDidLayoutSubviews() {
        Utilities.styleSubHeaderLabel(durationLabel)
        Utilities.styleSubHeaderLabel(genresLabel)
    }

}

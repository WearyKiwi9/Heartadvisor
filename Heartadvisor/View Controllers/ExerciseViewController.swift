//
//  ExerciseViewController.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 1/26/21.
//

import UIKit

class exerciseCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
}

class ExerciseViewController: UIViewController {
    
    @IBOutlet weak var recommendedLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var lowerLabel: UILabel!
    @IBOutlet weak var coreLabel: UILabel!
    
    @IBOutlet weak var recommendedView: UICollectionView!
    @IBOutlet weak var newView: UICollectionView!
    @IBOutlet weak var upperView: UICollectionView!
    @IBOutlet weak var lowerView: UICollectionView!
    @IBOutlet weak var coreView: UICollectionView!
    
    let recommendedTitles = ["Rec 1","Rec 2", "Rec 3", "Rec 4", "Rec 5"]
    let newTitles = ["New 1","New 2", "New 3", "New 4", "New 5"]
    let upperTitles = ["Upper 1","Upper 2", "Upper 3", "Upper 4", "Upper 5"]
    let lowerTitles = ["Lower 1","Lower 2", "Lower 3", "Lower 4", "Lower 5"]
    let coreTitles = ["Core 1","Core 2", "Core 3", "Core 4", "Core 5"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        
        recommendedView.dataSource = self
        recommendedView.delegate = self
        
        newView.dataSource = self
        newView.delegate = self
        
        upperView.dataSource = self
        upperView.delegate = self
        
        lowerView.dataSource = self
        lowerView.delegate = self
        
        coreView.dataSource = self
        coreView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        
        Utilities.styleSubHeaderLabel(recommendedLabel)
        Utilities.styleSubHeaderLabel(newLabel)
        Utilities.styleSubHeaderLabel(upperLabel)
        Utilities.styleSubHeaderLabel(lowerLabel)
        Utilities.styleSubHeaderLabel(coreLabel)
    }
}

extension ExerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exerciseCell", for: indexPath) as? exerciseCell
                
        Utilities.styleParagraphLabel((cell?.title)!)
                
        var imageString = ""
        
        if(collectionView == recommendedView) {
            cell?.title.text = recommendedTitles[indexPath.row]
        }
        else if(collectionView == newView) {
            cell?.title.text = newTitles[indexPath.row]
        }
        else if(collectionView == upperView) {
            cell?.title.text = upperTitles[indexPath.row]
        }
        else if(collectionView == lowerView) {
            cell?.title.text = lowerTitles[indexPath.row]
        }
        else if(collectionView == coreView) {
            cell?.title.text = coreTitles[indexPath.row]
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child(imageString)

        // Fetch the download URL
        imageRef.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print(error)
            } else {
                cell?.img.kf.indicatorType = .activity
                cell?.img.kf.setImage(with: url)
            }
                
            return cell!
        }
    }
}

//
//  ExerciseViewController.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 1/26/21.
//

import UIKit
import FirebaseStorage
import Kingfisher

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
    
    let recommendedTitles = ["Rec 1","Rec 2", "Rec 3", "Rec 4", "Rec 5", "Rec 6"]
    let newTitles = ["15 Min TikTok Dance Party Workout","30 Min Cardio Kickboxing Workout", "20 Min Zumba Workout", "30 Min At Home Pilates Workout"]
    let upperTitles = ["Dumbbell Only Total Upper Body","Full Upper Body Workout Routine Using Dumbbells Only", "Intense At Home Upper Body Workout (No Equipment)", "15 Minute Upper Body Workout (No Equipment)", "20 Minute Upper Body Dumbbell Workout", "30 Minute Upper Body Workout (No Equipment)"]
    let lowerTitles = ["15 Min At Home Leg/Butt/Thigh Workout (No Equipment)","15 Min Toned Legs & Round Booty Workout With Dumbbells", "No Repeat Leg Workout With Dumbbells", "20 Min Lower Body Workout (No Equipment)", "30 Min Killer Lower Body HIIT Workout (No Equipment)", "Lower Body Workout With Dumbbells"]
    let coreTitles = ["10 Min Bodyweight Ab Workout (No Equipment)","15 Min Dumbbell Abs Workout", "20 Min Total Core/Ab Workout (No Equipment)", "Best Dumbbell Exercises for Abs", "30 Min Core Workout (No Equipment)"]
    
    let recommendedImgs = ["", "", "", "", "", ""]
    let newImgs = ["exercise/newWorkouts/newworkout1.jpg", "exercise/newWorkouts/newworkout2.jpg", "exercise/newWorkouts/newworkout3.jpg", "exercise/newWorkouts/newworkout4.jpg"]
    let upperImgs = ["exercise/upperBody/yesEquip/upperbody_yesequip1.jpg", "exercise/upperBody/yesEquip/upperbody_yesequip2.jpg", "exercise/upperBody/noEquip/upperbody_noequip1.jpg", "exercise/upperBody/noEquip/upperbody_noequip2.jpg", "exercise/upperBody/yesEquip/upperbody_yesequip3.jpg", "exercise/upperBody/noEquip/upperbody_noequip3.jpg"]
    let lowerImgs = ["exercise/lowerBody/noEquip/lowerbody_noequip1.jpg", "exercise/lowerBody/yesEquip/lowerbody_yesequip1.jpg", "exercise/lowerBody/yesEquip/lowerbody_yesequip2.jpg", "exercise/lowerBody/noEquip/lowerbody_noequip2.jpg", "exercise/lowerBody/noEquip/lowerbody_noequip3.jpg", "exercise/lowerBody/yesEquip/lowerbody_yesequip3.jpg"]
    let coreImgs = ["exercise/core/noEquip/core_noequip1.jpg", "exercise/core/yesEquip/core_yesequip1.jpg", "exercise/core/noEquip/core_noequip2.jpg", "exercise/core/yesEquip/core_yesequip2.jpg", "exercise/core/noEquip/core_noequip3.jpg",""]
    
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
        if(collectionView == coreView) {
            return 5
        }
        else if(collectionView == newView) {
            return 4
        }
        else if(collectionView == recommendedView) {
            return 1
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exeCell", for: indexPath) as? exerciseCell
                
        Utilities.styleParagraphLabel((cell?.title)!)
                
        var imageString = ""
        
        if(collectionView == recommendedView) {
            cell?.title.text = recommendedTitles[indexPath.row]
            imageString = newImgs[indexPath.row]
        }
        else if(collectionView == newView) {
            cell?.title.text = newTitles[indexPath.row]
            imageString = newImgs[indexPath.row]
        }
        else if(collectionView == upperView) {
            cell?.title.text = upperTitles[indexPath.row]
            imageString = upperImgs[indexPath.row]
        }
        else if(collectionView == lowerView) {
            cell?.title.text = lowerTitles[indexPath.row]
            imageString = lowerImgs[indexPath.row]
        }
        else if(collectionView == coreView) {
            cell?.title.text = coreTitles[indexPath.row]
            imageString = coreImgs[indexPath.row]
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
        }
        
        return cell!
    }
}

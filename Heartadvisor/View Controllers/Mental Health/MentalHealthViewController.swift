//
//  MentalHealthViewController.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 1/26/21.
//

import UIKit
import Kingfisher
import FirebaseStorage
import ImageSlideshow

class meditationCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
}

class MentalHealthViewController: UIViewController {
    @IBOutlet weak var recommendedLabel: UILabel!
    @IBOutlet weak var relaxLabel: UILabel!
    @IBOutlet weak var energeticLabel: UILabel!
    @IBOutlet weak var flowLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    
    @IBOutlet weak var recommendedView: UICollectionView!
    @IBOutlet weak var relaxView: UICollectionView!
    @IBOutlet weak var energeticView: UICollectionView!
    @IBOutlet weak var flowView: UICollectionView!
    @IBOutlet weak var energyView: UICollectionView!
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    let relaxTitles = ["Relaxed Body Relaxed Mind", "Blissful Deep Relaxation", "Let Go & Relax", "10-Minute Meditation For Anxiety", "Sleep Hypnosis for Floating Relaxation"]
    let energeticTitles = ["10 Minute Guided Meditation","Power Check-In [Mindfulness Meditation]", "Positive Energy", "15 Minute Guided Meditation","Chakra Balance"]
    let flowTitles = ["Above & Beyond","Getting into the Flow","Get Into the Flow and Focus", "Guided Visual Meditation", "Arrive"]
    let energyTitles = ["Healing Light", "Soul Energy Alignment","Experience the Pure Loving Energy of the Universe", "Energy Healing", "Reiki Meditation"]
    
    let relaxImgs = ["mentalHealth/Relax/relax1.jpg", "mentalHealth/Relax/relax2.jpg", "mentalHealth/Relax/relax3.jpg", "mentalHealth/Relax/relax4.jpg", "mentalHealth/Relax/relax5.jpg"]
    let energeticImgs = ["mentalHealth/Energetic/energetic1.jpg","mentalHealth/Energetic/energetic2.jpg","mentalHealth/Energetic/energetic3.jpg","mentalHealth/Energetic/energetic4.jpg","mentalHealth/Energetic/energetic5.jpg"]
    let flowImgs = ["mentalHealth/Flow/flow1.jpg","mentalHealth/Flow/flow2.jpg","mentalHealth/Flow/flow3.jpg","mentalHealth/Flow/flow4.jpg","mentalHealth/Flow/flow5.jpg"]
    let energyImgs = ["mentalHealth/Energy_Healing/energy1.jpg","mentalHealth/Energy_Healing/energy2.jpg","mentalHealth/Energy_Healing/energy3.jpg","mentalHealth/Energy_Healing/energy4.jpg","mentalHealth/Energy_Healing/energy5.jpg"]
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetup()
        
        recommendedView.dataSource = self
        recommendedView.delegate = self
        
        relaxView.dataSource = self
        relaxView.delegate = self
        
        energeticView.dataSource = self
        energeticView.delegate = self
        
        flowView.dataSource = self
        flowView.delegate = self
        
        energyView.dataSource = self
        energyView.delegate = self
        
        // Setting up image slideshow
        slideshow.setImageInputs([
            ImageSource(image: UIImage(named: "meditation-quotes-1")!),
            ImageSource(image: UIImage(named: "meditation-quotes-2")!),
            ImageSource(image: UIImage(named: "meditation-quotes-3")!),
            ImageSource(image: UIImage(named: "meditation-quotes-4")!),
            ImageSource(image: UIImage(named: "meditation-quotes-5")!)
        ])
        slideshow.slideshowInterval = 4
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleSubHeaderLabel(recommendedLabel)
        Utilities.styleSubHeaderLabel(relaxLabel)
        Utilities.styleSubHeaderLabel(energyLabel)
        Utilities.styleSubHeaderLabel(energeticLabel)
        Utilities.styleSubHeaderLabel(flowLabel)
    }

}

extension MentalHealthViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "medCell", for: indexPath) as? meditationCell
        
        Utilities.styleParagraphLabel((cell?.title)!)
        
        var imageString = ""
        
        if(collectionView == recommendedView) {
            cell?.title.text = "Recommended"
            
        }
        else if (collectionView == relaxView) {
            cell?.title.text = relaxTitles[indexPath.row]
            imageString = relaxImgs[indexPath.row]
        }
        else if (collectionView == energeticView) {
            cell?.title.text = energeticTitles[indexPath.row]
            imageString = energeticImgs[indexPath.row]
        }
        else if (collectionView == flowView) {
            cell?.title.text = flowTitles[indexPath.row]
            imageString = flowImgs[indexPath.row]
        }
        else if (collectionView == energyView) {
            cell?.title.text = energyTitles[indexPath.row]
            imageString = energyImgs[indexPath.row]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "player") as! PlayerViewController
        
        if(collectionView == recommendedView) {
            
        }
        else if (collectionView == relaxView) {
            vc.name = relaxImgs[indexPath.row];
        }
        else if (collectionView == energeticView) {
            vc.name = energeticImgs[indexPath.row];
        }
        else if (collectionView == flowView) {
            vc.name = flowImgs[indexPath.row];
        }
        else if (collectionView == energyView) {
            vc.name = energyImgs[indexPath.row];
        }
        
        vc.name = String(vc.name.dropLast(3)) + "mp4"

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

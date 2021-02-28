//
//  DietViewController.swift
//  Heartadvisor
//
//  Created by Tejal Patel on 1/26/21.
//

import UIKit

class DietViewController: UIViewController {
    
    
    @IBOutlet weak var cAmount: UITextField!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var cGoal: UILabel!
    @IBOutlet weak var tile1: UIButton!
    @IBOutlet weak var tile2: UIButton!
    @IBOutlet weak var tile3: UIButton!
    @IBOutlet weak var tile4: UIButton!
    
    var cRec = 1000;
    var cProg:Float = 0;
    
    let shapeLayer = CAShapeLayer()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let brightRed = UIColor(displayP3Red: 0.7, green: 1.0, blue: 0.7, alpha: 1.0)
        self.view.backgroundColor = brightRed
        
        cGoal.text = "\(cRec) Calories"
        cGoal.textAlignment = .center
        cGoal.font = cGoal.font.withSize(25)
        cGoal.textColor = UIColor.purple
        
        let center = CGPoint(x:215, y:300)
        
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = center
        
        
        // create track layer
        
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: CGFloat.pi*2, clockwise:true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.position = center
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.magenta.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.position = center
        
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        // view.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(handleTap)))
        
        if cButton.isSelected
        {
            
        }
        else
        {
            handleTap()
        }

        // Do any additional setup after loading the view.
        navigationBarSetup()
        
    }
    
    @objc private func handleTap()
    {
        let cAmountF = (cAmount.text as! NSString).floatValue;
        
        let cRecCG = CGFloat(cRec);
        
        let cAmountCG = CGFloat(cAmountF);
        
        shapeLayer.strokeEnd = CGFloat(cProg) + cAmountCG/cRecCG
        
        cProg = cProg + cAmountF/Float(cRec)
        self.percentageLabel.text = "\(Int(self.cProg * 100))%"
        
        if cProg > 1.0
        {
            shapeLayer.strokeColor = UIColor.red.cgColor
        }
        return
        let basicAnimation = CABasicAnimation(keyPath:"strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(self.cProg * 100)%"
            self.shapeLayer.strokeEnd = 0.5
        }
    }
    
    @IBAction func doSomething(_ sender: Any) {
        
        if cButton.isSelected
        {
            
            
        }
        else
        {
            handleTap()
//            let cAmountF = (cAmount.text as! NSString).floatValue;
//            
//            let cRecF = Float(cRec);
//            
//            cProgress.setProgress(cProgress.progress + cAmountF/cRecF, animated: true);
            
            
        }
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

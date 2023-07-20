//
//  ComentsViewController.swift
//  TimerTest
//
//  Created by Salvador Gómez Moya on 10/07/23.
//

import UIKit

class ComentsViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "yop")
        profileImage.image = image
        profileImage.layer.cornerRadius = profileImage.bounds.size.width / 2.0
        

    }
    

   

}

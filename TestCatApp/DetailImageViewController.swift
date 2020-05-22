//
//  DetailImageViewController.swift
//  TestCatApp
//
//  Created by Alex Stepanov on 21.05.2020.
//  Copyright © 2020 Alex Stepanov. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {
    
    var myTuple: (selectedImage: CollectionViewCell?, imagesName: String?)
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = myTuple.selectedImage!.imageView.image
        
        if let imagesName = myTuple.imagesName {
            navigationItem.title = imagesName
        }
        else {
            navigationItem.title = "Unknown name"
        }
        
    }
    
    
}

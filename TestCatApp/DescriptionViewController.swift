//
//  DescriptionViewController.swift
//  TestCatApp
//
//  Created by Alex Stepanov on 20.05.2020.
//  Copyright © 2020 Alex Stepanov. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var selectedBreed: Cats?
  
    override func viewDidLoad() {

        super.viewDidLoad()
        
        navigationItem.title = selectedBreed!.name
        textView.text = selectedBreed!.description
        textView.isEditable = false
        
    }

}

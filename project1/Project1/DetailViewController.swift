//
//  DetailViewController.swift
//  Project1
//
//  Created by TwoStraws on 12/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView!
	var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

		title = selectedImage

		if let imageToLoad = selectedImage {
			imageView.image  = UIImage(named: imageToLoad)
		}
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
//    func shareTapped(){
//        let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(vc, animated: true, completion: nil)
//    }
    
    func shareTapped(){
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook){
            vc.setInitialText("Look at this great picture!")
            vc.add(imageView.image!)
            vc.add(URL(string: "http://www.photolib.noaa.gov/nssl"))
            present(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

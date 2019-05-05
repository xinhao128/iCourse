//
//  AddPostImageViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/5/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class AddPostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var postTitle: String!
    var postContents: String!
    var tag: String!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 200)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onPostButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["author"] = PFUser.current()!
        post["postTitle"] = self.postTitle
        post["postContents"] = self.postContents
        post["tag"] = self.tag
        post["postedTime"] = Date()
        if imageView.image!.isEqual(UIImage(named: "image_placeholder")) {
            print("no image selected")
        }
        else {
            let imageData = imageView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            post["image"] = file
        }
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error!")
            }
        }
    }
    
}

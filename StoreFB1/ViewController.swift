//
//  ViewController.swift
//  StoreFB1
//
//  Created by Trinidad Garcia on 12/06/18.
//  Copyright © 2018 Trinidad Garcia. All rights reserved.
//

import UIKit
import FirebaseStorage

class ViewController: UIViewController {

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var downloadImage: UIImageView!
    let fileImage = "goku.jpg"
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onUploadTapped(_ sender: UIButton) {
        
        guard let image = uploadImage.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
        let uploadImageRef = imageReference.child(fileImage)
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) {
            (metadata, error) in
            print("upload task finished ")
            print (metadata ?? "No metadata")
            print(error ?? "No error")
        }
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No ore progress")
        }
        uploadTask.resume()
    }
    

    @IBAction func onDownloadTapped(_ sender: UIButton) {
        let downloadImageRef = imageReference.child(fileImage)
        
        let downloadtask = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                self.downloadImage?.image = image
            }
            print(error ?? "no error")
        }
        downloadtask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No more progress")
        }
        downloadtask.resume()
    }
}














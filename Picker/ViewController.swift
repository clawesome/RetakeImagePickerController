//
//  ViewController.swift
//  RetakeImagePickerController
//
//  Created by Chris Law on 10/8/20.
//

import UIKit

class ViewController: UIViewController {

    var picker: RetakeImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = RetakeImagePickerController(retakeDelegate: self)
        picker.sourceType = .camera
    }
    override func viewDidAppear(_ animated: Bool) {
        self.present(picker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        print(image.size)
    }
}

extension ViewController: RetakeImagePickerControllerDelegate {
    func imagePickerRetakingPhoto(_ picker: UIImagePickerController) {
        print("retaking photo")
    }

    func imagePickerUsingPhoto(_ picker: UIImagePickerController) {
        print("using photo")
    }
}

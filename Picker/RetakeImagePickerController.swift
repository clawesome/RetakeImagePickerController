//
//  RetakeImagePickerController.swift
//  RetakeImagePickerController
//
//  Created by Chris Law on 10/8/20.
//

import UIKit

protocol RetakeImagePickerControllerDelegate: UIImagePickerControllerDelegate {
    func imagePickerRetakingPhoto(_ picker: UIImagePickerController)
    func imagePickerUsingPhoto(_ picker: UIImagePickerController)
}

class RetakeImagePickerController: UIImagePickerController {
    var retakeDelegate: RetakeImagePickerControllerDelegate?
    convenience init(retakeDelegate delegate: RetakeImagePickerControllerDelegate) {
        self.init()
        retakeDelegate = delegate
        addCameraObserver()
    }
    // Add observer to know when picture taken
    func addCameraObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTakePicture(_:)) , name: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidCaptureItem"), object: nil)
    }
    @objc func didTakePicture(_ sender: AnyObject) {
        for view in view.subviews {
            setupButtonTargets(view)
        }
    }
    // Recursively iterate through all the subviews until the 'Retake' and 'Use Photo' buttons are found, add target to each
    func setupButtonTargets(_ view: UIView, level: Int = 0) {
        if let button = view as? UIButton, let title = button.titleLabel?.text {
            switch title {
                case "Retake":
                    button.addTarget(self, action: #selector(willRetake(_:)), for: .touchUpInside)
                    break
                case "Use Photo":
                    print(button.allTargets)
                    button.addTarget(self, action: #selector(usingPhoto(_:)), for: .touchUpInside)
                    break
                default:
                    break
            }
        }
        for view in view.subviews {
            setupButtonTargets(view, level: level+1)
        }
    }
    @objc func willRetake(_ sender: UIButton) {
        retakeDelegate?.imagePickerRetakingPhoto(self)
    }
    @objc func usingPhoto(_ sender: UIButton) {
        retakeDelegate?.imagePickerUsingPhoto(self)
    }
}

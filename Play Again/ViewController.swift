//
//  ViewController.swift
//  Play Again
//
//  Created by Caroline Jardim Siqueira on 15/05/2018.
//  Copyright © 2018 Caroline Jardim Siqueira. All rights reserved.
//

import Foundation
import UIKit

class ViewController:
    UIViewController,
    UIGestureRecognizerDelegate {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panPencil = UIPanGestureRecognizer(target: self, action: #selector(drawing))
        panPencil.delegate = self
        view.addGestureRecognizer(panPencil)
        
        let tapPencil = UITapGestureRecognizer(target: self, action: #selector(drawing))
        tapPencil.delegate = self
        view.addGestureRecognizer(tapPencil)
        
        clearButton.backgroundColor = .black
        clearButton.tintColor = .white
        clearButton.layer.cornerRadius = 25
        saveButton.backgroundColor = .black
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 25
    }
    
    @objc func drawing(_ sender: UIPanGestureRecognizer?) {
        let location = sender?.location(in: view)
        let size = CGFloat(10 * drand48())
        let dot = UIView(frame: CGRect(x: location?.x ?? 0.0,
                                       y: location?.y ?? 0.0,
                                       width: size,
                                       height: size))
        dot.clipsToBounds = true
        dot.layer.cornerRadius = size/2
        dot.backgroundColor = randomColor()
        view.addSubview(dot)
    }
    
    @IBAction func clearView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func saveView(_ sender: Any) {
        let screen = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height-120)
        UIGraphicsBeginImageContext(screen.size)
        let ctx = UIGraphicsGetCurrentContext()
        UIApplication.shared.keyWindow?.layer.render(in: ctx!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        view.flash()
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(1*drand48()))
    }
}
extension UIView {
    func flash() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0}, completion: nil)
    }
}

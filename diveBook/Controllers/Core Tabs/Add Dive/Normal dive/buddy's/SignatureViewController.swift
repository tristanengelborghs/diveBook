//
//  SignatureViewController.swift
//  diveBook
//
//  Created by Tristan Engelborghs on 03/01/2021.
//  Copyright © 2021 Tristan Engelborghs. All rights reserved.
//

import UIKit

var indexSignature: NSIndexPath = NSIndexPath()
var SignatureArray: [Data] = []

class SignatureViewController: UIViewController {

    
    // Interface Links
    var signatureView = Canvas()
    let clearButton = UIButton()
    var signatureImage = Data()
    var signatureString: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupNavBar()
        setupViews()
        signatureView.setStrokeColor(color: .black)
    }

    func setupViews(){
        view.addSubview(signatureView)
        signatureView.translatesAutoresizingMaskIntoConstraints = false
        signatureView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        signatureView.topAnchor.constraint(equalTo: view.topAnchor,constant: 80).isActive = true
        signatureView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        signatureView.bottomAnchor.constraint(equalTo: view.centerYAnchor,constant: 40).isActive = true
        signatureView.backgroundColor = .systemGray5
        signatureView.layer.borderWidth = 0.5
        signatureView.layer.borderColor = UIColor.systemGray5.cgColor
        signatureView.layer.cornerRadius = 10
        signatureView.clipsToBounds = true
        
        view.addSubview(clearButton)
        clearButton.anchorButton(top: signatureView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clearButton.setTitle("Clear View", for: .normal)
        clearButton.titleLabel?.font = UIFont.init(name: "Avenir Next", size: 16)
        clearButton.titleLabel?.tintColor = .white
        clearButton.contentEdgeInsets = UIEdgeInsets(top: 3, left: 7, bottom: 3, right: 7)
        clearButton.layer.borderWidth = 1
        clearButton.layer.cornerRadius = 5
        clearButton.titleLabel?.textAlignment = .center
        clearButton.layer.borderColor = UIColor.systemGray3.cgColor
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
    }

    @objc func clearButtonTapped(_ sender: UIButton) {
        signatureView.clear()
    }
    
    @objc func closeVC(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }

    @objc func saveSignature(sender: UIButton!) {
        let image = UIGraphicsImageRenderer(bounds: view.bounds).image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        let finalImage = UIImage(data: imageData)
        signatureImage = resize(image: finalImage!)!
        SignatureArray.append(signatureImage)
        
        if let presenter = presentingViewController as? NormalDiveViewController {
            presenter.tableView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image:UIImage) -> Data? {
        if let imageData = image.pngData(){ //if there is an image start the checks and possible compression
       let size = imageData.count / 1024
           if size > 1024 { //if the image data size is > 1024
           let compressionValue = CGFloat(1024 / size) //get the compression value needed in order to bring the image down to 1024
            return image.jpegData(compressionQuality: compressionValue) //return the compressed image data
           }
           else{ //if your image <= 1024 nothing needs to be done and return it as is
             return imageData
           }
       }
       else{ //if it cant get image data return nothing
           return nil
       }
   }
    
    func setupNavBar() {
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
            navBar.isTranslucent = false
            navBar.barTintColor = UIColor.systemGray5
            navBar.shadowImage = UIImage()
            view.addSubview(navBar)
            
            let navItem = UINavigationItem(title: "Add Signature")
            let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveSignature))
            let backItem = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(closeVC))
            saveItem.tintColor = .white
            
            
            navItem.rightBarButtonItem = saveItem
            navItem.leftBarButtonItem = backItem
            navBar.setItems([navItem], animated: false)
    }
    
}

struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}

class Canvas: UIView {

    // public function
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 3

    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }

    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }

    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }

    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }

    fileprivate var lines = [Line]()

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: UIColor(red: 0.07, green: 0.52, blue: 0.63, alpha: 1.00), points: []))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}

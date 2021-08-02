//
//  ViewController.swift
//  customAlert
//
//  Created by admin on 02.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let myButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .purple
        button.setTitle("Show Alert", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func myButtonTapped(){
        cusustomAlert.showAlert(title: "CooL", message: "SWIFT custom ALERT", viewController: self)
    }
    
    let cusustomAlert = customAlert()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setConstraiints()
        myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
    }
}

extension ViewController {
    func setConstraiints() {
        view.addSubview(myButton)
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myButton.heightAnchor.constraint(equalToConstant: 70),
            myButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

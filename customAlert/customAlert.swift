//
//  customAlert.swift
//  customAlert
//
//  Created by admin on 02.08.2021.
//

import UIKit

class  customAlert {
    
    struct Constatnts {
        static let backgroundAlpha: CGFloat = 0.8
        static let dismissDelay : Double = 2.0                  // задержка для авто dismiss, 0 - never auto dismiss
    }
    
    private let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .black                           // затемнение фона
        view.alpha = 0
        return view
    }()
    
    private let alertView : UIView = {
       let view = UIView()
        view.backgroundColor = .none
        return view
    }()
    
    private let backgroundImage : UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .none
        imageView.image = UIImage(named: "bgImage")
        return imageView
    }()
    
    private var myTargetView: UIView?
    
    func showAlert(title: String, message: String, viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.width-80, height: 300)
        targetView.addSubview(alertView)
        backgroundImage.frame = CGRect(x: 0, y: 0, width: alertView.frame.width, height: alertView.frame.height)
        alertView.addSubview(backgroundImage)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 80, width: alertView.frame.width, height: 80))
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .purple
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let messageLabel = UILabel(frame: CGRect(x: 70, y: 80, width: alertView.frame.width-140, height: 180))
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        alertView.addSubview(messageLabel)
        
        let buttonAlert = UIButton(frame: CGRect(x: 130, y: alertView.frame.height-100, width: alertView.frame.width-260, height: 40))
        let heart = UIImage(named: "heart")!.withRenderingMode(.alwaysOriginal)
        
        buttonAlert.setImage(heart, for: .normal)
        buttonAlert.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(buttonAlert)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = Constatnts.backgroundAlpha
        }, completion: {done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alertView.center = targetView.center
                }, completion: { done in
                    if done && Constatnts.dismissDelay != 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Constatnts.dismissDelay) {
                            self.dismissAlert()
                        }
                    }
                })
            }
        })
        
    }
    
    @objc func dismissAlert() {
        guard  let targetView = myTargetView  else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.height, width: targetView.frame.width-80, height: 300)
        }, completion: {done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundView.alpha = 0
                }, completion: {done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        self.backgroundImage.removeFromSuperview()
                    }
                })
                
            }
        })
    }
}

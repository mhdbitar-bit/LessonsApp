//
//  Alertable.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: completion)
    }
}

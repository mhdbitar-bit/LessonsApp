//
//  AppDelegate.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}


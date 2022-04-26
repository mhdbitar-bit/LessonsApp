//
//  VideoView.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import SwiftUI
import AVKit

struct VideoView: View {
    //    @Binding var presentedVidewView: Bool = false
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url:  URL(string: "https://embed-ssl.wistia.com/deliveries/79b349f5446e0bdd0312cea421245c81ae743aee/bjx305gqt5.mp4")!))
            .onAppear {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeLeft
                        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                        UINavigationController.attemptRotationToDeviceOrientation()
            }.onDisappear {
                DispatchQueue.main.async {
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                }
            }
            .ignoresSafeArea()
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
        
    }
}

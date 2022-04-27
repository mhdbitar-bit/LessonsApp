//
//  SceneDelegate.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let navigationController = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        navigationController.setViewControllers([makeRootViewController()], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func makeRootViewController() -> LessonsListViewController {
        let url = URL(string: "https://iphonephotographyschool.com/test-api/lessons")!
        let session = URLSession(configuration: .ephemeral)
        let client = URLSessionHTTPClient(session: session)
        let lessonService = RemoteLessonsService(url: url, client: client)
        let imageService = RemoteImageDataService(client: client)
        let viewModel = LessonListViewModel(lessonService: lessonService, imageDataService: imageService)
        let vc = LessonsListViewController(viewModel: viewModel)
        return vc
    }
}

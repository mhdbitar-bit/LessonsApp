//
//  SceneDelegate.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import UIKit
import CoreData

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
        let remoteLessonService = RemoteLessonsService(url: url, client: client)
        let remoteImageService = RemoteImageDataService(client: client)
        let remoteVideoService = RemoteVideoService(client: client)
        
        let localStoreURL = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent("lessons-store.sqlite")
        
        let localStore = try! CoreDataLessonStore(storeURL: localStoreURL)
        let localLessonsService = LocalLessonService(store: localStore)
        let localImageService = LocaleImageDataService(store: localStore)
        let localVideoService = LocaleVideoDataService(store: localStore)
        
        let viewModel = LessonListViewModel(
            lessonService: LessonServiceWithFallbackComposite(
                primary:  LessonServiceCacheDecorator(
                    decoratee: remoteLessonService,
                    cache: localLessonsService
                ),
                fallback: localLessonsService
            ),
            imageDataService: LessonImageDataServiceWithFallbackComposite(
                primary: localImageService,
                fallback: LessonImageeServiceCacheDecorator(
                    decoratee: remoteImageService,
                    cache: localImageService
                )
            ),
            videoDataService: LessonVideoDataServiceWithFallbackComposite(
                primary: localVideoService,
                fallback: LessonVideoServiceCacheDecorator(
                    decoratee: remoteVideoService,
                    cache: localVideoService))
        )
        let vc = LessonsListViewController(viewModel: viewModel)
        return vc
    }
}

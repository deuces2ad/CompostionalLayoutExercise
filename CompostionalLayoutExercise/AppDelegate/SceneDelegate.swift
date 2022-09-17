//
//  SceneDelegate.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 09/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let controller = NotesDashBoardViewController()
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UINavigationController(rootViewController: controller)
        let path = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        print("path is",path)
        InternetConnectivity.shared.monitorConnectionStatus()
        self.window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        PersistenceStorage.shared.saveContext()
    }


}


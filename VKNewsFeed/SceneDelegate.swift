//
//  SceneDelegate.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 5.11.21.
//

import UIKit
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    // Патерн singleTon - порождающий шаблон проектирования, гарантирующий, что в однопоточном приложении будет единственный экземпляр некоторого класса, и предоставляющий глобальную точку доступа к этому экземпляру. По сути мы получаем доступ к этому классу в любом месте программы
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = (scene?.delegate as? SceneDelegate)!
        return sd
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Создаём сцену windowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // Инициализируем свойство window: UIWindow
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        // Говорим window, что у него теперь есть сцена windowScene
        window?.windowScene = windowScene
        
        
        authService = AuthService()
        authService.delegate = self
        // Тут создаём свойство и дастаём сториборд, кастим его до нашего AuthViewController для того тобы добавить это свойство в window.rootViewController
        let authVC = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController() as? AuthViewController
        // Достаём свойство rootViewController у window и присваиваем authVC, который создали ранее
        window?.rootViewController = authVC
        // И делаем rootViewController главным и видимым
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    // MARK: - AuthServiceDelegate
    func authServiceShouldShow(viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSingIn() {
        print(#function)
        let newsfeedVC = UIStoryboard(name: "NewsfeedViewController", bundle: nil).instantiateInitialViewController() as! NewsfeedViewController
        let navVC = UINavigationController(rootViewController: newsfeedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceSingInDidFail() {
        print("Error Network")
    }

}


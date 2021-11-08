//
//  AuthService.swift
//  VKNewsFeed
//
//  Created by Дмитрий Межевич on 5.11.21.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSingIn()
    func authServiceSingInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7994002"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        // Подписываемся под два ротакола commonDelegate и uiDelegatr
        vkSdk.register(self)
        vkSdk.uiDelegate = self
        
        print("VKSdk.initialize")
    }
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        VKSdk.accessToken()?.accessToken
    }
    
    // Тут проверяем, доступна ли предыдущая сессия (т.е. авторизованы мы или нет)
    func wakeUpSession() {
        // Создаём свойство в котором будет лежать scope(прова доступа приложения)
        let scope = ["wall", "friends"]
        // Вызываем метод, который вернёт состояние сессии. В нашем случаи нас интересует статус регестрации и авторизации
        VKSdk.wakeUpSession(scope) { [delegate] state, error in
            switch state {
            case .initialized:
                print("initialized")
                // Тут мы понимаем, что VKsdk готов к работе и мы можем авторизовать пользователя с помощью метода authorize
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServiceSingIn()
            default:
                delegate?.authServiceSingInDidFail()
            }
        }
    }
    
    // Вызывается в случаи успешной авторизации пользователя
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSingIn()
        }
    }
    
    // Вызывается в случаи ошибки авторизации
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSingInDidFail()
    }
    
    // Данный метод нужен для того, чтобы отобразить готовую форму ViewController(тут содержится и авторизация, и регистрация пользователя), которую предоставляет сам VKsdk. Свойство controller метода vkSdkShouldPresent содержит уже готовый ViewController, который нам нужно использовать. Не забываем, что открыть данный ViewController в данном классе не получится(нам нужно его открывать в классе SceneDelegate), поэтому нужно проделегировать данный методв SceneDelegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    //
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}

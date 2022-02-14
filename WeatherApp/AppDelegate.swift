//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Andrew Trach on 12.02.2022.
//

import UIKit
import AlamofireNetworkActivityLogger
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let googleAPIKey = "AIzaSyCKdi-XkaRQOC4bOnq-N8VSqD7plh6MLac"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}


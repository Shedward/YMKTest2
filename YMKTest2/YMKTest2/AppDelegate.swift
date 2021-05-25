//
//  AppDelegate.swift
//  YMKTest2
//
//  Created by Vlad Maltsev on 24.05.2021.
//

import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	let window = UIWindow(frame: UIScreen.main.bounds)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		YMKMapKit.setApiKey("___")
		YMKMapKit.setLocale("ru_RU")

		window.rootViewController = ViewController()
		window.makeKeyAndVisible()

		return true
	}
}


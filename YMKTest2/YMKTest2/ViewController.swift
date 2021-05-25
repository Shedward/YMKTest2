//
//  ViewController.swift
//  YMKTest2
//
//  Created by Vlad Maltsev on 24.05.2021.
//

import UIKit
import YandexMapsMobile

class ViewController: UIViewController {
	private let panoView = YMKPanoView(frame: .zero, vulkanPreferred: true)!
	private let yandexResourceImageView = UIImageView()
	private var panoramaSession: YMKPanoramaServiceSearchSession?

	private let SEARCH_LOCATION = YMKPoint(latitude: 55.733330, longitude: 37.587649)

	override func loadView() {
		self.view = panoView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		loadPanorama(for: SEARCH_LOCATION)
		// Если раскоментить то иконка из YMK появится на экране
		//displaySomeYandexResource()
	}

	private func displaySomeYandexResource() {
		let image = UIImage(named: "search_layer_pin_selected_default")
		yandexResourceImageView.image = image
		yandexResourceImageView.translatesAutoresizingMaskIntoConstraints = false
		panoView.addSubview(yandexResourceImageView)
		NSLayoutConstraint.activate([
			yandexResourceImageView.bottomAnchor.constraint(equalTo: panoView.bottomAnchor),
			yandexResourceImageView.leadingAnchor.constraint(equalTo: panoView.leadingAnchor)
		])
	}

	private func loadPanorama(for point: YMKPoint) {
		let panoramaService = YMKPlaces.sharedInstance().createPanoramaService()
		panoramaSession = panoramaService.findNearest(withPosition: point) { panoramaId, error in
			if let panoramaId = panoramaId {
				self.showPanorama(panoramaId)
			} else if let error = error {
				self.showError(error)
			}
		}
	}

	private func showPanorama(_ panoramaId: String) {
		panoView.player.openPanorama(withPanoramaId: panoramaId)
		panoView.player.enableMove()
		panoView.player.enableRotation()
		panoView.player.enableZoom()
		panoView.player.enableMarkers()
	}

	private func showError(_ error: Error) {
		let panoramaSearchError = (error as NSError).userInfo[YRTUnderlyingErrorKey] as! YRTError

		var errorMessage = "Unknown error"
		if panoramaSearchError.isKind(of: YMKPanoramaNotFoundError.self) {
			errorMessage = "Not found"
		} else if panoramaSearchError.isKind(of: YRTNetworkError.self) {
			errorMessage = "Network error"
		} else if panoramaSearchError.isKind(of: YRTRemoteError.self) {
			errorMessage = "Remote server error"
		}

		let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

		present(alert, animated: true, completion: nil)
	}
}


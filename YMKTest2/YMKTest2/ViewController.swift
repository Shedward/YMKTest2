//
//  ViewController.swift
//  YMKTest2
//
//  Created by Vlad Maltsev on 24.05.2021.
//

import UIKit
import YandexMapsMobile

class ViewController: UIViewController {
	private let mapSelectionOverlayView = MapSelectionOverlayView()
	private let mapView = YMKMapView(frame: .zero, vulkanPreferred: true)!

	override func viewDidLoad() {
		super.viewDidLoad()

		appendToVerticalStack(mapView)

		mapSelectionOverlayView.onFinishDrawing = { [weak self] points in
			self?.addPolygonToMap(points: points)
		}
		appendToVerticalStack(mapSelectionOverlayView)
	}

	private func appendToVerticalStack(_ view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(view)
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: self.view.topAnchor),
			view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		])
	}

	private func addPolygonToMap(points: [CGPoint]) {
		let map = mapView.mapWindow.map

		let mapPoints: [YMKPoint] = points.compactMap { point in
			mapView.mapWindow.screenToWorld(
				with: YMKScreenPoint(
					x: Float(point.x) * mapView.mapWindow.scaleFactor,
					y: Float(point.y) * mapView.mapWindow.scaleFactor
				)
			)
		}
		let polygon = YMKPolygon(outerRing: YMKLinearRing(points: mapPoints), innerRings: [])
		let mapPolygon = map.mapObjects.addPolygon(with: polygon)
		mapPolygon.strokeWidth = 1
	}
}


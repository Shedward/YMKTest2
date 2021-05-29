//
//  MapSelectionOverlay.swift
//  YMKTest2
//
//  Created by Vlad Maltsev on 27.05.2021.
//

import UIKit

class MapSelectionOverlayView: UIView {
	private var selectedPoints: [CGPoint] = []

	var onFinishDrawing: (([CGPoint]) -> Void)?

	override init(frame: CGRect) {
		super.init(frame: frame)

		isOpaque = false
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func draw(_ rect: CGRect) {
		guard
			let context = UIGraphicsGetCurrentContext(),
			let firstPoint = selectedPoints.first
		else {
			return
		}

		context.clear(rect)
		context.setFillColor(UIColor.green.cgColor)
		context.setLineWidth(3)
		context.move(to: firstPoint)
		selectedPoints.forEach { point  in
			context.addLine(to: point)
		}
		context.drawPath(using: .stroke)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let position = touches.first?.location(in: self) else { return }

		selectedPoints = [position]
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let position = touches.first?.location(in: self) else { return }

		selectedPoints.append(position)
		setNeedsDisplay()
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let position = touches.first?.location(in: self) else { return }

		selectedPoints.append(position)
		onFinishDrawing?(selectedPoints)
		selectedPoints = []
		setNeedsDisplay()
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		selectedPoints = []
		setNeedsDisplay()
	}
}

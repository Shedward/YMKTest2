// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// reason: package.swift
// swiftlint:disable all

import PackageDescription

let package = Package(
	name: "YandexMaps",
	products: [
		.library(
			name: "YandexMaps",
			targets: ["YandexMaps"]),
	],
	dependencies: [
	],
	targets: [
		.binaryTarget(
			name: "YandexMapsMobile",
			url: "https://github.com/Shedward/YMK.xcframework/releases/download/4.0.0-full/YandexMapsMobile.xcframework-4.0.0-full.zip",
			checksum: "01b9ec6b93eac28dbb38edf1ad751294bcb13a27b5f625b05d77791e8ecd24a0"
		),
		.target(
			name: "YandexMaps",
			dependencies: [
				"YandexMapsMobile"
			],
			linkerSettings: [
				.linkedLibrary("c++"),
				.linkedLibrary("resolv"),
				.linkedFramework("CoreLocation"),
				.linkedFramework("CoreTelephony"),
				.linkedFramework("SystemConfiguration")
			]
		),
	]
)

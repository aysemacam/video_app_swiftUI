//
//  OrientationChanger.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI


struct OrientationChanger: UIViewControllerRepresentable {
    let orientation: UIInterfaceOrientation

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            viewController.setOrientation(to: orientation)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        DispatchQueue.main.async {
            uiViewController.setOrientation(to: orientation)
        }
    }
}



import UIKit

extension UIViewController {
    func setOrientation(to orientation: UIInterfaceOrientation) {
        guard let windowScene = view.window?.windowScene else { return }

        let geometryPreferences = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: orientation == .portrait ? .portrait : .landscapeRight)
        
        windowScene.requestGeometryUpdate(geometryPreferences) { error in
//            if let error = error {
                print("Error setting orientation: \(error.localizedDescription)")
//            } else {
                print("Orientation changed to \(orientation.rawValue)")
//            }
        }
    }
}

import SwiftUI

struct RotateModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear(perform: subscribe)
    }

    private func subscribe() {
        NotificationCenter.default.addObserver(
            forName: UIDevice.orientationDidChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            action(UIDevice.current.orientation)
        }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(RotateModifier(action: action))
    }
}

extension UIDeviceOrientation {
    var isLandscape: Bool {
        self == .landscapeLeft || self == .landscapeRight
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

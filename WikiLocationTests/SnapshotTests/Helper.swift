//
//  Helper.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 10/12/2024.
//

import SwiftUI
import UIKit

func createUIView<V: View>(from swiftUIView: V, size: CGSize = CGSize(width: 375.0, height: 812.0)) -> UIView {
    let hostingController = UIHostingController(rootView: swiftUIView)

    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    window.rootViewController = hostingController
    window.makeKeyAndVisible()

    return hostingController.view
}

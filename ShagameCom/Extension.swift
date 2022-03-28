//
//  Extension.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 08.02.2022.
//

import Foundation
import SwiftUI

extension Color {
    
    static let customRed = Color(#colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1))
    static let sh_basicRed = Color(#colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1))
    
    static let sh_darkRed = Color(#colorLiteral(red: 0.7529411765, green: 0.1098039216, blue: 0.09411764706, alpha: 1))
    static let sh_lightRed = Color(#colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1))
    
    static let customGray = Color(#colorLiteral(red: 0.3137254902, green: 0.3333333333, blue: 0.3607843137, alpha: 1))
    static let sh_basicGrey = Color(#colorLiteral(red: 0.3137254902, green: 0.3333333333, blue: 0.3607843137, alpha: 1))
    
    static let sh_darkGrey = Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1))
    
    static let customLightGray = Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1))
    static let sh_Grey = Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1))
    
    static let sh_lightGrey = Color(#colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1))
    
    static let sh_colorFrame = Color(#colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 0.4492752378))
    
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners: UIRectCorner = .allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

extension View {

  func keyboardSensible(_ offsetValue: Binding<CGFloat>) -> some View {

    return self
        .padding(.bottom, offsetValue.wrappedValue)
        .animation(.spring())
        .onAppear {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in

            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first

            let bottom = keyWindow?.safeAreaInsets.bottom ?? 0

            let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let height = value.height

            offsetValue.wrappedValue = height - bottom
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            offsetValue.wrappedValue = 0
        }
    }
  }
}

//
//  ProfilePhotoView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 08.02.2022.
//

import SwiftUI

struct ProfilePhotoView: View {
    
    var isEmpty: Bool
    var imageProfile: String?
    
    var body: some View {
        if isEmpty {
            ZStack {
            Circle()
            .foregroundColor(Color(UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)))
            .overlay(
                Image("shg tag big"))
                Button() {
                    //action
                } label: {
                    Circle()
                        .foregroundColor(Color(UIColor(red: 185/255, green: 26/255, blue: 24/255, alpha: 1)))
                        .frame(width: WIDTH * 0.11 * cooficient, height: WIDTH * 0.11 * cooficient)
                        .overlay (Image("Image"))
                }
                .offset(x: 65 * cooficient, y: 60 * cooficient)
            }.frame(width: WIDTH * 0.46 * cooficient, height: WIDTH * 0.46 * cooficient)
            
        } else {
            ZStack{
            Image(imageProfile!)
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
            Button() {
            //action
            } label: {
                Circle()
                .foregroundColor(Color(UIColor(red: 185/255, green: 26/255, blue: 24/255, alpha: 1)))
                .frame(width: WIDTH * 0.11 * cooficient, height: WIDTH * 0.11 * cooficient)
                .overlay (Image("Image"))
            }
            .offset(x: 65 * cooficient, y: 60 * cooficient)
            }.frame(width: WIDTH * 0.46 * cooficient, height: WIDTH * 0.46 * cooficient)
        }
    }
}

struct ProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoView(isEmpty: false, imageProfile: "image 1")
    }
}

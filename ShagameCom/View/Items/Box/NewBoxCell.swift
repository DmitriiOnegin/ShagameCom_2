//
//  NewBoxCell.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 18.02.2022.
//

import SwiftUI

struct NewBoxCell: View {
    var body: some View {

        VStack(alignment: .center, spacing: 17) {
            Image("new audiobox")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: WIDTH * 0.24, height: WIDTH * 0.24 * 1.52)
            Text("Создать аудиобокс")
                .font(fontBold12)
                .foregroundColor(.customGray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: WIDTH / 5, height: 42)
            Image("check 1")
                .opacity(0)
        }
    }
}

struct NewBoxCell_Previews: PreviewProvider {
    static var previews: some View {
        NewBoxCell()
    }
}

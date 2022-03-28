//
//  AnnotationView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import SwiftUI
import MapKit

struct AnnotationView: View {
    
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        Image("shg_map2")
    }
}

//struct AnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnnotationView()
//    }
//}

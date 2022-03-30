//
//  MultilineTextField.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 30.03.2022.
//

import SwiftUI

struct MultilineTextField: View {
    @StateObject var observeSize = observed()
    @Binding var text: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 15){
                MultiTF(observeSize: observeSize, constText: text)
                    .frame(height: self.observeSize.size + 35)
                }
                .padding(.top, 9)
                .background(
                    Text(subtitle)
                        .font(fontRegular12)
                      //  .scaleEffect(1.3)
                        .offset(x: 10, y: -15)
                        .foregroundColor(.sh_basicGrey)
                    ,alignment: .leading
                )
        }
        .padding(.vertical,20)
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 5).strokeBorder().foregroundColor(.sh_basicGrey))
        
    }
}

struct MultilineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextField(observeSize: observed(),
                           text: .constant("Hello frnejknfrjke"),
                           subtitle: "Краткое описание")
    }
}


struct MultiTF: UIViewRepresentable {
    @StateObject var observeSize: observed
    var constText: String
    
    func makeCoordinator() -> Coordinator {
        return MultiTF.Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<MultiTF>) -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.text = ""
        view.delegate = context.coordinator
        
        self.observeSize.size = view.contentSize.height
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        
        return view
        
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        var parent : MultiTF
        
        init(parent : MultiTF) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = UIColor(#colorLiteral(red: 0.3137254902,
                                                       green: 0.3333333333,
                                                       blue: 0.3607843137,
                                                       alpha: 1))
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.observeSize.size = textView.contentSize.height
            self.parent.constText = textView.text
            
        }
        
    }
}

class observed: ObservableObject {
    @Published var size: CGFloat = 60.0
}

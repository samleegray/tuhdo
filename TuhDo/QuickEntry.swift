//
//  QuickEntry.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI

struct QuickEntry: View {
    
    @Binding var newItemText: String
    
    let newItemTextCornerRadius: CGFloat = 14
    let newItemTextMinHeight: CGFloat = 40
    
    var body: some View {
        getTextView()
    }
    
    func getTextView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                TextField("Placeholder", text: $newItemText, axis: .vertical)
                    .cornerRadius(newItemTextCornerRadius)
                    .frame(minHeight: newItemTextMinHeight)
                    .padding()
            }
        }
    }
    
    func getText() -> String {
        print("newItemText: \(newItemText)")
        return newItemText
    }
}

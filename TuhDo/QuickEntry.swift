//
//  QuickEntry.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI

struct QuickEntry: View {
    
    @Binding var newItemText: String
    
    let newItemTextCornerRadius: CGFloat = 0
    let newItemTextMinHeight: CGFloat = 40
    
    /// Any localizable strings for this view.
    private struct LocalizedStrings {
        static let placeholder = NSLocalizedString("quick_entry_placeholder", value: "Quickly create an item", comment: "Quickly create an item")
    }
    
    var body: some View {
        getTextView()
    }
    
    func getTextView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                TextField(LocalizedStrings.placeholder, text: $newItemText, axis: .vertical)
                    .cornerRadius(newItemTextCornerRadius)
                    .frame(minHeight: newItemTextMinHeight)
                    .padding()
            }
        }
    }
}

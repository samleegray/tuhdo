//
//  NoteDetails.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI

struct NoteDetails: View {
    let item: Item
    
    @State private var title: String
    @State private var notes: String
    
    init(item: Item) {
        self.item = item
        self.notes = item.text
        self.title = item.title ?? ""
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $title).font(.title)
            TextField("Placeholder", text: $notes)
//                .onAppear(perform: {
//                    notes = self.item.text
//                })
        }.padding()
        Spacer()
        HStack {
            Text("Created on \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
        }.padding()
    }
}

#Preview {
    NoteDetails(item: Item(timestamp: Date(), text: "I'm some text!"))
}


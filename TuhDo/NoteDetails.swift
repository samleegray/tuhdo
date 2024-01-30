//
//  NoteDetails.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI
import CoreLocation

struct NoteDetails: View {
    /// Not 100% sure, need to check this out. -Sam
    @Environment(\.modelContext) private var modelContext
    
    let item: Item
    
    @State private var title: String
    @State private var notes: String
    
    init(item: Item) {
        self.item = item
        self.notes = item.notes
        self.title = item.title ?? ""
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Title", text: $title).font(.title)
                TextField("Placeholder", text: $notes, axis: .vertical)
            }.padding()
        }.scrollDismissesKeyboard(.interactively)
        
        Spacer()
        
        HStack {
            Text("Created on \(item.createdDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .font(.footnote)
        }.padding()
            .onDisappear(perform: {
                saveItem()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveItem) {
                        Text("Save")
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
    }
    
    /// Add an item to our storage.
    private func saveItem() {
        withAnimation {
            // Create & insert new item.
            item.notes = notes
            if !title.isEmpty {
                item.title = title
            } else {
                item.title = nil
            }
            do {
                try modelContext.save()
            } catch {
                print("Failed to save item. \(error)")
            }
        }
    }
}

#Preview {
    NoteDetails(item: Item(createdDate: Date(), notes: "I'm some text!", title: "I'm a title"))
}


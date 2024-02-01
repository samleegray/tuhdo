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
    @State private var notes: String = "A giant test."
    
    init(item: Item) {
        self.item = item
        self.notes = item.notes
        self.title = item.title ?? ""
    }
    
    var body: some View {
        
        // Top ZStack
        ZStack {
            // Top Stack with details to edit
            VStack {
                Spacer()
                TextField("Title", text: $title, axis: .vertical).font(.title)
                CustomTextEditor(text: $notes)
                    .scrollDismissesKeyboard(.interactively)
                Spacer()
            }.padding()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: saveItem) {
                            Text("Save")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .onDisappear(perform: {
                    saveItem()
                })
            
            // Bottom stack for content that shouldn't move
            VStack {
                Spacer()
                Text("Created on \(item.createdDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    .font(.footnote)
                    .ignoresSafeArea(.keyboard)
            }.ignoresSafeArea(.keyboard)
        }
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
            item.priority = .none
            item.lastUpdatedDate = Date.now
            item.lastActionTakenDate = Date.now
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


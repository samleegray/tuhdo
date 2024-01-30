//
//  ContentView.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI
import SwiftData

struct NoteList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    private struct LocalizedStrings {
        static let title = "TuhDo List"
    }
    
    @State var newItemText: String = ""

    var body: some View {
        
        NavigationSplitView {
            // List of all items
            List {
                ForEach(items) { item in
                    NavigationLink {
                        NoteDetails(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.text)
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                .font(.footnote).foregroundStyle(.secondary)
                            
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }.navigationBarTitleDisplayMode(.large)
                .navigationTitle(LocalizedStrings.title)
            
        } detail: {
            Text("Select an item").font(.subheadline)
        }
        
        // Bottom entry section.
        QuickEntry(newItemText: $newItemText)
    }

    private func addItem() {
        withAnimation {
            print("newItemText: \(newItemText)")
            let newItem = Item(timestamp: Date(), text: newItemText)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    NoteList()
        .modelContainer(for: Item.self, inMemory: true)
}

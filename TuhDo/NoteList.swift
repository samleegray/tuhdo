//
//  ContentView.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI
import SwiftData

struct NoteList: View {
    /// Not 100% sure, need to check this out. -Sam
    @Environment(\.modelContext) private var modelContext
    
    /// The items we are listing.
    @Query private var items: [Item]
    var previewItems: [Item]?
    
    /// Any localizable strings for this view.
    private struct LocalizedStrings {
        static let title = NSLocalizedString("note_list_view_title", value: "TuhDo List", comment: "TuhDo List, a take on Todo List")
        static let defaultDetailPageViewText = NSLocalizedString("default_detail_page_view_text", value: "Select an item.", comment: "Displays when nothing is selected in the details view.")
        static let addItemLabel = NSLocalizedString("add_item_label", value: "Add Item", comment: "Add Item.")
    }
    
    /// New item text.
    @State var newItemText: String = ""

    var body: some View {
        NavigationSplitView {
            // List of all items
            List {
                ForEach(previewItems ?? items) { item in
                    NavigationLink {
                        NoteDetails(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            if let title = item.title {
                                Text(title).font(.headline)
                            }
                            Text(item.text)
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                                .font(.footnote).foregroundStyle(.secondary)
                            
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            // Toolbar for navigation items
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label(LocalizedStrings.addItemLabel, systemImage: "plus")
                    }
                }
            }.navigationBarTitleDisplayMode(.large)
                .navigationTitle(LocalizedStrings.title)
            
        } detail: {
            // The default detail page when we have nothing to display.
            Text(LocalizedStrings.defaultDetailPageViewText).font(.subheadline)
        }
        
        // Bottom entry section.
        QuickEntry(newItemText: $newItemText)
    }

    /// Add an item to our storage.
    private func addItem() {
        withAnimation {
            // Create & insert new item.
            let newItem = Item(timestamp: Date(), text: newItemText)
            modelContext.insert(newItem)
            // Reset.
            reset()
        }
    }

    /// Delete an item from our storage.
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            // Remove the item.
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    /// Reset UI to default after an item is created.
    private func reset() {
        newItemText = ""
    }
}

struct NoteList_Previews: PreviewProvider {
    static let items = [
        Item(timestamp: Date.distantPast, text: "An old todo.", title: "Old Title Todo"),
        Item(timestamp: Date.distantFuture, text: "A note from the future!", title: "Future Note")
    ]
    
    static var previews: NoteList = {
        return NoteList(previewItems: items)
    }()
    
    typealias Previews = NoteList
//        .modelContainer(for: Item.self, inMemory: true)
}

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
        static let filterItemLabel = NSLocalizedString("filter_item_label", value: "Filter", comment: "Filter")
        static let detailsTitle = NSLocalizedString("details_view_title", value: "Details", comment: "Details view title.")
    }
    
    /// New item text.
    @State var newItemText: String = ""
    @State private var selectedItem: Item?

    var body: some View {
        NavigationSplitView {
            // List of all items
            List(items, selection: $selectedItem) {
                let item = $0
                NavigationLink(value: item) {
                    VStack(alignment: .leading) {
                        if let title = item.title {
                            Text(title).font(.headline)
                        }
                        Text(item.notes)
                        Text(item.createdDate, format: Date.FormatStyle(date: .numeric, time: .standard))
                            .font(.footnote).foregroundStyle(.secondary)
                        
                    }
//                        NoteDetails(item: item)
                }
            // Toolbar for navigation items
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button(action: addItem) {
                            Label(LocalizedStrings.addItemLabel, systemImage: "plus")
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: filter) {
                        Label(LocalizedStrings.filterItemLabel, systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(LocalizedStrings.title)
            .scrollDismissesKeyboard(.immediately)
            
            // Bottom entry section.
//            QuickEntry(newItemText: $newItemText)
        } detail: {
            if let selectedItem {
                NoteDetails(item: selectedItem)
                    .navigationTitle(LocalizedStrings.detailsTitle)
                    .id(selectedItem.id)
            } else {
                Text(LocalizedStrings.defaultDetailPageViewText).font(.subheadline)
            }
            // The default detail page when we have nothing to display.
//            Text(LocalizedStrings.defaultDetailPageViewText).font(.subheadline)
        }
    }
    
    /// Filter operations will go here.
    private func filter() {
        // Placeholder for Filter operations
    }

    /// Add an item to our storage.
    private func addItem() {
        withAnimation {
            // Create & insert new item.
            let newItem = Item(createdDate: Date(), notes: newItemText)
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
        Item(createdDate: Date.distantPast, notes: "An old todo.", title: "Old Title Todo"),
        Item(createdDate: Date.distantFuture, notes: "A note from the future!", title: "Future Note")
    ]
    
    static var previews: NoteList = {
        return NoteList(previewItems: items)
    }()
    
    typealias Previews = NoteList
//        .modelContainer(for: Item.self, inMemory: true)
}

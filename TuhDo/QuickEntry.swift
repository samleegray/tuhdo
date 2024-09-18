//
//  QuickEntry.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import SwiftUI

enum Priority: String, Codable, CaseIterable, Identifiable {
    case none, low, medium, high
    
    var id: Self { self }
}

struct QuickEntry: View {
    
    @Binding var newItemText: String
    @State private var showingPriorityPopover = false
    @State private var priority: Priority = .none
    
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
                HStack {
                    Spacer()
                    Button(action: setPrirority) {
                        switch priority {
                        case .none:
                            Image(systemName: "flag")
                        case .low:
                            Image(systemName: "flag.fill").foregroundStyle(.blue)
                        case .medium:
                            Image(systemName: "flag.fill").foregroundStyle(.orange)
                        case .high:
                            Image(systemName: "flag.fill").foregroundStyle(.red)
                        }
                    }
                    .padding(.trailing, 16)
                    .popover(isPresented: $showingPriorityPopover,
                             attachmentAnchor: .point(.top),
                             arrowEdge: .bottom) {
                        VStack(alignment: .leading) {
                            Button(action: setPriorityHigh) {
                                HStack {
                                    Image(systemName: "flag.fill")
                                        .foregroundStyle(.red)
                                    Text("High")
                                }
                            }
                            Button(action: setPriorityMedium) {
                                HStack {
                                    Image(systemName: "flag.fill")
                                        .foregroundStyle(.orange)
                                    Text("Medium")
                                }
                            }
                            Button(action: setPriorityLow) {
                                HStack {
                                    Image(systemName: "flag.fill")
                                        .foregroundStyle(.blue)
                                    Text("Low")
                                }
                            }
                        }.padding()
                            .presentationCompactAdaptation(.none)
                    }
                }
                TextField(LocalizedStrings.placeholder, text: $newItemText, axis: .vertical)
                    .cornerRadius(newItemTextCornerRadius)
                    .frame(minHeight: newItemTextMinHeight)
                    .padding()
            }
        }
    }
    
    func setPrirority() {
        showingPriorityPopover = !showingPriorityPopover
    }
    
    func setPriorityHigh() {
        priority = .high
        showingPriorityPopover = false
    }
    
    func setPriorityMedium() {
        priority = .medium
        showingPriorityPopover = false
    }
    
    func setPriorityLow() {
        priority = .low
        showingPriorityPopover = false
    }
}

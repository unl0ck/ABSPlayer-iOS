//
//  MenuView.swift
//  ABSPlayer
//
//  Created by Simon Helming on 26.10.24.
//

import SwiftUI
import Audiobookshelf

struct LibraryView: View {
    @StateObject private var viewModel = LibraryViewModel()
    @State private var selectedLibrary: String? = "Menu"
    var body: some View {
        NavigationView {
            VStack {
                if let libraryItems = viewModel.selectedLibrary {
                    // Liste anzeigen, wenn ein Item ausgewählt wurde
                    List(libraryItems, id: \.self) { detail in
                        
                        HStack {
                            // NavigationLink für das Item
                           
                            Text(detail.media?.metadata?.title ?? "Unknown").onTapGesture {
                                DetailView(item: detail)
                            }
                            
                            
                            Spacer() // Platzhalter, um den Button nach rechts zu schieben
                            
                            // Play-Button
                            Button(action: {
                                viewModel.playItem(detail)
                            }) {
                                Image(systemName: "play.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                            .contentShape(Rectangle()) // Button-Form festlegen
                        }
                    }
                } else {
                    // Platzhaltertext anzeigen, wenn kein Item ausgewählt wurde
                    Text("Wähle ein Menü-Item, um Details anzuzeigen")
                        .padding()
                }
            }
            .padding()
            .navigationTitle(selectedLibrary ?? "Menu")
            .toolbar {
                ToolbarItem {
                    Menu {
                        ForEach($viewModel.items, id: \.self) { item in
                            Button(action: {
                                    viewModel.selectLibrary(library: item.wrappedValue)
                                    selectedLibrary = item.name.wrappedValue
                            }) {
                                Text(item.name.wrappedValue!)
                            }
                        }
                        Divider()
                        Button(action: {
                            viewModel.logout()
                        }) {
                            Text("Logout")
                        }
                    } label: {
                        Label("Menu", systemImage: "ellipsis.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    LibraryView()
}

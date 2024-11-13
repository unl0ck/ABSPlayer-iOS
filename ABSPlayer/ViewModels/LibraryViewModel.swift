//
//  MenuViewModel.swift
//  ABSPlayer
//
//  Created by Simon Helming on 05.11.24.
//
import Combine

import Audiobookshelf
class LibraryViewModel: ObservableObject {
    @Published var items: [Library] = []
    @Published var selectedLibrary: [LibraryItemBase]?
    
    private let audiobookshelfService = AudiobookshelfService.shared
    
    init() {
        items = []
        Task {
            items = await self.audiobookshelfService.getAllLibs()
        }
    }
    
    func logout() {
        print("logout pressed")
    }
    
    func selectLibrary(library: Library) {
        print("Selected library: \(library.name ?? "Unknown")")
        Task {
                selectedLibrary = await self.audiobookshelfService.getLibraryItems(id: library.id!)
                print(selectedLibrary)
        }
    }
    func playItem(_ item: LibraryItemBase) {
        print("Playing \(item.media?.metadata?.title)")
        }
    
}

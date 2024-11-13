//
//  DetailView.swift
//  ABSPlayer
//
//  Created by Simon Helming on 12.11.24.
//

import SwiftUI
import Audiobookshelf

struct DetailView: View {
    let item: LibraryItemBase
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let item : LibraryItemBase = LibraryItemBase()
    DetailView(item: item)
}

//
//  BookShelfView.swift
//  AozoraBunko
//
//  Created by Sho Tamaki on 2023/09/14.
//

import SwiftUI

struct BookShelfView: View {
    
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack{
                if selectedIndex == 0 {
                    ReadingBookView()
                } else if selectedIndex == 1 {
                    FinishedReadingBookView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Picker("", selection: self.$selectedIndex) {
                        Text("読書中").tag(0)
                        Text("読了").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200, height: 30)
                }
            }
        }
    }
    
    
}

struct BookShelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfView()
    }
}

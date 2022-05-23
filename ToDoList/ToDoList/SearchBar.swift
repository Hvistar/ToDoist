////
////  SearchBar.swift
////  ToDoList
////
////  Created by Luigi Luca Coletta on 10/12/21.
////
//
//import SwiftUI
//
//struct SearchBar: View {
//
//    @Binding var searchText: String
//
//    @Binding var searching: Bool
//
//    var body: some View {
//        ZStack {
//                 Rectangle()
//                     .foregroundColor(Color(.systemGray5))
//                 .frame(height: 40)
//
//            HStack{
//                Image(systemName: "magnifyingglass")
//                TextField("Search ..", text: $searchText) { startedEditing in
//                    if startedEditing {
//                        withAnimation {
//                            searching = true
//                        }
//                    }
//                } //startedEditing is true when the user taps on the bar
//            onCommit: {
//                 withAnimation {
//                     searching = false
//                 }
//             } //when the user stops searching the navigation bar goes back to normal
//
//            } //HStack
//                 .foregroundColor(.gray)
//                 .padding(.leading, 13)
//
//        } //ZStack
//             .frame(height: 40)
//             .cornerRadius(13)
//             .padding()
//    }
//}
//
//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar(searchText: .constant(""), searching: .constant(false))
//    }
//}

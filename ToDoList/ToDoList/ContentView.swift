import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext //property wrapper to access managedObjectContext by retrieving viewContext from the environment
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:\TodoCD.date, ascending: false)]) private var todosCD: FetchedResults<TodoCD>

    
    @State private var showAddToDoView = false
    
    @State var searchText = ""
    
    @State var searching = false //pass this to the search bar to modify the navigation bar while searching
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                
//                SearchBar(searchText: $searchText, searching: $searching)
                SearchBar2(text: self.$searchText)
                
        List{
//            ForEach(todosCD, id:\.self){
            //receives an array and creates multiple subviews, name is the id for the list
//                (todo) in
            //array of subviews
            
            ForEach(todosCD.filter({searchText.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(self.searchText)}), id:\.self){
                    todo in
         
                NavigationLink(destination: VStack{
                    //view displayed when each item is tapped
                    Text(todo.name ?? "Untitled")
                        .font(Font.headline.weight(.bold))
                    Image(todo.category ?? "")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(todo.tag ?? "")
                        .foregroundColor(Color(.systemBlue))
                    Text(calculateDate(date: todo.date!))
                    Text(todo.desc ?? "")
                    Image(systemName: "flag.circle.fill")
                           .resizable()
                           .frame(width: 80, height: 80, alignment: .center)
                           .foregroundColor(Color(.systemOrange))
                           .opacity(todo.priority ? 1.0 : 0.0)
                
                }.onLongPressGesture(perform: {updateTodo(todo: todo)})
                        
                ){//label for each element
                
                HStack{
                    CheckButton()
                    VStack(alignment: .leading){
                    Text(todo.name ?? "untitled")
                            .font(Font.headline.weight(.bold))
                    HStack{
                        Text(calculateDate(date: todo.date!))
                            .foregroundColor(Color(.systemGray))
                        Text(todo.tag ?? "")
                            .foregroundColor(Color(.systemBlue))
                        
                }//HStack
                    }//VStack
                      
                    Spacer()
                    
                    Image(systemName: "flag.circle.fill")
                           .resizable()
                           .frame(width: 30, height: 30)
                           .foregroundColor(Color(.systemOrange))
                           .opacity(todo.priority ? 1.0 : 0.0)
                    
                    }
                }
            }.onDelete(perform: {index in deleteTodo(offsets: index)
                })
//indices same as .onDelete; newOffset is the index of the new position for the item to move (works only in edit mode)
        }.navigationTitle(searching ? "Searching" : "Inbox") //attached on the List view, not to the Navigation View because we want different titles on different pages, otherwise it would be fixed
                .toolbar{
                    
//                    if searching {
//                                     Button("Cancel") {
//                                         searchText = ""
//                                         withAnimation {
//                                             searching = false
//                                             UIApplication.shared.dismissKeyboard()
//                                             //hides the keyboard when the user cancels the search
//                                         }
//                                     }
//                                 }
                    
                    
                   Button(action: {
                        self.showAddToDoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")}
                   )
                    .sheet(isPresented: $showAddToDoView){
                        AddTodoView(showAddToDoView: self.$showAddToDoView)
                    //when showAddToDoView is true the view is presented, $ to bind the value from and to another view
                    }
                }
            } //VStack for search bar
    }
  }



struct AddTodoView: View {
    
    @Binding var showAddToDoView: Bool
    //Binding: the value will come from outside and will be shared with another view
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedCategory = 0
    var categoryTypes = ["Workout","Book","Music","Food","Call","Self"]
    //indices for the picker
    
    @State private var name: String = ""
    @State private var date = Date()
    @State private var tag = ""
    @State private var desc = ""
    @State private var prio = false
   
    
    var body: some View {
        NavigationView{
        VStack{
            
            Spacer()
            
            TextField(
                "Title: Es. Read Book, Call Mom...",
                text: $name
            )
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(.systemGray), lineWidth: 2)
                )
                .padding()
            
            TextField(
                "#Tag:",
                text: $tag
            )
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(.systemGray), lineWidth: 2)
                )
                .padding()
            
            Toggle(isOn: $prio) {
                Text("Priority")
            }
            .padding(.bottom, 5)
            
            HStack{
                
            Text("Category")
            
            Spacer()
            
            Picker("Category", selection: $selectedCategory) //gets the category
                        {
                            ForEach(0 ..< categoryTypes.count){
                                Text(self.categoryTypes[$0])
                            }
                            //populates the picker by looping through the array
                        }
            }
            
            DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
            )            
            
            TextField(
                "Description:",
                text: $desc
            )
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(.systemGray), lineWidth: 2)
                )
                .padding()
            
            Spacer()

            
        }.padding() //VStack
                .navigationTitle("Add To-Do")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.bottom)
                .toolbar(content: {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button(action: {
                                        self.showAddToDoView = false
                                    }, label: {
                                        Text("Cancel")
                                            .foregroundColor(Color(.systemRed))

                                    })
                                }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            self.showAddToDoView = false

                            let newTodoCD = TodoCD(context: viewContext)
                            newTodoCD.name = name
                            newTodoCD.date = date
                            newTodoCD.desc = desc
                            newTodoCD.tag = tag
                            newTodoCD.priority = prio
                            newTodoCD.category = categoryTypes[selectedCategory]
                            do{
                                try viewContext.save()
                            }
                            catch{
                                let error = error as NSError
                                fatalError("unresolved error:\(error)")
                            }

                        }, //.append adds the item at the end of the list . insert at the start
                               label: {
                                Text("Done")
                        }) //button
                    }
                    
                }) //toolbar

        
    } //navigationView
        
     
  }
} //addTodoView

    
    private func deleteTodo(offsets: IndexSet){
        for index in offsets{
            let todo = todosCD[index]
            viewContext.delete(todo)
            do{
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("unresolved error:\(error)")
            }
        }
    } //deleteTodo
    
    private func updateTodo(todo: FetchedResults<TodoCD>.Element){
        todo.name = "😊"
        do{
            try viewContext.save()
        } catch{
            let error = error as NSError
            fatalError("unresolved error:\(error)")
        }
    } //updateTodo
    
    private func calculateDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            
            dateFormatter.calendar = Calendar(identifier: .gregorian)
            dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm"
            let dateString = dateFormatter.string(from: date)
            return dateString
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

/* NB: To avoid inconsistency, a view should refer ONLY to a SINGLE view. */
}

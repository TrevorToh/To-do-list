import SwiftUI
import SwiftPersistence

struct ContentView: View {
    @State var sheets = false
    @State var name = ""
    @State var date = Date()
    @State var description = ""
    @Persistent("array") var fulllist: [String] = []
    @State var full = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fulllist.indices, id: \.self) { index in
                        Menu{
                            Button{
                                fulllist.remove(at: index)
                            } label: {
                                Text("delete")
                            }
                            Button{
                                fulllist.remove(at: index)
                            } label: {
                                Text("Mark as done")
                            }
                            
                        } label: {
                            Text(fulllist[index])
                                .foregroundColor(.black)
                        }
                    }
                }

                Button {
                    sheets = true
                } label: {
                    Text("Create")
                }
                .sheet(isPresented: $sheets) {
                    NavigationView {
                        VStack {
                            List {
                                HStack {
                                    Text("Name: ")
                                    TextField("Type here", text: $name)
                                }
                                HStack{
                                    Text("Description: ")
                                    TextField("Type here",text: $description)
                                }
                                HStack {
                                    Text("Date: ")
                                    DatePicker("", selection: $date, displayedComponents: [.date])
                                }
                                // Add priority system UI if you'd like
                            }
                            Button {
                                if !name.isEmpty {
                                    full = """
                                            - Name: \(name)
                                            
                                            - Description: \(description)
                                            - Date: \(formattedDate(date: date))
                                            """
                                    fulllist.append(full)
                                    name = ""
                                    description = ""
                                    date = Date() // Reset the date
                                    sheets = false
                                }
                            } label: {
                                Text("Create")
                            }
                        }
                        .navigationTitle("New to-do")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            .navigationTitle("To-do List")
        }
    }

    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

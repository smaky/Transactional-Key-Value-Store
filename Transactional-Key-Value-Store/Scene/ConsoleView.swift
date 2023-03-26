//
//  ContentView.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import SwiftUI

struct ConsoleView: View {
    @StateObject var viewModel: ConsoleViewModel = ConsoleViewModel(store: VirtualStore())
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack {
            TextField("Type command", text: $textFieldText)
                .onSubmit {
                    viewModel.executeCommand(textFieldText)
                }
                .padding([.leading, .trailing], 15)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView()
    }
}

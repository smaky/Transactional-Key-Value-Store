//
//  ContentView.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import SwiftUI

struct ConsoleView: View {
    private var viewModel: ConsoleViewModel
    @State var textFieldText: String = ""
    @FocusState private var isFocused: Bool
    
    init(store: StoreInterface) {
        viewModel = ConsoleViewModel(store: store)
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView(.vertical) {
                    ForEach(viewModel.logs) { log in
                        LogRowView(text: log.text)
                            .padding([.leading, .trailing], 15)
                    }
                    Spacer()
                    TextField("Type command: help - for more information", text: $textFieldText)
                        .focused($isFocused)
                        .onSubmit {
                            viewModel.executeCommand(textFieldText)
                            textFieldText = ""
                            isFocused = true
                            
                        }
                        .padding([.leading, .trailing], 15)
                        .id("commandTextField")
                }
                .id("LogScrollView")
                .onChange(of: viewModel.logs) { _ in
#if os(macOS)
                    scrollView.scrollTo("commandTextField", anchor: .top)
#else
                    scrollView.scrollTo("commandTextField", anchor: .bottom)
#endif
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView(store: VirtualStore())
    }
}

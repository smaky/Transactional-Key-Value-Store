//
//  LogRowView.swift
//  Transactional-Key-Value-Store
//
//  Created by Damian Smakulski on 26/03/2023.
//

import SwiftUI

struct LogRowView: View {
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }
    }
}

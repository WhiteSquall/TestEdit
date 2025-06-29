//
//  ContentView.swift
//  TestEdit
//
//  Created by WhiteSquall on 6/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var text = "텍스트 입력 영역"
    
    var body: some View {
        HSplitView {
            TextEditor(text: $text)
                .padding()
                .frame(minWidth: 200)
            
            GraphicsView()
                .frame(minWidth: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct GraphicsView: View {
    var body: some View {
        Canvas { context, size in
            context.fill(
                Path(ellipseIn: CGRect(x: 50, y: 50, width: 200, height: 200)),
                with: .color(.blue)
            )
        }
        .background(Color(white: 0.95))
    }
}

#Preview {
    ContentView()
}

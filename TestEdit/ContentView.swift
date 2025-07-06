import SwiftUI

class AppState: ObservableObject {
    @Published var text = ""
    @Published var triggerAlphabets = "a"
}

struct MainWindowView: View {
    @EnvironmentObject var appState: AppState
    @State private var settingsWindowController: SettingsWindowController?
    
    var body: some View {
        HSplitView {
            CustomTextView(text: $appState.text, triggers: appState.triggerAlphabets)
                .padding()
                .frame(minWidth: 200)
            
            Canvas { context, size in
                context.fill(
                    Path(ellipseIn: CGRect(x: 50, y: 50, width: 200, height: 200)),
                    with: .color(.blue)
                )
            }
            .background(Color(white: 0.95))
            .frame(minWidth: 300)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("설정 열기") {
                    let controller = SettingsWindowController(appState: appState)
                    controller.showWindow(nil)
                    settingsWindowController = controller
                }
            }
        }
    }
}

struct SettingsWindowView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("트리거 알파벳 설정")
                .font(.headline)
            
            TextField("트리거 문자 입력", text: $appState.triggerAlphabets)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
            
            Text("현재 설정: '\(appState.triggerAlphabets)'")
                .foregroundColor(.secondary)
            
            Button("닫기") {
                NSApp.keyWindow?.close()
            }
        }
        .padding()
        .frame(width: 300, height: 200)
    }
}

struct CustomTextView: NSViewRepresentable {
    @Binding var text: String
    let triggers: String
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CustomTextView
        
        init(_ parent: CustomTextView) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            let newText = textView.string
            
            if let lastChar = newText.last, parent.triggers.contains(String(lastChar)) {
                let updatedText = newText + " "
                textView.string = updatedText
                textView.selectedRange = NSRange(location: updatedText.count, length: 0)
                
                parent.text = updatedText
            } else {
                parent.text = newText
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.delegate = context.coordinator
        textView.isRichText = false
        textView.font = NSFont.systemFont(ofSize: 14)
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        if nsView.string != text {
            nsView.string = text
        }
    }
}

import SwiftUI

@main
struct TestEditApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        
        WindowGroup("TestEdit") {
            MainWindowView()
                .environmentObject(appState)
        }
        
        WindowGroup("설정") {
            SettingsWindowView()
                .environmentObject(appState)
        }
        .handlesExternalEvents(matching: ["settings"])
        
    }
    
}

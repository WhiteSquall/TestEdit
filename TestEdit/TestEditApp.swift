import SwiftUI

@main
struct TestEditApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        
        WindowGroup("Main Window") {
            MainWindowView()
                .environmentObject(appState)
        }
        
        WindowGroup("Setting") {
            SettingsWindowView()
                .environmentObject(appState)
        }
        .handlesExternalEvents(matching: ["settings"])
        
    }
    
}

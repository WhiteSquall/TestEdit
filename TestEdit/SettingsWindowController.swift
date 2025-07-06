import SwiftUI

class SettingsWindowController: NSWindowController {
    
    init(appState: AppState) {
        let settingView = SettingsWindowView().environmentObject(appState)
        let hostingController = NSHostingController(rootView: settingView)
        let window = NSWindow(contentViewController: hostingController)
        window.title = "설정"
        window.setContentSize(NSSize(width: 300, height: 200))
        window.styleMask.insert(.titled)
        window.styleMask.insert(.closable)
        window.styleMask.insert(.miniaturizable)
        window.styleMask.insert(.resizable)
        super.init(window: window)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

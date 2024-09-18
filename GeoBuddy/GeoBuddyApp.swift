import SwiftUI

@main
struct GeoBuddyApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(modelData)
        }
    }
}

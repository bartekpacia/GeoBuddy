import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ConverterView()
                .tabItem {
                    Label("Converter", systemImage: "list.dash")
                }

            SavedView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}

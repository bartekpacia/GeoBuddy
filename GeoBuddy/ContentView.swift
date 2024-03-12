import SwiftUI

struct ContentView: View {
  @State private var lat: Int? = nil
  @State private var lng: Int? = nil

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)

      Text("Degrees Minutes Seconds (D° M' S\")")
        .frame(maxWidth: .infinity, alignment: .leading)

      TextField("Enter latitude", value: $lat, format: .number)
        .textFieldStyle(.roundedBorder)
      TextField("Enter longitude", value: $lng, format: .number)
        .textFieldStyle(.roundedBorder)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}

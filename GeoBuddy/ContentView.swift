import SwiftUI

enum CoordinateFormat {
  /// For example: 45° 46' 52" N 108° 30' 14" W
  case degreesMinutesSeconds

  /// For example: 45° 46.8666' N 108° 30.2333' W
  case decimalMinutes

  /// For example:  45.78111° N 108.50388° W
  case decimalDegrees
}

struct ContentView: View {
  @State private var lat: Int? = nil
  @State private var lng: Int? = nil

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")

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

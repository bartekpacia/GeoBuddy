import Combine
import Foundation

struct SavedCoordinate: Codable, Identifiable {
    var coordinate: LatLng
    var name: String
    let isFavorite: Bool
    
    var id: String { name }
}

struct LatLng: Codable {
    var lat: Double
    let lng: Double
}

final class ModelData: ObservableObject {
  @Published var savedCoordinates: [SavedCoordinate] = load("saved.json")
}

func load<T: Decodable>(_ filename: String) -> T {
  let data: Data

  guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
  else {
    fatalError("Could not find \(filename) in main bundle")
  }

  do {
    data = try Data(contentsOf: file)
  } catch {
    fatalError("Could not load \(filename) from main bundle:\n\(error)")
  }

  do {
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
  } catch {
    fatalError("Could not parse \(filename) as \(T.self):\n\(error)")
  }
}

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
    @Published var savedCoordinates: [SavedCoordinate] = load("saved.json") {
        didSet {
            save(savedCoordinates, to: "saved.json")
        }
    }
}

func save<T: Encodable>(_ data: T, to filename: String) {
    let url = getDocumentsDirectory().appendingPathComponent(filename)
    
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(data)
        try data.write(to: url)
    } catch {
        fatalError("Could not save \(filename) to documents directory:\n\(error)")
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let url = getDocumentsDirectory().appendingPathComponent(filename)
    
    guard FileManager.default.fileExists(atPath: url.path) else {
        return loadFromResources(filename)
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Could not load \(filename) from documents directory:\n\(error)")
    }
}

func loadFromResources<T: Decodable>(_ filename: String) -> T {
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

func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

import SwiftUI

struct CoordinateRow: View {
    var coordinate: SavedCoordinate

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(coordinate.name)
                Text(
                    "\(coordinate.coordinate.lat) \(coordinate.coordinate.lng)"
                )
            }

            Spacer()

            if coordinate.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct CoordinateRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoordinateRow(coordinate: ModelData().savedCoordinates[0])
            CoordinateRow(coordinate: ModelData().savedCoordinates[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}

import CoreLocation
import Foundation
import SwiftUI

struct SavedView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false

    var filteredCoordinate: [SavedCoordinate] {
        modelData.savedCoordinates.filter { landmark in
            if showFavoritesOnly {
                return landmark.isFavorite
            }

            return true
        }
    }

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }

                ForEach(filteredCoordinate) { coordinate in
                    CoordinateRow(coordinate: coordinate)
                }.onDelete(perform: { indexSet in
                    modelData.savedCoordinates.remove(atOffsets: indexSet)
                })
            }
        }
    }

}

struct SavedView_Previews: PreviewProvider {
  static var previews: some View {
      SavedView().environmentObject(ModelData())
  }
}

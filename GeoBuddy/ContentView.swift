import SwiftUI


struct ResultView: View{
  var dms:GeoCoordinate? = nil
  var dm:GeoCoordinate? = nil
  var dd:GeoCoordinate? = nil
  var body: some View{
    if let dms = dms
    {
      Text("D° M' S\"")
        .frame(maxWidth: .infinity, alignment: .leading)
      Text(dms.toString)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    if let dm = dm
    {
      Text("D° M'")
        .frame(maxWidth: .infinity, alignment: .leading)
      Text(dm.toString)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
  }
}

struct FromDDView: View {
  var cord: Float
  var body: some View {
    let converter = Converter()
    let dms = converter.convert(from: GeoCoordinate.dd(degrees: cord), to: .degreesMinutesSeconds)
    let dm = converter.convert(from: GeoCoordinate.dd(degrees: cord), to: .decimalMinutes)
    ResultView(dms:dms,dm:dm)
  }
}

struct ContentView: View {
  @State var lat: Float? = nil
  @State var lng: Float? = nil
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      
      Text("From Decimal Degrees")
        .frame(maxWidth: .infinity, alignment: .center)
      HStack{      Text("D°")
        TextField("Enter latitude", value: $lat, format: .number)
        .textFieldStyle(.roundedBorder)}
      HStack{      Text("D°")
        TextField("Enter longitude", value: $lng, format: .number)
          .textFieldStyle(.roundedBorder)
      }
      HStack{
        if let lat = lat
        {
          
          VStack{
            Text("Lattitude:")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)
            FromDDView(cord: lat)
          }
        }
        if let lng = lng{
          VStack{
            Text("Longtitude:")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)
            FromDDView(cord: lng)
          }
        }
      }
    }.padding()
  }
}

#Preview {
  ContentView(lat:13.563,lng:54.5643)
}

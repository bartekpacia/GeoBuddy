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
    if let dd = dd
    {
      Text("D°")
        .frame(maxWidth: .infinity, alignment: .leading)
      Text(dd.toString)
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

struct InputView: View {
  @Binding var lat: DMSTuple
  @Binding var lng: DMSTuple
  @Binding var fromType: GeoCoordinateFormat
  var body: some View {
    VStack {
      Text("Latitude:")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
      HStack{
        Text("D°")
        TextField("°", value: $lat.degrees , format: .number)
          .textFieldStyle(.roundedBorder)
      }
      .padding(.bottom, 16.0)
      Text("Longitude:")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
      HStack{
        Text("D°")
        TextField("°", value: $lng.degrees , format: .number)
          .textFieldStyle(.roundedBorder)
      }

    }
  }
}

struct CordTypeOutputView: View {
  var title: String
  @Binding var cord: DMSTuple
  @Binding var fromType: GeoCoordinateFormat
  var body: some View {
    VStack{
      if let deg = cord.degrees
      {
          Text("\(title):")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
          FromDDView(cord: deg)

      }


    }
  }
}

struct OutputView: View {
  @Binding var lat: DMSTuple
  @Binding var lng: DMSTuple
  @Binding var fromType: GeoCoordinateFormat
  var body: some View {
    HStack{
      CordTypeOutputView(title: "Latitude", cord: $lat, fromType: $fromType)
      CordTypeOutputView(title: "Longitude", cord: $lng, fromType: $fromType)
    }
  }
}


struct ContentView: View {
  @State var lat: DMSTuple = DMSTuple()
  @State var lng: DMSTuple = DMSTuple()
  @State private var fromType: GeoCoordinateFormat = GeoCoordinateFormat.decimalDegrees
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .padding(.bottom, 16.0)
        .imageScale(.large)
        .foregroundStyle(.tint)


        Picker(selection: $fromType, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
          Text("DD°").tag(GeoCoordinateFormat.decimalDegrees)
        }          .frame(maxWidth: .infinity, alignment: .trailing).pickerStyle(.segmented)          .padding(.bottom, 28.0)
      
      
      InputView(lat: $lat, lng: $lng, fromType: $fromType)

      OutputView(lat: $lat, lng: $lng, fromType: $fromType)

      .padding(.top, 18.0)
    }.padding(28.0)
  }
}

#Preview {
  ContentView(lat:DMSTuple(degrees: 13.563) ,lng:DMSTuple(degrees: 54.5643))
}

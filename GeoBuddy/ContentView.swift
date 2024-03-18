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
struct FromDMView: View {
  var deg: Float
  var min: Float
  var body: some View {
    let converter = Converter()
    let dms = converter.convert(from: GeoCoordinate.dm(degrees: Int(deg),minutes: min), to: .degreesMinutesSeconds)
    let dd = converter.convert(from: GeoCoordinate.dm(degrees: Int(deg),minutes: min), to: .decimalDegrees)
    ResultView(dms:dms,dd:dd)
  }
}

struct FromDMSView: View {
  var deg: Float
  var min: Float
  var sec: Float
  var body: some View {
    let converter = Converter()
    let dm = converter.convert(from: GeoCoordinate.dms(degrees: Int(deg),minutes: Int(min),seconds: sec), to: .decimalMinutes)
    let dd = converter.convert(from: GeoCoordinate.dms(degrees: Int(deg),minutes:Int(min),seconds: sec), to: .decimalDegrees)
    ResultView(dm:dm,dd:dd)
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
        if fromType == GeoCoordinateFormat.degreesMinutesSeconds || fromType == GeoCoordinateFormat.decimalMinutes
        {
          Text("M'")
           TextField("'", value: $lat.minutes , format: .number)
             .textFieldStyle(.roundedBorder)
        }
        if fromType == GeoCoordinateFormat.degreesMinutesSeconds
        {
          Text("S\"")
           TextField("\"", value: $lat.seconds , format: .number)
            .textFieldStyle(.roundedBorder)
        }
      }
      .padding(.bottom, 16.0)
      Text("Longitude:")
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
      HStack{
        Text("D°")
        TextField("°", value: $lng.degrees , format: .number)
          .textFieldStyle(.roundedBorder)
        if fromType == GeoCoordinateFormat.degreesMinutesSeconds || fromType == GeoCoordinateFormat.decimalMinutes
        {
          Text("M'")
           TextField("'", value: $lng.minutes , format: .number)
             .textFieldStyle(.roundedBorder)
        }
        if fromType == GeoCoordinateFormat.degreesMinutesSeconds
        {
          Text("S\"")
           TextField("\"", value: $lng.seconds , format: .number)
             .textFieldStyle(.roundedBorder)
        }
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

        switch fromType {
        case .degreesMinutesSeconds:
          if let min = cord.minutes, let sec = cord.seconds
          {
            Text("\(title):")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)
            FromDMSView(deg: deg, min: min,sec: sec)
          }
        case .decimalMinutes:
          if let min = cord.minutes
          {
            Text("\(title):")
              .font(.headline)
              .frame(maxWidth: .infinity, alignment: .leading)
            FromDMView(deg: deg, min: min)
          }
        case .decimalDegrees:
          Text("\(title):")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
          FromDDView(cord: deg)
        }

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
          Text("D°M'").tag(GeoCoordinateFormat.decimalMinutes)
          Text("D°M'S\"").tag(GeoCoordinateFormat.degreesMinutesSeconds)
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

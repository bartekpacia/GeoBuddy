import Foundation

func tuplesWithTypeToDD(lat: DMSTuple, lng: DMSTuple, format: GeoCoordinateFormat) {
    
}

struct DMSTuple: Codable {
  var degrees: Float? = nil
  var minutes: Float? = nil
  var seconds: Float? = nil
}

enum GeoCoordinateFormat {
  case degreesMinutesSeconds
  case decimalMinutes
  case decimalDegrees
}

enum GeoCoordinate: Equatable {
  /// For example: 45° 46' 52" N 108° 30' 14" W
  case dms(degrees: Int, minutes: Int, seconds: Float)
  
  /// For example: 45° 46.8666' N 108° 30.2333' W
  case dm(degrees: Int, minutes: Float)
  
  /// For example:  45.78111° N 108.50388° W
  case dd(degrees: Float)
  
  var format: GeoCoordinateFormat {
    switch self {
    case .dms:
      return .degreesMinutesSeconds
    case .dm:
      return .decimalMinutes
    case .dd:
      return .decimalDegrees
    }
  }
  var degrees: Float {
      switch self {
      case .dms(let degrees, _, _):
          return Float(degrees)
      case .dm(let degrees, _):
          return Float(degrees)
      case .dd(let decimalDegrees):
          return decimalDegrees
      }
  }
  var minutes: Float {
      switch self {
      case .dms(_, let minutes, _):
          return Float(abs(minutes))
      case .dm(_, let minutes):
          return abs(minutes)
      case .dd(_):
          return 0
      }
  }
  var seconds: Float {
      switch self {
      case .dms(_, _, let seconds):
          return abs(seconds)
      case .dm(_, _):
          return 0
      case .dd(_):
          return 0
      }
  }
  var toString: String{
    switch self {
    case .dms(_, _, _):
      return "\(Int(degrees))° \(Int(minutes))' \(seconds.formatted(.number.precision(.fractionLength(0...2))))"
    case .dm(_, _):
        return "\(Int(degrees))° \(minutes.formatted(.number.precision(.fractionLength(0...3))))'"
    case .dd(_):
        return "\(degrees.formatted(.number.precision(.fractionLength(0...4))))"
    }
  }
}

/// Converts between various geographical coordinates formats.
///
/// All coordinates are first converted to Decimal Degrees, since it's the simplest
/// and most versatile.
class Converter {
  func convert(from source: GeoCoordinate, to target: GeoCoordinateFormat) -> GeoCoordinate {
    let commonRepresentation = convertFrom(source)
    
    switch target {
    case .degreesMinutesSeconds:
      return convertToDMS(commonRepresentation)
    case .decimalMinutes:
      return convertToDM(commonRepresentation)
    case .decimalDegrees:
      return commonRepresentation
    }
  }
  
  // MARK: Conversions to the common format (Decimal Degrees)
  
  private func convertFrom(_ source: GeoCoordinate) -> GeoCoordinate {
    switch source {
    case .dms(let degrees, let decimalMinutes, let decimalSeconds):
      return GeoCoordinate.dd(
        degrees: Float(degrees) + (Float(decimalMinutes) / 60) + (Float(decimalSeconds) / 3600))
    case .dm(let degrees, let decimalMinutes):
      return GeoCoordinate.dd(degrees: Float(degrees) + (decimalMinutes / 60))
    case .dd(let decimalDegrees):
      return GeoCoordinate.dd(degrees: decimalDegrees)
    }
  }
  // MARK: Conversions from the common format (Decimal Degrees)
  
  private func convertToDMS(_ source: GeoCoordinate) -> GeoCoordinate {
    switch source {
    case .dd(let decimalDegrees):
      let degrees = Int(decimalDegrees)
      let remainingMinutes = (decimalDegrees - Float(degrees)) * 60
      let minutes = Int(remainingMinutes)
      let seconds = (remainingMinutes - Float(minutes)) * 60
      return GeoCoordinate.dms(degrees: degrees, minutes: minutes, seconds: seconds)
    default:
      return source // No conversion needed
    }
  }
  
  private func convertToDM(_ source: GeoCoordinate) -> GeoCoordinate {
    switch source {
    case .dd(let decimalDegrees):
      let degrees = Int(decimalDegrees)
      let minutes = (decimalDegrees - Float(degrees)) * 60
      return GeoCoordinate.dm(degrees: degrees, minutes: minutes)
    default:
      return source // No conversion needed
    }
  }
}

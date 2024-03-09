import Foundation

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
}

/// Converts between various geographical coordinates formats.
///
/// All coordinates are first converted to Decimal Degrees, since it's the simplest
/// and most versatile.
class Converter {
  func convert(from source: GeoCoordinate, to target: GeoCoordinateFormat) -> GeoCoordinate {
    let commonRepresentation = convertFrom(source)

    return commonRepresentation
  }

  // MARK: Conversions to the common format (Decimal Degrees)

  private func convertFrom(_ source: GeoCoordinate) -> GeoCoordinate {
    switch source {
    case .dms(let degrees, let decimalMinutes, let decimalSeconds):
      return GeoCoordinate.dd(
        degrees: Float(degrees) + Float(decimalMinutes) / 60 + Float(decimalSeconds) / 3600)
    case .dm(let degrees, let decimalMinutes):
      return GeoCoordinate.dd(degrees: Float(degrees) + decimalMinutes / 60)
    case .dd(let decimalDegrees):
      return GeoCoordinate.dd(degrees: decimalDegrees)
    }
  }

  // MARK: Conversions from the common format (Decimal Degrees)

//  private func convertTo(_ source: GeoCoordinate) -> GeoCoordinate {
//    
//  }
}

import XCTest

@testable import GeoBuddy

final class GeoBuddyTests: XCTestCase {

  func testDMStoDD() throws {
    let converter = Converter()

    let sourceCoordLat = GeoCoordinate.dms(degrees: 50, minutes: 10, seconds: 23.297)
    let sourceCoordLng = GeoCoordinate.dms(degrees: 18, minutes: 25, seconds: 46.142)

    XCTAssertEqual(
      converter.convert(from: sourceCoordLat, to: .decimalDegrees),
      GeoCoordinate.dd(degrees: 50.173138)
    )

    XCTAssertEqual(
      converter.convert(from: sourceCoordLng, to: .decimalDegrees),
      GeoCoordinate.dd(degrees: 18.429484)
    )
  }
}

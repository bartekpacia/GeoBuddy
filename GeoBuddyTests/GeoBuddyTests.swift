import XCTest

@testable import GeoBuddy

final class GeoBuddyTests: XCTestCase {
  
  let converter = Converter()
  
  func testDMStoDD() throws {
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
  
  func testDMtoDD() throws
  {
    let coordinate = GeoCoordinate.dm(degrees: 45, minutes: 46.969997)
    let convertedToDD = converter.convert(from: coordinate, to: .decimalDegrees)
    XCTAssertEqual(convertedToDD,GeoCoordinate.dd(degrees: 45.782833))
  }
  
  func testDDtoDD() throws
  {
    let coordinate = GeoCoordinate.dd(degrees: 45.78111)
    let convertedToDD = converter.convert(from: coordinate, to: .decimalDegrees)
    XCTAssertEqual(convertedToDD,coordinate)
  }
  
  func testDDtoDMS() throws
  {
    let coordinate = GeoCoordinate.dd(degrees: 45.78111)
    let convertedToDMS = converter.convert(from: coordinate, to: .degreesMinutesSeconds)
    XCTAssertEqual(convertedToDMS,GeoCoordinate.dms(degrees:45, minutes: 46, seconds: 51.991882))
  }
  
  func testDDtoDM() throws
  {
    let coordinate = GeoCoordinate.dd(degrees: 45.78111)
    let convertedToDM = converter.convert(from: coordinate, to: .decimalMinutes)
    XCTAssertEqual(convertedToDM,GeoCoordinate.dm(degrees: 45, minutes: 46.86653))
  }
}

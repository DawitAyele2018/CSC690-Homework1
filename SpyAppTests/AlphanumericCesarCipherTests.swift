import XCTest
@testable import SpyApp

class AlphanumericCeasarCipherTests: XCTestCase {
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AlphanumericCesarCipher()
    }
    
    func test_emptySecret() {
        XCTAssertEqual("Enter Cipher Key", cipher.encode("Test",key: ""))
        XCTAssertEqual("Enter Cipher Key", cipher.decode("Test",key: ""))
    }
    
    func test_cipherTextDigitsAreValid() {
        let result = cipher.encode("0123456789",key: "0")
        XCTAssertEqual("0123456789", result)
    }
    
    func test_encodingAlgorithmWithMultipleSecrets() {

        XCTAssertEqual("DAWIT", cipher.encode("Dawit",key: "0"))
        
        XCTAssertEqual("EBXJU", cipher.encode("DAWIT",key: "1"))

        XCTAssertEqual("FCYKV", cipher.encode("DAWIT",key: "2"))

        XCTAssertEqual("GDZLW", cipher.encode("DAWIT",key: "3"))
    }
    
    func test_characterSkipping() {
        XCTAssertEqual(cipher.encode("9",key: "1"), "A")

        XCTAssertEqual(cipher.decode("0",key: "1"), "Z")

        XCTAssertEqual(cipher.encode("Z",key: "1"), "0")
 
        XCTAssertEqual(cipher.decode("A",key: "1"), "9")
        
    }
    
    // Decoding Unit Tests
    func test_decodingAlgorithmWithMultipleSecrets() {

        XCTAssertEqual("DAWIT", cipher.decode("DAWIT",key: "0"))

        XCTAssertEqual("DAWIT", cipher.decode("EBXJU",key: "1"))

        XCTAssertEqual("DAWIT", cipher.decode("FCYKV",key: "2"))

        XCTAssertEqual("DAWIT", cipher.decode("GDZLW",key: "3"))
    }
}


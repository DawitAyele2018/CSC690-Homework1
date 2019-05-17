import XCTest
@testable import SpyApp

class CeasarCipherTests: XCTestCase {
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = CeaserCipher()
    }
    
    // Invalid Validation Unit Tests
    func test_emptyCipherText() {
        let encodeResult = cipher.encode("",key: "0")
        let decodeResult = cipher.decode("",key: "0")
        XCTAssertEqual("Enter Cipher Text", encodeResult)
        XCTAssertEqual("Enter Cipher Text", decodeResult)
    }
    
    func test_emptySecret() {
//        let encodeResult = cipher.encode("Test Cipher Text",key: "")
//        let decodeResult = cipher.decode("Test Cipher Text",key: "")
        XCTAssertEqual("Enter Cipher Key", cipher.encode("Test Cipher Text",key: ""))
        XCTAssertEqual("Enter Cipher Key", cipher.decode("Test Cipher Text",key: ""))
    }
    
    func test_nonNumericInputForSecret() {

        XCTAssertEqual("Enter Valid Cipher Key", cipher.encode("Test Cipher Text",key: "A"))
        XCTAssertEqual("Enter Valid Cipher Key", cipher.decode("Test Cipher Text",key: "A"))
    }
    
    func test_negativeSecretValue() {
        XCTAssertEqual("Enter Valid Cipher Key", cipher.encode("Test Cipher Text",key: "-1"))
        XCTAssertEqual("Enter Valid Cipher Key", cipher.decode("Test Cipher Text",key: "-1"))
    }
    
    // Encoding Unit Tests
    func test_oneCharacterStringGetsMappedToSelfWith_0_secret() {
        let plaintext = "a"
        let result = cipher.encode(plaintext,key: "0")
        XCTAssertEqual(plaintext, result)
    }
    
    func test_encodingAlgorithmWithMultipleSecrets() {
        XCTAssertEqual("DAWIT", cipher.encode("DAWIT",key: "0"))

        XCTAssertEqual("EBXJU", cipher.encode("DAWIT",key: "1"))

        XCTAssertEqual("FCYKV", cipher.encode("DAWIT",key: "2"))

        XCTAssertEqual("GDZLW", cipher.encode("DAWIT",key: "3"))
    }
    
    // Decoding Unit Tests
    func test_decodingAlgorithmWithMultipleSecrets() {

        XCTAssertEqual("DAWIT", cipher.decode("DAWIT",key: "0"))

        XCTAssertEqual("DAWIT", cipher.decode("EBXJU",key: "1"))

        XCTAssertEqual("DAWIT", cipher.decode("FCYKV",key: "2"))

        XCTAssertEqual("DAWIT", cipher.decode("GDZLW",key: "3"))
    }
}

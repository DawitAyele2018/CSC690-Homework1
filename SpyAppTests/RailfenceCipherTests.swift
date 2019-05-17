import XCTest
@testable import SpyApp

class RailfenceCipherTests: XCTestCase {
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = RailfenceCipher()
    }
    

    
    // Encoding Unit Tests
    func test_encodingAlgorithmWithMultipleSecrets() {
        XCTAssertEqual("MSypypAp", cipher.encode("My Spy App",key: "2"))

        XCTAssertEqual("MyypApSp", cipher.encode("My Spy App",key: "3"))

        XCTAssertEqual("MpyApSyp", cipher.encode("My Spy App",key: "4"))

        XCTAssertEqual("MypSppAy", cipher.encode("My Spy App",key: "5"))
    }
    
    // Decoding Unit Tests
    func test_decodingAlgorithmWithMultipleSecrets() {
        
        XCTAssertEqual("MySpyApp", cipher.decode("MSypypAp",key: "2"))
        
        XCTAssertEqual("MySpyApp", cipher.decode("MyypApSp",key: "3"))
        
        XCTAssertEqual("MySpyApp", cipher.decode("MpyApSyp",key: "4"))
        
        XCTAssertEqual("MySpyApp", cipher.decode("MypSppAy",key: "5"))
    }
}


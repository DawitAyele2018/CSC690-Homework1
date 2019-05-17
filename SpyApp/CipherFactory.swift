import Foundation

struct CipherFactory {

    private var ciphers: [ String: Cipher ] = [
        "Cesar Cipher": CeaserCipher(),
        "Alphanumeric Cesar Cipher": AlphanumericCesarCipher(),
        "Rail-Fence Cipher": RailfenceCipher(),
    ]

    func cipher( for key: String ) -> Cipher {
        return ciphers[ key ]!
    }
}

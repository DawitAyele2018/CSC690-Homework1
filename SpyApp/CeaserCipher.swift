import Foundation

protocol Cipher {
    func encode(_ unencryptedInput: String, key: String) -> String

    func decode(_ encryptedInput: String, key: String) -> String
    
    func inputValidate( input: String, key: String ) -> String
}


struct CeaserCipher: Cipher {

    func inputValidate(input: String, key: String) -> String {
        // Cipher Text Exists
        if( input.isEmpty ) { return "Enter Cipher Text" }
        
        // Secret must be present, and a valid number
        if( key.isEmpty )            { return "Enter Cipher Key" }
        else if( Int( key ) == nil  || Int( key )! < 0) { return "Enter Valid Cipher Key" }
        
        return "" // No Errors
    }
    
    func encode(_ unencryptedInput: String, key: String) -> String {
        // Check for Invalid Input
        let errorMessage = inputValidate( input: unencryptedInput, key: key )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var encoded = ""
        let shiftBy = UInt32(key)!

        for character in unencryptedInput {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            // update: UInt8 -> UInt16
            let shiftedCharacter = String(UnicodeScalar(UInt16(shiftedUnicode))!)
            encoded += shiftedCharacter
        }
        return encoded
    }
    
    func decode(_ encryptedInput: String, key: String) -> String {
        // Check for Invalid Input
        let errorMessage = inputValidate( input: encryptedInput, key: key )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var decoded = ""
        let shiftBy = UInt32(key)!
        
        for character in encryptedInput {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt16(shiftedUnicode))!)
            
            decoded += shiftedCharacter
        }
        return decoded
    }
}

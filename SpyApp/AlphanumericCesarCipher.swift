// Task #2
import Foundation

struct AlphanumericCesarCipher: Cipher {
    
    func inputValidate(input: String, key: String) -> String {
        // Cipher Text Exists
        if( input.isEmpty )                 { return "Enter Cipher Text" }
        else if( !isAlphanumeric( input ) ) { return "Enter Alphanumeric Cipher Text Only" }
        
        // Secret must be present, and a valid number
        if( key.isEmpty )            { return "Enter Cipher Key" }
        else if( Int( key ) == nil  || Int( key )! < 0 ) { return "Enter Valid Cipher Key" }

        return "" // No Errors
    }
    
    func isAlphanumeric( _ text: String ) -> Bool {
        return !text.isEmpty && text.range( of: "[^a-zA-Z0-9]", options: .regularExpression ) == nil
    }
    
    func codeInBounds( _ code:UInt32 ) -> UInt32 {
        let upperCaseAUnicode = String( "A" ).unicodeScalars.first!.value
        let upperCaseZUnicode = String( "Z" ).unicodeScalars.first!.value
        let numberZeroUnicode = String( "0" ).unicodeScalars.first!.value
        let numberNineUnicode = String( "9" ).unicodeScalars.first!.value
        
        if ( code > upperCaseZUnicode ) {
            return numberZeroUnicode
            
        } else if ( code == upperCaseAUnicode - 1 ) {
            return numberNineUnicode
            
        } else if ( code < numberZeroUnicode ) {
            return upperCaseZUnicode
            
        } else if ( code == numberNineUnicode + 1 ) {
            return upperCaseAUnicode
            
        }
        
        return code
    }
    
    func encode( _ unencryptedInput: String, key: String ) -> String {
        // Check for Invalid Input
        let errorMessage = inputValidate( input: unencryptedInput, key: key )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        var encodedText = ""
        let shiftBy = UInt32( key )!
        let lowerCaseText = unencryptedInput.uppercased()
        
        for character in lowerCaseText {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode + shiftBy
            shiftedUnicode = codeInBounds( shiftedUnicode )
            
            // update: UInt8 -> UInt16
            let shiftedCharacter = String( UnicodeScalar( UInt16( shiftedUnicode ) )! )
            
            encodedText += shiftedCharacter
        }
        return encodedText
    }
    
    func decode( _ encryptedInput: String, key: String ) -> String {
        // Check for Invalid Input
        let errorMessage = inputValidate( input: encryptedInput, key: key )
        if( !errorMessage.isEmpty ) { return errorMessage }

        var decodedMessage = ""
        let shiftBy = UInt32( key )!
        
        for character in encryptedInput {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode - shiftBy
            shiftedUnicode = codeInBounds( shiftedUnicode )
            
            // error: Thread 1: Fatal error: Not enough bits to represent a signed value
            // fix: UInt8 -> UInt16
            let shiftedCharacter = String( UnicodeScalar( UInt16( shiftedUnicode ) )! )
            
            decodedMessage += shiftedCharacter
        }
        return decodedMessage
    }
}

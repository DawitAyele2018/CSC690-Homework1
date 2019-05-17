import Foundation
//RailfenceCipher

struct RailfenceCipher: Cipher {
    func inputValidate( input: String, key: String ) -> String {
        // Cipher Text Exists
        if( input.isEmpty ) { return "Enter Cipher Text" }
        
        // Secret must be present, a number, and greater than 1
        if( key.isEmpty )            { return "Enter Cipher Key" }
        else if( Int( key ) == nil ) { return "Enter Valid Cipher Key" }
        else if( Int( key )! <= 1 )  { return "Enter Cipher Key greater than or equal to 2" }
        
        return "" // No Errors
    }
    
    // Flips -1 or +1 based on conditional
    func conditionalDirection( _ direction: Int, _ row: Int, _ MAX_UPPER_BOUND: Int ) -> Int {
        if( row == MAX_UPPER_BOUND || row == 0 ) { return ( direction * -1 ) }
        
        return direction
    }
    
    func encode( _ unencryptedInput: String, key: String ) -> String {
        // Check for Invalid Input
        let errorMessage = inputValidate( input: unencryptedInput, key: key )
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        // Remove Spaces from Cipher Text
        var trimmedCipherText = unencryptedInput.replacingOccurrences( of: " ", with: "" )
        
        var encryptedSubstringsArray = Array( repeating: "", count: Int( key )! )
        let MAX_UPPER_BOUND = Int( key )! - 1
        var currentRow = 0, direction = -1
        
        // Add characters to substrings in zig-zag pattern
        while !trimmedCipherText.isEmpty {
            let firstCharacter = trimmedCipherText.prefix( 1 )
            
            encryptedSubstringsArray[ currentRow ] += firstCharacter

            trimmedCipherText.remove( at: trimmedCipherText.startIndex )
            
            // Allows us to move in a zig-zag pattern through the 2D array
            direction = conditionalDirection( direction, currentRow, MAX_UPPER_BOUND )
            currentRow += direction
        }
        
        var encryptedText = ""
        
        for substring in encryptedSubstringsArray { encryptedText += substring }
        
        return encryptedText
    }
    
    func decode( _ encryptedInput: String, key: String ) -> String {
        // Check for Invalid Input
        let errorMessage = inputValidate( input: encryptedInput, key: key )
        
        if( !errorMessage.isEmpty ) { return errorMessage }
        
        // Set Variables needed for decoding algorithm
        let MAX_COLUMNS = encryptedInput.count, MAX_UPPER_BOUND = Int( key )! - 1
        var currentRow = 0, direction = -1, textToDecode = encryptedInput
        
        // Create secret x MAX_COLUMNS 2D array of X's
        var decodeMatrix = Array( repeating: Array(repeating: "❌", count: MAX_COLUMNS ), count: Int( key )! )
        
        // Traverse the decode matrix and place ✅'s on valid places to save characters
        // from the encrypted string
        for index in 0..<MAX_COLUMNS {
            decodeMatrix[ currentRow ][ index ] = "✅"

            // Allows us to move in a zig-zag pattern through the 2D array
            direction = conditionalDirection( direction, currentRow, MAX_UPPER_BOUND )
            currentRow += direction
        }
        
        // Place encrypedText's characters in valid spots
        for row in 0...MAX_UPPER_BOUND {
            for column in 0..<MAX_COLUMNS {
                if( decodeMatrix[ row ][ column ] == "✅" ) {
                    let firstCharacter = textToDecode.prefix( 1 )
                    
                    decodeMatrix[ row ][ column ].removeAll()
                    decodeMatrix[ row ][ column ] = String( firstCharacter )
                    
                    textToDecode.remove( at: textToDecode.startIndex )
                }
            }
        }
        
        // Build decrypted text string
        var decryptedText = ""
        currentRow = 0; direction = -1 // Reset currentRow and Direction
        
        for index in 0..<MAX_COLUMNS {
            decryptedText += decodeMatrix[ currentRow ][ index ]
            
            // Allows us to move in a zig-zag pattern through the 2D array
            direction = conditionalDirection( direction, currentRow, MAX_UPPER_BOUND )
            currentRow += direction
        }
        
        return decryptedText
    }
}

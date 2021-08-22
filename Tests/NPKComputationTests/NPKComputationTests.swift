import XCTest
import NPKComputation

@testable import NPKComputation

final class NPKComputationTests: XCTestCase {
    let c0: ColumnTuple = ColumnTuple(values: [1, 2, 3, 4])
    let m0: Matrix? = try? Matrix(values: [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    
    func testColumnTupleXMatrix() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        guard let m0: GenericMatrix = m0 else {
            XCTFail("unable to create matrix")
            return
        }
        do {
            let r0 = try c0 * m0
            print(r0.description)
        } catch {
            XCTFail("multiplication failed")
            return 
        }


    }
    
    
    func testMatrixXColumnTuple() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        //let r0 = m0 * c0






    }

    static var allTests = [
        ("test ColumnTuple * Matrix", testColumnTupleXMatrix),
        ("test Matrix * ColumnTuple", testMatrixXColumnTuple),
    ]
}

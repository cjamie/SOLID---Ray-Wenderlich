import XCTest
@testable import SOLID_in_iOS_apps

class CutePetsLoaderTests: XCTestCase {


    func test_showPets_ifNetworkLoadsThem(){
        let (sut, network) = makeSUT()
 
    }
    
    private func makeSUT(network: Network = TestNetwork()) -> (CutePetsLoader, Network) {
        return (CutePetsLoader(dependency: network), network)
    }
}

//
//  Networking.swift
//  MockProject
//
//  Created by Beatriz Herculano on 22/11/23.
//

import Foundation


class Networking{
    
    private static let mocked: NetworkProtocol = MockedNetworking()
    private static let real: NetworkProtocol = NetworkManager()
    static func shared()-> NetworkProtocol{
        guard let isMocked = ProcessInfo.processInfo.environment["Mocked"] else {
            return Networking.real
        }
        if(isMocked == "true"){
            return Networking.mocked
        } else {
            return Networking.real
        }
    }
}

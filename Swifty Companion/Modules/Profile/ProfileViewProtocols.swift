//
//  ProfileViewProtocols.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 01.06.2021.
//

import Foundation

protocol ProfileViewInputProtocol: AnyObject {

}

protocol ProfileViewOutputProtocol: AnyObject {
    func dataConfigure(_ data: ProfileData) -> (CommonData, [CursusData])
}

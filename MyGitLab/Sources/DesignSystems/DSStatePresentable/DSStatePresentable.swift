//
//  DSStatePresentable.swift
//  MyGitLab
//
//  Created by PHAM ANH TUAN on 15/06/2021.
//

import Foundation

protocol DSStatePresentable: AnyObject {
    func startLoading()
    func endLoading(error: Error?)
}

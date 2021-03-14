//
//  ViewModel.swift
//  Movie Filter Swift
//
//  Created by Timothy Kosakoy on 14/03/21.
//  Copyright © 2021 Re:Utopia. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    var films: [Films] { get set }
    var filmsFetched: (([Films]) -> Void)? { get set }
    var errors: [String] { get set }
    var errorFound: (([String]) -> Void)? { get set }
}

struct ViewModel : ViewModelProtocol {
    var films: [Films]
    var filmsFetched: (([Films]) -> Void)?
    var errors: [String]
    var errorFound: (([String]) -> Void)?
    
    var yearFilter: Int?
    var filteredFilms: [GhibliFilm]
    
    init() {
        films = [Films]()
        filmsFetched = nil
        errors = [String]()
        errorFound = nil
        yearFilter = nil
        filteredFilms = [GhibliFilm]()
    }
    
    mutating func getAllGhibliFilms() {
        FilmsDataService.Get.allGhibliFilms(for: self) { res, err, vm in
            guard let vm = vm as? ViewModel else {
                return
            }
            if let res = res {
                if let year = vm.yearFilter {
                    print("with year filter: \(year)")
                    print(res)
                } else {
                    print("no year filter")
                    print(res)
                }
            }
        }
    }
    
    mutating func setYearFilter(to year: String) {
        yearFilter = Int(year)
    }
}

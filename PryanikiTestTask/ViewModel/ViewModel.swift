//
//  ViewModel.swift
//  PryanikiTestTask
//
//  Created by Геннадий Махмудов on 02.02.2021.
//

import UIKit

//MARK: -ViewModel
class ViewModel: NSObject {
    
    private(set) var viewData = [ViewData]()
    private(set) var views = [String]()
    private(set) var dictOfData = [String:ViewData]()
    private(set) weak var updateDelegate: UpdateDelegate?
    
    override init() {
        super.init()
        loadServerData { [unowned self] in
            DispatchQueue.main.async {
                self.updateDelegate?.didUpdate(sender: self)
                fillTheDict()
            }
        }
    }
    private func fillTheDict(){
        for data in viewData {
            dictOfData[data.name] = data
        }
    }
    
    public final func setDelegate(delegate: UpdateDelegate){
        self.updateDelegate = delegate
    }
}
//MARK: -Parsing data
extension ViewModel {
    private func loadServerData(completion: @escaping () -> Void){
        NetworkClient.shared.parseData { [weak self] (serverData) in
            switch serverData{
            case .success(let capturedData):
                self?.viewData = capturedData.data
                self?.views = capturedData.view
                completion()
            case .failure:
                fatalError()
            }
        }
    }
}
//MARK: -UpdateDelegate
protocol UpdateDelegate: class {
    func didUpdate(sender: ViewModel)
}

//
//  ViewController.swift
//  PryanikiTestTask
//
//  Created by Геннадий Махмудов on 02.02.2021.
//

import UIKit

//MARK: -ViewController
class ViewController: UIViewController {
    
    fileprivate var collectionView: UICollectionView!
    
    private var viewModel: ViewModel!
    private let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureCollectionView()
        configureCollectionViewConstraints()
        configureUpdateDelegate()
    }
    
    private func configureViewModel(){
        viewModel = ViewModel()
    }
}
//MARK: -UpdateDelegate
extension ViewController: UpdateDelegate {
    func didUpdate(sender: ViewModel) {
        collectionView.reloadData()
    }
    private func configureUpdateDelegate(){
        viewModel.setDelegate(delegate: self)
    }
    
}
//MARK: -UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.views.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DataViewCell else {
            return UICollectionViewCell()
        }
        let view = viewModel.views[indexPath.item]
        let data = viewModel.dictOfData[view]
        let selectedId = data?.data.selectedId
        switch view {
        case "selector":
            cell.titleLabel.text = data?.data.variants![selectedId ?? 0].text
        case "picture":
            cell.titleLabel.text = ""
        default:
            cell.titleLabel.text = data?.data.text
        }
        cell.pictureView.setImage(with: data?.data.url ?? "")
        cell.layer.borderWidth = 1.0
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewData = viewModel.views[indexPath.item]
        let data = viewModel.dictOfData[viewData]
        if let name = data?.name {
            let rect = NSString(string: name).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
            return CGSize(width: view.frame.width, height: rect.height + 50)
        }
        return CGSize(width: view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewData = viewModel.views[indexPath.item]
        createAlert(with: viewData)
    }
    
    private func createAlert(with name:String){
        let ac = UIAlertController(title: "Attention!", message: "\(name) initialized the event", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    private func configureCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DataViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    private func configureCollectionViewConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}


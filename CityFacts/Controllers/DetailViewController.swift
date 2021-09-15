//
//  DetailViewController.swift
//  CityFacts
//
//  Created by Tai Chin Huang on 2021/9/14.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    

//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var webViewContainer: UIView!
    var flagImageView: WKWebView!
    var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var country: Country?
//    var countries = [Country]()
//    var name: String!
//    var capital: String!
//    var population: Int!
//    var area: Double!
//    var region: String!
//    var currency: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setConstraint()
        
        navigationItem.largeTitleDisplayMode = .never
        
//        flagImageView = WKWebView()
////        flagImageView.addSubview(webViewContainer)
//        webViewContainer.addSubview(flagImageView)
        
        imageView = UIImageView()
        
        guard let country = country else { return }
        
//        if let url = URL(string: country.flag) {
//            let request = URLRequest(url: url)
//            flagImageView.load(request)
//            print(url)
//        }
        
        let flagURLString = country.flag
        let url = URL(string: flagURLString)
        NetworkController.shared.fetchImage(url: url!) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.alpha = 1
                self.imageView.image = image
            }
        }
        view.addSubview(imageView)
        
        title = country.name
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = "\(country.population)"
        areaLabel.text = "\(country.area)"
        regionLabel.text = country.region
        currencyLabel.text = country.currencies.first?.name
    }
    
    func setConstraint() {
        webViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

//extension DetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailCell else {
//            fatalError("Fail to dequeue DetailCell")
//        }
//        return cell
//    }
//}

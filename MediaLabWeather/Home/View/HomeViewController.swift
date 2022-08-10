//
//  HomeViewController.swift
//  MediaLabWeather
//
//  Created by Renato Mateus on 10/08/22.
//

import UIKit
import CoreLocation
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var loading: UIActivityIndicatorView?
    internal let viewModel = HomeViewModel(with: WeatherService())
    private var locationManager: CLLocationManager?
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Please, allow the app to access your location.\nTouch in any place of the screen."
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "71 o"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Light raing"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mediumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Low: 58 High: 72"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "Wind: 8.5 (135)"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("RELOAD", for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .black
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupData()
    }
}

// MARK: SetupView
extension HomeViewController {
    private func setupView() {
        view.addSubview(scrollView)
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true
        
        
        scrollView.addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8.0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8.0).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20.0).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        let vStackView = UIStackView(arrangedSubviews: [cityNameLabel, weatherImageView,
                                                        temperatureLabel, subTitleLabel,
                                                        mediumTemperatureLabel, windSpeedLabel,
                                                        button])
        vStackView.spacing = 20
        vStackView.axis = .vertical
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.alignment = .center
        contentView.addSubview(vStackView)
        
        button.leftAnchor.constraint(equalTo: vStackView.leftAnchor, constant: 5).isActive = true
        button.rightAnchor.constraint(equalTo: vStackView.rightAnchor, constant: -5).isActive = true
        button.layer.cornerRadius = 8
        
        
        vStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        vStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        setupLoading()
        hideViews(hide: true, hideButton: true)
        setupActions()
    }
    
    private func setupLoading() {
        loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        loading?.color = UIColor.white
        loading?.translatesAutoresizingMaskIntoConstraints = false
        if let loading = loading {
            self.view.addSubview(loading)
            loading.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            loading.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
    
    private func showLoading() {
        DispatchQueue.main.async {
            self.loading?.startAnimating()
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async {
            self.loading?.stopAnimating()
        }
    }
    
    private func showDataRetrieved(weather: WeatherResult) {
        
        if let message = weather.message {
            DispatchQueue.main.async {
                self.alert(title: "Oops!",
                           message: message)
                self.hideViews(hide: true, hideButton: false)
            }
            return
        }
        
        guard let weathersub = weather.weather?.first else { return }
        guard let main = weather.main else { return }
        guard let wind = weather.wind else { return }
        DispatchQueue.main.async {
            if let name = weather.name, name.count > 0 {
                self.cityNameLabel.text = name
            } else {
                self.cityNameLabel.text = "No City mentioned"
            }
            self.temperatureLabel.text = "\(main.temp)°"
            self.subTitleLabel.text = "\(weathersub.weatherDescription)"
            self.mediumTemperatureLabel.text = "Low: \(main.tempMin)° High: \(main.tempMax)°"
            self.windSpeedLabel.text = "Wind: \(wind.speed) (\(wind.deg))"
            
            let urlImage = String(format:Constants.imageWeatherURL, weathersub.icon)
            let imagePlaceholder = UIImage(named: "placeholder")
            if let url = URL(string: urlImage) {
                self.weatherImageView.kf.setImage(with: url,
                                                  placeholder: imagePlaceholder,
                                                  options: nil,
                                                  progressBlock: nil,
                                                  completionHandler: nil)
            }
            self.hideViews(hide: false, hideButton: true)
        }
    }
    
    private func hideViews(hide: Bool, hideButton: Bool) {
        DispatchQueue.main.async {
//            self.cityNameLabel.isHidden = hide
            self.temperatureLabel.isHidden = hide
            self.subTitleLabel.isHidden = hide
            self.mediumTemperatureLabel.isHidden = hide
            self.windSpeedLabel.isHidden = hide
            self.weatherImageView.isHidden = hide
            
            self.button.isHidden = hideButton
        }
    }
    
    private func setupActions() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (reload))
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(gesture)
        
        button.addTarget(self, action: #selector(reload), for: .touchUpInside)
    }
    
    @objc func reload(_ sender:UITapGestureRecognizer){
        locationManager?.requestLocation()
    }
}

// MARK: SetupData
extension HomeViewController {
    private func setupData() {
        viewModel.delegate = self
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }
}

// MARK: - ViewControllerViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func onSuccessFetchingWeather(weather: WeatherResult) {
        self.showDataRetrieved(weather: weather)
        self.stopLoading()
    }
    
    func onFailureFetchingWeather(error: Error) {
        DispatchQueue.main.async {
            self.alert(title: "Oops!", message: error.localizedDescription)
            self.hideViews(hide: true, hideButton: false)
            self.stopLoading()
        }
    }
}


// MARK: - LocationManager
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        } else if status == .notDetermined {
            locationManager?.requestAlwaysAuthorization()
        } else {
            self.alert(title: "Oops!",
                       message: "To use this app you should enable access location.\n Please, go to app configuration and enable it")
            self.hideViews(hide: true, hideButton: false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager?.stopUpdatingLocation()
        if let locValue = manager.location {
            showLoading()
            let coordination = Coordinates(lon: locValue.coordinate.latitude, lat: locValue.coordinate.longitude)
            viewModel.fetchData(coordination)
        }
    }
}

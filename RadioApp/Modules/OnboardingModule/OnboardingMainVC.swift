//
//  OnboardingPageVC.swift
//  RadioApp
//
//  Created by Andrew Linkov on 03.08.2024.
//

import UIKit

final class OnboardingMainVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageControllers: [UIViewController] = []
    var onComplete: (() -> Void)?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataSource = self
        delegate  = self
        
        let firstController = OnboardingPage1VC()
        let secondController = OnboardingPage2VC()
        let thirdController = OnboardingPage3VC()
        
        firstController.onNext = { [weak self] in
            self?.navigateToNextPage()
        }
        
        secondController.onNext = { [weak self] in
            self?.navigateToNextPage()
        }
        
        thirdController.onComplete = { [weak self] in
            self?.onComplete?()
        }
        
        pageControllers = [firstController, secondController, thirdController]
        
        if let firstVC = pageControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func navigateToNextPage() {
        guard let currentVC = viewControllers?.first,
              let nextVC = pageViewController(self, viewControllerAfter: currentVC) else {
            return
        }
        setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return pageControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        
        guard nextIndex < pageControllers.count else {
            return nil
        }
        
        return pageControllers[nextIndex]
    }
}


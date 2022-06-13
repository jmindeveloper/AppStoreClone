//
//  TodayViewControllerTransitionAnimator.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/12.
//

import UIKit

final class TodayViewControllerTransitionAnimator: NSObject {
    let duration: Double = 0.8
    var presenting: PresentMode = .present
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?
    
    enum PresentMode {
        case present
        case dismiss
    }
}

extension TodayViewControllerTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch presenting {
        case .present:
            presentAnimation(using: transitionContext)
        case .dismiss:
            dismissAnimation(using: transitionContext)
        }
    }
    
    func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let cardView = transitionContext.view(forKey: .to),
              let tabBarController = transitionContext.viewController(forKey: .from) as? UITabBarController else {
            transitionContext.completeTransition(false)
            return
        }
        
        
        let initialFrame = originFrame
        let finalFrame = cardView.frame
        
        let xScaleFactor = initialFrame.width / finalFrame.width
        let yScaleFactor = initialFrame.height / finalFrame.height
        
        let scaleTransForm = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        cardView.transform = scaleTransForm
        cardView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 30
        
        containerView.addSubview(cardView)
        
        UIView.animate(withDuration: duration - 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0) {
            cardView.transform = CGAffineTransform.identity
            cardView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            cardView.layer.cornerRadius = 0
            tabBarController.tabBar.frame.origin.y = UIScreen.main.bounds.height
        } completion: { _ in
            transitionContext.completeTransition(true)
        }

        
    }
    
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let cardView = transitionContext.view(forKey: .from),
              let tabBarController = transitionContext.viewController(forKey: .to) as? UITabBarController,
              let cardVC = transitionContext.viewController(forKey: .from) as? TodayCardDetailViewController
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        cardView.layer.cornerRadius = 0
        
        let initialFrame = cardView.frame
        let finalFrame = originFrame
        
        let xScaleFactor = finalFrame.width / initialFrame.width
        let yScaleFactor = finalFrame.height / initialFrame.height
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0) {
            cardView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            cardView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            cardView.layer.cornerRadius = 30
            cardVC.dismissButton.isHidden = true
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
        
        UIView.animate(withDuration: duration - 0.4) {
            tabBarController.tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBarController.tabBar.frame.height
        } completion: { _ in }

    }
}

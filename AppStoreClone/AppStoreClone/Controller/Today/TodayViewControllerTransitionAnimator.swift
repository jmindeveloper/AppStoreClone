//
//  TodayViewControllerTransitionAnimator.swift
//  AppStoreClone
//
//  Created by J_Min on 2022/06/12.
//

import UIKit

final class TodayViewControllerTransitionAnimator: NSObject {
    let duration: Double = 0.4
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
        print(originFrame)
        
        let initialFrame = originFrame
        let finalFrame = cardView.frame
        
        let xScaleFactor = initialFrame.width / finalFrame.width
        let yScaleFactor = initialFrame.height / finalFrame.height
        
        let scaleTransForm = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        cardView.transform = scaleTransForm
        cardView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        cardView.clipsToBounds = true
        
        containerView.addSubview(cardView)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1) {
            cardView.transform = CGAffineTransform.identity
            cardView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            tabBarController.tabBar.frame.origin.y = UIScreen.main.bounds.height
        } completion: { _ in
            transitionContext.completeTransition(true)
        }

        
    }
    
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let cardView = transitionContext.view(forKey: .from),
              let tabBarController = transitionContext.viewController(forKey: .to) as? UITabBarController else {
            transitionContext.completeTransition(false)
            return
        }
        
        let initialFrame = cardView.frame
        let finalFrame = originFrame
        
        let xScaleFactor = finalFrame.width / initialFrame.width
        let yScaleFactor = finalFrame.height / initialFrame.height
        
        containerView.addSubview(cardView)
        containerView.addSubview(tabBarController.tabBar)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1) {
            containerView.bringSubviewToFront(tabBarController.tabBar)
            cardView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            cardView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            tabBarController.tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBarController.tabBar.frame.height
        } completion: { _ in
            transitionContext.completeTransition(true)
            tabBarController.tabBar.addSubview(tabBarController.tabBar)
        }
    }
}

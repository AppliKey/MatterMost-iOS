//
// Created by Vladimir Kravchenko on 3/29/16.
// Copyright (c) 2016 Applikey Solutions. All rights reserved.
//

import Foundation
import UIKit

public typealias ConstraintFilterClosure = (NSLayoutConstraint) -> Bool

extension UIView {

  public func firstWidthConstraint() -> NSLayoutConstraint? {
    return firstConstraintWithAttribute(.width)
  }

  public func firstHeightConstraint() -> NSLayoutConstraint? {
    return firstConstraintWithAttribute(.height)
  }

  public func firstTopConstraint() -> NSLayoutConstraint? {
    return firstConstraintWithAttribute(.top)
  }

  public func firstBottomConstraint() -> NSLayoutConstraint? {
    return firstConstraintWithAttribute(.bottom)
  }

  public func firstLeadingConstraint() -> NSLayoutConstraint? {
    return firstConstraintWithAttribute(.leading)
  }

  public func firstTrailingConstraint() -> NSLayoutConstraint? {
    return firstConstraintWithAttribute(.trailing)
  }

  public func firstConstraintWithAttribute(_ attribute: NSLayoutAttribute,
                                           filter: ConstraintFilterClosure? = nil) -> NSLayoutConstraint? {
    guard let view = isSizeAttribute(attribute) ? self : self.superview else {
      return nil
    }
    for constraint in view.constraints {
      let constraintMatchingAttribute = isConstraint(constraint, matchingAttribute: attribute)
      let constraintMatchingFilter = filter?(constraint) ?? true
      if constraintMatchingAttribute && constraintMatchingFilter {
        return constraint
      }
    }
    return nil
  }

  private func isSizeAttribute(_ attribute: NSLayoutAttribute) -> Bool {
    return attribute == .width || attribute == .height
  }

  private func isConstraint(_ constraint: NSLayoutConstraint, matchingAttribute attribute: NSLayoutAttribute) -> Bool {
    let matchingFirstAttribute = (constraint.firstItem as? UIView) == self && constraint.firstAttribute == attribute
    let matchingSecondAttribute = (constraint.secondItem as? UIView) == self && constraint.secondAttribute == attribute
    let isManualConstraint = type(of: constraint) === NSLayoutConstraint.self
    return isManualConstraint && (matchingFirstAttribute || matchingSecondAttribute)
  }

}

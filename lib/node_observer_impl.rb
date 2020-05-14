# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "node_observer_impl/version"

# NodeObserver.
# @class_description
#   A NodeObserver library implementation.
# @attr observing [Set]
#   Subjects.
# @attr changed [Set]
#   Changed subjects.
class NodeObserver < Observer

  # self.instance().
  # @description
  #   Gets instance. Lazily initializes instance.
  # @return [NodeObserver]
  #   The instance.
  def self.instance()

    if (@instance.nil?())
      self.instance = new()
    end
    return @instance

  end

  # subject(n = nil).
  # @description
  #   Predicate. Verifies a Node is a subject.
  # @param n [Node]
  #   Any instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the argument is an 'observing' element. False otherwise.
  def subject(n = nil)
    return (observing().include?(n))
  end

  # changed_node(subject = nil).
  # @description
  #   Predicate. Verifies a subject was changed.
  # @param subject [Node]
  #   Any instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the argument is a 'changed' element. False otherwise.
  def changed_node(subject = nil)
    return (changed().include?(subject))
  end

  # subject_changed(subject = nil).
  # @description
  #   Adds an existing subject the changed Set.
  # @param subject [Node]
  #   A subject.
  # @return [NilClass]
  #   nil.
  def subject_changed(subject = nil)
    receive_change(subject)
  end

  # add(n = nil).
  # @description
  #   Adds observing a subject.
  # @param n [Node]
  #   The addition.
  # @return [NilClass]
  #   nil.
  def add(n = nil)

    unless (n.instance_of?(Node))
      raise(ArgumentError, "#{n} is not a Node instance.")
    else
      observing().add(n)
    end
    return nil

  end

  # remove(n = nil).
  # @description
  #   Removes a subject.
  # @param n [Node]
  #   The removal.
  # @return [NilClass]
  #   nil.
  def remove(n = nil)

    unless (subject(n))
      raise(ArgumentError, "#{n} is not a subject.")
    else
      observing().delete(n)
    end
    return nil

  end

  protected

  # observing().
  # @description
  #   Gets 'observing'.
  # @return [Set]
  #   observing's reference.
  def observing()
    return @observing
  end

  # changed().
  # @description
  #   Gets changed.
  # @return [Set]
  #   changed's reference.
  def changed()
    return @changed
  end

  # add_changed(n = nil).
  # @description
  #   Adds changed a changed subject.
  # @param n [Node]
  #   A changed subject.
  # @return [NilClass]
  #   nil.
  def add_changed(n = nil)

    unless (subject(n))
      raise(ArgumentError, "#{n} is not a subject.")
    else
      changed().add(n)
    end
    return nil

  end

  # remove_changed(n = nil).
  # @description
  #   Removes a changed subject. Calls after a Subscription update call.
  # @param n [Node]
  #   A changed element. The element's subscribers were updated, so it is an
  #   unchanged subject.
  # @return [NilClass]
  #   nil.
  def remove_changed(n = nil)

    unless (changed_node(n))
      raise(ArgumentError, "#{n} is not a changed subject.")
    else
      changed().delete(n)
    end
    return nil

  end

  # notify(n = nil).
  # @description
  #   Updates a subject's subscribers.
  # @param n [Node]
  #   A changed subject.
  # @return [NilClass]
  #   nil.
  def notify(n = nil)

    Subscription.update(n)
    remove_changed(n)
    return nil

  end

  private

  # observing=(s = nil).
  # @description
  #   Sets observing.
  # @param s [Set]
  #   An empty set.
  # @return [Set]
  #   The argument.
  def observing=(s = nil)
    @observing = s
  end

  # changed=(s = nil).
  # @description
  #   Sets 'changed'.
  # @param s [Set]
  #   An empty set.
  # @return [Set]
  #   The argument.
  def changed=(s = nil)
    @changed = s
  end

  # receive_change(n = nil).
  # @description
  #   Receives a Node's state change.
  # @param n [Node]
  #   An existing subject.
  # @return [NilClass]
  #   nil.
  def receive_change(n = nil)

    add_changed(n)
    notify(n)
    return nil

  end

  # initialize().
  # @description
  #   Initializes the singleton instance's instance variables.
  def initialize()
    self.observing = Set[]
    self.changed = Set[]
  end

  # self.instance=(singleton = nil).
  # @description
  #   Sets the singleton instance.
  # @param singleton [NodeObserver]
  #   The instance.
  # @return [NodeObserver]
  #   The argument.
  def self.instance=(singleton = nil)
    @instance = singleton
    return @instance
  end

  private_class_method :new
  private_class_method :instance=

end

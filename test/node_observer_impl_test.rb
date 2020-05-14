require_relative 'test_helper'

# NodeObserverTest.
# @class_description
#   Tests the NodeObserver class.
class NodeObserverTest < Minitest::Test

  # Constants.
  CLASS       = NodeObserver
  TEST_FLOAT = 3.14
  NILCLASS_I  = nil
  TEST_SYMBOL = :test_symbol
  NODE1       = Node.new(NILCLASS_I, TEST_FLOAT, NILCLASS_I)
  NODE2    = Node.new(NILCLASS_I, TEST_SYMBOL, NILCLASS_I)
  SINGLETON_NODES = Set[NODE1, NODE2]

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md,
  #   .yardopts, .gitignore, Changelog.md, CODE_OF_CONDUCT.md,
  #   node_observer_impl.gemspec, Gemfile.lock, and Rakefile files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')
    assert_path_exists('.gitignore')
    assert_path_exists('Changelog.md')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('node_observer_impl.gemspec')
    assert_path_exists('Gemfile.lock')
    assert_path_exists('Rakefile')

  end

  # test_version_declared().
  # @description
  #   The version was declared.
  def test_version_declared()
    refute_nil(NodeObserver::VERSION)
  end

  # setup().
  # @description
  #   Set fixtures.
  def setup()
  end

  # NodeObserver.instance().

  # test_instance_x1().
  # @description
  #   No instances exist.
  def test_instance_x1()
    singleton = NodeObserver.instance()
    assert_same(singleton.class(), NodeObserver)
  end

  # test_instance_x2().
  # @description
  #   An instance exists.
  def test_instance_x2()

    singleton = NodeObserver.instance()
    s2 = NodeObserver.instance()
    assert_same(singleton, s2)

  end

  # subject(n = nil).

  # test_subject_x1().
  # @description
  #   Any instance type excluding Node.
  def test_subject_x1()
    singleton = NodeObserver.instance()
    refute_operator(singleton, 'subject', TEST_FLOAT)
  end

  # test_subject_x2().
  # @description
  #   A Node not in 'observing'.
  def test_subject_x2()
    singleton = NodeObserver.instance()
    refute_operator(singleton, 'subject', NODE2)
  end

  # test_subject_x3().
  # @description
  #   A subject.
  def test_subject_x3()

    singleton = NodeObserver.instance()
    singleton.add(NODE1)
    assert_operator(singleton, 'subject', NODE1)

  end

  # changed_node(subject = nil).

  # test_cn_x1().
  # @description
  #   Any type instance excluding Node.
  def test_cn_x1()
    singleton = NodeObserver.instance()
    refute_operator(singleton, 'changed_node', TEST_FLOAT)
  end

  # test_cn_x2().
  # @description
  #   A Node. Not a changed element.
  def test_cn_x2()
    singleton = NodeObserver.instance()
    refute_operator(singleton, 'changed_node', NODE1)
  end

  # add(n = nil).

  # test_add_x().
  # @description
  #   The default parameter.
  def test_add_x()

    singleton = NodeObserver.instance()
    assert_raises(ArgumentError) {
      singleton.add()
    }

  end

  # remove(n = nil).

  # test_remove_x1().
  # @description
  #   Any Node excluding subjects.
  def test_remove_x1()

    singleton = NodeObserver.instance()
    assert_raises(ArgumentError, "#{NODE1} is not a subject.") {
      singleton.remove(NODE1)
    }

  end

  # test_remove_x2().
  # @description
  #   A subject argument.
  def test_remove_x2()

    singleton = NodeObserver.instance()
    singleton.add(NODE1)
    singleton.remove(NODE1)
    refute_operator(singleton, 'subject', NODE1)

  end

  # subject_changed(subject = nil).

  # test_sc_x1().
  # @description
  #   Any argument excluding a subject.
  def test_sc_x1()

    singleton = NodeObserver.instance()
    assert_raises(ArgumentError) {
      singleton.subject_changed(NODE1)
    }

  end

  # Protected methods.

  # observing().

  # test_attro_x().
  # @description
  #   A plain singleton.
  def test_attro_x()

    assert_raises(NameError) {
      singleton = NodeObserver.instance()
      singleton.observing()
    }

  end

  # changed().

  # test_attrc_x().
  # @description
  #   A plain instance.
  def test_attrc_x()

    singleton = NodeObserver.instance()
    assert_raises(NameError) {
      singleton.changed()
    }

  end

  # notify(n = nil).

  # test_notify_x().
  # @description
  #   The default parameter.
  def test_notify_x()

    singleton = NodeObserver.instance()
    assert_raises(NameError) {
      singleton.notify()
    }

  end

  # add_changed(n = nil).

  # test_ac_x1().
  # @description
  #   Calling a protected method raises NameError.
  def test_ac_x1()

    singleton = NodeObserver.instance()
    assert_raises(NameError) {
      singleton.add_changed(NODE1)
    }

  end

  # remove_changed(n = nil).

  # test_remc_x1().
  # @description
  #   Calling a protected method raises NameError.
  def test_remc_x1()

    singleton = NodeObserver.instance()
    assert_raises(NameError) {
      singleton.remove_changed(NODE1)
    }

  end

  # Private methods.

  # changed=(s = nil).

  # test_cs_x().
  # @description
  #   Setting an empty Set.
  def test_cs_x()

    assert_raises(NameError) {
      singleton = NodeObserver.instance()
      singleton.changed = Set[]
    }

  end

  # observing=(s = nil).

  # test_os_x().
  # @description
  #   Setting an empty Set.
  def test_os_x()

    assert_raises(NameError) {
      singleton = NodeObserver.instance()
      singleton.changed = Set[]
    }

  end

  # receive_change(n = nil).

  # test_rc_x().
  # @description
  #   The default parameter.
  def test_rc_x()

    singleton = NodeObserver.instance()
    assert_raises(NameError) {
      singleton.receive_change()
    }

  end

  # NodeObserver.instance=(singleton = new()).

  # test_cis_x().
  # @description
  #   A plain call.
  def test_cis_x()

    assert_raises(NameError) {
      NodeObserver.instance = new()
    }

  end

  # teardown().
  # @description
  #   Cleanup.
  def teardown()

    singleton = NodeObserver.instance()
    SINGLETON_NODES.each { |node|

      if (singleton.subject(node))
        singleton.remove(node)
      end

    }

  end

end

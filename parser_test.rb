require "minitest/autorun"

require_relative './parser'

class ParserTest < Minitest::Test
  def test_empty_input_returns_schema_default_value
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ l: false, p: 0, d: '' }, Parser.process(schema, ''))
  end

  def test_empty_input_returns_other_schema_default_value
    schema = {
      m: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ m: false, p: 0, d: '' }, Parser.process(schema, ''))
  end

  def test_1
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ l: true, p: 0, d: '' }, Parser.process(schema, '-l'))
  end

  def test_2
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ l: false, p: 1, d: '' }, Parser.process(schema, '-p 1'))
  end

  def test_3
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ l: false, p: 2, d: '' }, Parser.process(schema, '-p 2'))
  end

  def test_4
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ l: false, p: 0, d: 'toto' }, Parser.process(schema, '-d toto'))
  end

  def test_5
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ l: true, p: 3, d: '' }, Parser.process(schema, '-l -p 3'))
  end

  def test_6
    schema = {
      m: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ m: true, p: 0, d: '' }, Parser.process(schema, '-m'))
  end

  def test_7
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ l: true, p: 3, d: 'azerty' }, Parser.process(schema, '-l -p 3 -d azerty'))
  end

  def test_8 #change key order in input
    schema = {
      l: { klass: Boolean, default: false },
      p: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ p: 3, l: true, d: 'azerty' }, Parser.process(schema, '-p 3 -l -d azerty'))
  end

  def test_9
    schema = {
      m: { klass: IntegerArray, default: [] },
      j: { klass: Integer, default: 0 },
      d: { klass: String, default: '' },
    }

    assert_equal({ m: [1, 2, 3], j: -3, d: 'azerty' }, Parser.process(schema, '-m 1,2,3 -j -3 -d azerty'))
  end
end

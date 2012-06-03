require 'contest'
require 'tilt'

begin
  class JSXTemplateTest < Test::Unit::TestCase
    test "is registered for '.jsx' files" do
      assert_equal Tilt::JSXTemplate, Tilt['test.jsx']
    end

    test "compiles and evaluates the template on #render" do
      template = Tilt::JSXTemplate.new "test/jsx/hello_world.jsx"
      assert_match <<-EOS, template.render
var JSX = {};
(function () {
EOS
    end

    test "can be rendered more than once" do
      template = Tilt::JSXTemplate.new "test/jsx/hello_world.jsx"
      3.times do
        assert_match <<EOS, template.render
var JSX = {};
(function () {
EOS
      end
    end

    test "#render can take options as string" do
      template = Tilt::JSXTemplate.new "test/jsx/hello_world.jsx", :args => %w{--release --optimize no-assert}
      assert_match <<-EOS, template.render
var JSX = {};
(function () {
EOS
    end
  end
rescue LoadError => boom
  warn "Tilt::JSXTemplate (disabled)"
end

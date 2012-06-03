require 'tilt/template'
require 'shellwords'

module Tilt
  class JSXTemplate < Template
    self.default_mime_type = 'application/jsx'

    def prepare; end

    def evaluate(scope, locals, &block)
      @output ||= jsx_compile(data, options)
    end

    private

    def jsx_command
      options[:command] || 'jsx'
    end

    def jsx_compile(data, options = {})
      command = jsx_command

      if (options[:args])
        options[:args].each {|i| command << " #{i.shellescape}" }
      end

      %x{#{command} #{eval_file.shellescape}}
    end
  end
end

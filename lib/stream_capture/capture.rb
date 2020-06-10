# frozen_string_literal: true

require 'stringio'

module StreamCapture
  class Capture # :nodoc:
    def stdout(&block)
      capture(:stdout, &block)
    end

    def stderr(&block)
      capture(:stderr, &block)
    end

    def std_both(&block)
      string_io = StringIO.new
      capture(:stdout, string_io) do
        capture(:stderr, string_io, &block)
      end
    end

    private

    # rubocop:disable Security/Eval, Metrics/MethodLength
    def capture(stream, string_io = StringIO.new)
      raise StreamCapture::NoBlockExistsError unless block_given?

      stream = stream.to_s
      binding.eval("$#{stream} = string_io", __FILE__, __LINE__)
      begin
        yield
      rescue SystemExit => e
        binding.eval("$#{stream}.puts #{e.status}", __FILE__, __LINE__)
      end
      binding.eval("$#{stream}", __FILE__, __LINE__).string
    ensure
      binding.eval("$#{stream} = #{stream.upcase}", __FILE__, __LINE__)
    end
    # rubocop:enable Security/Eval, Metrics/MethodLength
  end
end

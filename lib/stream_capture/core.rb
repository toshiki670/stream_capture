# frozen_string_literal: true

require 'stringio'

module StreamCapture
  class Core # :nodoc:
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

    def capture(stream, string_io = StringIO.new, &block)
      raise StreamCapture::NoBlockExistsError unless block_given?

      stream = stream.to_s
      set_stream(stream, string_io)
      capture_yield(stream, &block)
    ensure
      reset_stream(stream)
    end

    def capture_yield(stream)
      begin
        yield
      rescue SystemExit => e
        get_stream(stream).puts e.status
      end
      get_stream(stream).string
    end

    def set_stream(stream, io)
      self.eval("$#{stream} = io", binding)
    end

    def get_stream(stream)
      self.eval("$#{stream}", binding)
    end

    def reset_stream(stream)
      self.eval("$#{stream} = #{stream.upcase}", binding)
    end

    def eval(expr, bind)
      bind.eval(expr, __FILE__, __LINE__)
    end
  end
end

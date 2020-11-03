# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2020 Toshiki
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
      self.eval("$#{stream} = io", binding)               # $stdout = io
    end

    def get_stream(stream)
      self.eval("$#{stream}", binding)                    # $stdout
    end

    def reset_stream(stream)
      self.eval("$#{stream} = #{stream.upcase}", binding) # $stdout = STDOUT
    end

    def eval(expr, bind)
      bind.eval(expr, __FILE__, __LINE__)
    end
  end
end

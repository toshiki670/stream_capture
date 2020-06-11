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

require 'stream_capture/core'
require 'stream_capture/version'

# Stream capture
module StreamCapture
  class NoBlockExistsError < StandardError; end

  def capture_stdout(&block)
    StreamCapture.stdout(&block)
  end

  def capture_stderr(&block)
    StreamCapture.stderr(&block)
  end

  def capture_std_both(&block)
    StreamCapture.std_both(&block)
  end

  class << self
    def stdout(&block)
      StreamCapture::Core.new.stdout(&block)
    end

    def stderr(&block)
      StreamCapture::Core.new.stderr(&block)
    end

    def std_both(&block)
      StreamCapture::Core.new.std_both(&block)
    end
  end
end
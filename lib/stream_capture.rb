# frozen_string_literal: true

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

# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe StreamCapture do
  context 'When instance method' do
    subject do
      Class.new { include StreamCapture }.new.__send__(meth) do
        if meth == :capture_stderr
          warn 'ok'
        else
          puts 'ok'
        end
      end
    end
    %i[capture_stdout capture_stderr capture_std_both].each do |type|
      context "When ##{type}" do
        let(:meth) { type }
        it { is_expected.to match(/ok/) }
      end
    end
  end

  context 'When module method' do
    subject do
      StreamCapture.__send__(meth) do
        if meth == :stderr
          warn 'ok'
        else
          puts 'ok'
        end
      end
    end
    %i[stdout stderr std_both].each do |type|
      context "When .#{type}" do
        let(:meth) { type }
        it { is_expected.to match(/ok/) }
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength

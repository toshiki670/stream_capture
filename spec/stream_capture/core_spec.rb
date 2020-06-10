# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe StreamCapture::Core do
  let(:instance) { StreamCapture::Core.new }

  describe '#stdout' do
    describe 'Success' do
      subject do
        instance.stdout do
          puts 'ok'
          exit 0
        end
      end
      context 'When stdout' do
        it { is_expected.to match(/ok/) }
      end
      context 'When exitcode' do
        it { is_expected.to match(/0/) }
      end
    end

    describe 'Error' do
      subject { instance.stdout }
      context 'When no block' do
        it { expect { subject }.to raise_error(StreamCapture::NoBlockExistsError) }
      end
    end
  end

  describe '#stderr' do
    describe 'Success' do
      subject do
        instance.stderr do
          warn 'stderr'
          exit 1
        end
      end
      context 'When stderr' do
        it { is_expected.to match(/stderr/) }
      end
      context 'When exitcode' do
        it { is_expected.to match(/1/) }
      end
    end

    describe 'Error' do
      subject { instance.stderr }
      context 'When no block' do
        it { expect { subject }.to raise_error(StreamCapture::NoBlockExistsError) }
      end
    end
  end

  describe '#std_both' do
    describe 'Success' do
      subject do
        instance.std_both do
          puts 'ok'
          warn 'stderr'
          exit 1
        end
      end
      context 'When stdout and stderr' do
        it { is_expected.to match(/ok/) }
        it { is_expected.to match(/stderr/) }
      end
      context 'When exitcode' do
        it { is_expected.to match(/1/) }
      end
    end

    describe 'Error' do
      subject { instance.std_both }
      context 'When no block' do
        it { expect { subject }.to raise_error(StreamCapture::NoBlockExistsError) }
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength

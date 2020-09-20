require 'rails_helper'

RSpec.describe Offer, type: :model do  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:advertiser_name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:starts_at) }

    it { is_expected.to validate_uniqueness_of(:advertiser_name) }

    it { is_expected.to validate_length_of(:description).is_at_most(500) }

    it { is_expected.to validate_url_of(:url) }
  end

  describe 'When an offer is valid' do
    let(:offer) { build_stubbed(:offer) }
    it 'is valid with advertiser_name, url, description, starts_at' do
      expect(offer).to be_valid
    end
  end

  describe 'states transitions' do
    describe 'Initial state' do
      it { is_expected.to have_state(:disabled) }
    end

    describe 'when trigger the event: enable_offer' do
      let(:offer) { build_stubbed(:offer) }

      it 'transitioned from disabled to enabled' do
        expect(offer).to transition_from(:disabled).to(:enabled).on_event(:enable_offer)
      end
    end

    describe 'when trigger the event: disable_offer' do
      let(:offer) { build_stubbed(:offer) }

      it 'transitioned from disabled to enabled' do
        expect(offer).to transition_from(:enabled).to(:disabled).on_event(:disable_offer)
      end
    end
  end

  describe '#ready_to_start?' do
    context 'when ends_at is not nil' do
      let(:offer) { build_stubbed(:offer) }

      it 'starts_at <= today' do
        expect(offer.starts_at).to be <= DateTime.now
      end

      it 'ends_at >= today' do
        expect(offer.ends_at).to be >= DateTime.now
      end
    end

    context 'when ends_at is nil' do
      let(:offer) { build_stubbed(:offer, :not_expires) }

      it 'starts_at <= today' do
        expect(offer.starts_at).to be <= DateTime.now
      end

      it 'ends_at is nil' do
        expect(offer.ends_at).to be_nil
      end
    end
  end

  describe '#finished?' do
    context 'when not finished' do
      let(:offer) { build_stubbed(:offer, :started) }

      it 'is a offer enabled' do
        expect(offer.enabled?).to be_truthy
      end
    end

    context 'when finished' do
      let(:offer) { build_stubbed(:offer, :finished) }

      it 'is a offer disabled' do
        expect(offer.disabled?).to be_truthy
      end
    end
  end

  describe '#not_expires?' do
    let(:offer) { build_stubbed(:offer, :not_expires) }

    it 'ends_at is nil' do
      expect(offer.ends_at).to be_nil
    end
  end
end
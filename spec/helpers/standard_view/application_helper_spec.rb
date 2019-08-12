# frozen_string_literal: true

require "rails_helper"

RSpec.describe StandardView::ApplicationHelper, type: :helper do
  describe "#action" do
    subject { helper.action.get? }

    before { allow(controller).to receive(:action_name).and_return(action_name) }

    context "when matches" do
      let(:action_name) { "get" }

      it { is_expected.to eq true }
    end

    context "when NOT matching" do
      let(:action_name) { "post" }

      it { is_expected.to eq false }
    end
  end

  describe "#active_for" do
    subject { helper.active_for(options) }

    let(:options) { double }

    before { allow(helper).to receive(:current_page?).with(options).and_return(current_page?) }

    context "when current_page?" do
      let(:current_page?) { true }

      it { is_expected.to eq "active" }
    end

    context "when NOT current_page?" do
      let(:current_page?) { false }

      it { is_expected.to be_nil }
    end
  end

  describe "#icon_for" do
    let(:icon) { double }
    let(:name) { Faker::Internet.domain_word }
    let(:style) { Faker::Internet.domain_word }
    let(:spin) { rand(0..1) == 1 }

    before { allow(helper).to receive(:icon_tag).with(name, style, spin: spin).and_return(icon) }

    shared_examples_for "an icon reference" do
      context "when nil" do
        let(:reference) { nil }
        let(:name) { nil }
        let(:style) { nil }

        it { is_expected.to eq icon }
      end

      context "when a hash" do
        context "with only a name" do
          let(:style) { nil }
          let(:reference) { Hash[:name, name] }

          it { is_expected.to eq icon }
        end

        context "with only a style" do
          let(:name) { nil }
          let(:reference) { Hash[:style, style] }

          it { is_expected.to eq icon }
        end

        context "with a name and style" do
          let(:reference) do
            { name: name, style: style }
          end

          it { is_expected.to eq icon }
        end
      end

      context "when a string" do
        context "when in localization" do
          let(:reference) { "key_#{Faker::Internet.domain_word}" }

          before { allow(I18n).to receive(:t).with("icons.#{reference}", default: nil).and_return(localization_value) }

          context "when nil" do
            let(:localization_value) { nil }
            let(:name) { reference }
            let(:style) { nil }

            it { is_expected.to eq icon }
          end

          context "when only a string" do
            let(:localization_value) { name }
            let(:style) { nil }

            it { is_expected.to eq icon }
          end

          context "when a hash" do
            context "with only a name" do
              let(:style) { nil }
              let(:localization_value) { Hash[:name, name] }

              it { is_expected.to eq icon }
            end

            context "with only a style" do
              let(:name) { nil }
              let(:localization_value) { Hash[:style, style] }

              it { is_expected.to eq icon }
            end

            context "with a name and style" do
              let(:localization_value) do
                { name: name, style: style }
              end

              it { is_expected.to eq icon }
            end
          end
        end

        context "when not in localization" do
          let(:reference) { name }
          let(:style) { nil }

          it { is_expected.to eq icon }
        end
      end
    end

    context "with #icon" do
      context "with spin" do
        subject { helper.icon_for(double(icon: reference), spin: spin) }

        it_behaves_like "an icon reference"
      end

      context "without spin" do
        subject { helper.icon_for(double(icon: reference)) }

        let(:spin) { false }

        it_behaves_like "an icon reference"
      end
    end

    context "with direct reference" do
      context "with spin" do
        subject { helper.icon_for(reference, spin: spin) }

        it_behaves_like "an icon reference"
      end

      context "without spin" do
        subject { helper.icon_for(reference) }

        let(:spin) { false }

        it_behaves_like "an icon reference"
      end
    end
  end

  describe "#icon_tag" do
    context "with no arguments" do
      subject { helper.icon_tag }

      it { is_expected.to eq "<i class=\"fas fa-question \"></i>" }
    end

    context "with only spin" do
      subject { helper.icon_tag(spin: true) }

      it { is_expected.to eq "<i class=\"fas fa-question fa-spin\"></i>" }
    end

    context "with only name" do
      subject { helper.icon_tag(name) }

      let(:name) { SecureRandom.hex }

      it { is_expected.to eq "<i class=\"fas fa-#{name} \"></i>" }
    end

    context "with name and spin" do
      subject { helper.icon_tag(name, spin: true) }

      let(:name) { SecureRandom.hex }

      it { is_expected.to eq "<i class=\"fas fa-#{name} fa-spin\"></i>" }
    end

    context "with only style" do
      subject { helper.icon_tag(nil, style) }

      let(:style) { SecureRandom.hex }

      it { is_expected.to eq "<i class=\"fa#{style} fa-question \"></i>" }
    end

    context "with style and spin" do
      subject { helper.icon_tag(nil, style, spin: true) }

      let(:style) { SecureRandom.hex }

      it { is_expected.to eq "<i class=\"fa#{style} fa-question fa-spin\"></i>" }
    end

    context "with name and style" do
      subject { helper.icon_tag(name, style) }

      let(:name) { SecureRandom.hex }
      let(:style) { SecureRandom.hex }

      it { is_expected.to eq "<i class=\"fa#{style} fa-#{name} \"></i>" }
    end

    context "with name, style, and spin" do
      subject { helper.icon_tag(name, style, spin: true) }

      let(:name) { SecureRandom.hex }
      let(:style) { SecureRandom.hex }

      it { is_expected.to eq "<i class=\"fa#{style} fa-#{name} fa-spin\"></i>" }
    end
  end
end

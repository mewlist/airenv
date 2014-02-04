require 'spec_helper'
require 'airenv/sdk'

describe Airenv::Sdk do
  subject { Airenv::Sdk.new }
  let(:description) {  Airenv::SdkDescription.new("AIR 4.5.6", "4.5.6", 5678) }

  describe '#package_uri' do
    before do
      subject.description = description
    end

    its(:package_uri) { should == "http://airdownload.adobe.com/air/mac/download/4.5/AIRSDK_Compiler.tbz2" }
  end

  describe '#simple_version' do
    before do
      subject.description = description
    end

    its(:simple_version) { should == "4.5" }
  end

  describe '#parse_version_id' do
    context 'given build number' do
      before do
        subject.description = description
        subject.parse_version_id("4.5-b1234")
      end

      its(:simple_version) { should == "4.5" }
      its("description.build") { should == 1234 }
    end

    context 'not given build number' do
      before do
        subject.parse_version_id("4.6")
      end

      its(:simple_version) { should == "4.6" }
      its("description.build") { should be_nil }
    end
  end

  describe '#package_name' do
    before do
      subject.description = description
    end

    its(:package_name) { should == "AIRSDK_4.5.6-b5678" }
  end

  describe '#simple_name' do
    before do
      subject.description = description
    end

    its(:simple_name) { should == "AIRSDK_4.5" }
  end
end

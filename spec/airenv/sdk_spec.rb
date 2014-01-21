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
end

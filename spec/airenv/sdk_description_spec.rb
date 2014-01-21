require 'spec_helper'

describe Airenv::SdkDescription do
  subject { Airenv::SdkDescription.new }
  describe 'properties' do
    before do
      subject.name = "AIR 1.2.3"
      subject.version = "1.2.3"
      subject.build = 1234
    end

    its(:name) { should be_an_instance_of(String) }
    its(:version) { should be_an_instance_of(String) }
    its(:build) { should be_an_instance_of(Fixnum) }
  end

  describe '#load' do
    let(:xml) do
      <<-EOS
        <?xml version="1.0"?>
        <air-sdk-description>
        <name>AIR 4.5.6</name>
        <version>4.5.6</version>
        <build>5678</build>
        </air-sdk-description>
      EOS
    end
    before do
      subject.load xml
    end

    its(:name) { should == "AIR 4.5.6" }
    its(:version) { should == "4.5.6" }
    its(:build) { should == 5678 }
  end

  describe '#digest' do
    let(:another) { Airenv::SdkDescription.new }
    before do
      subject.name = "foo"
      subject.version = "bar"
      subject.build = 3141

      another.name = "hoge"
      another.version = "fuga"
      another.build = 5926
    end
    its(:digest) { should_not == another.digest }
  end

  describe '#id' do
    before do
      subject.name = "AIR 4.5.6"
      subject.version = "4.5.6"
      subject.build = 3141
    end

    its(:id) { should == "4.5.6-b3141" }
  end
end
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

  describe '#<=>' do
    let(:left) { Airenv::SdkDescription.new }
    let(:right) { Airenv::SdkDescription.new }

    context 'when right version is bigger' do
      before do
        left.version = "4.5.6"
        left.build = 4567

        right.version = "4.5.8"
        right.build = 1234
      end

      subject { left <=> right }
      it { should == -1 }
    end

    context 'when left version is bigger' do
      before do
        left.version = "4.5.8"
        left.build = 4567

        right.version = "4.5.4"
        right.build = 1234
      end

      subject { left <=> right }
      it { should == 1 }
    end

    context 'when left build version is bigger' do
      before do
        left.version = "4.5.8"
        left.build = 1235

        right.version = "4.5.8"
        right.build = 1234
      end

      subject { left <=> right }
      it { should == 1 }
    end

    context 'when right build version is bigger' do
      before do
        left.version = "4.5.8"
        left.build = 1235

        right.version = "4.5.8"
        right.build = 1236
      end

      subject { left <=> right }
      it { should == -1 }
    end

    context 'when version and build version is same' do
      before do
        left.version = "4.5.8"
        left.build = 1235

        right.version = "4.5.8"
        right.build = 1235
      end

      subject { left <=> right }
      it { should == 0 }
    end
  end

  describe '.usable?' do
    subject { Airenv::SdkDescription.usable?(version_id) }
    before do
      Airenv::SdkDescription.stub(:installed_versions).and_return(['1.2.3-b456', '1.2.4-b123'])
    end
    context do
      let(:version_id) { '1.2' }
      it { should be_true }
    end
    context do
      let(:version_id) { '1.3' }
      it { should be_false }
    end
    context do
      let(:version_id) { '1.2.4-b123' }
      it { should be_true }
    end
    context do
      let(:version_id) { '1.2.2-b987' }
      it { should be_false }
    end
  end

  describe '.normalize_version_id' do
    subject { Airenv::SdkDescription.normalize_version_id(version_id) }
    before do
      Airenv::SdkDescription.stub(:installed_versions).and_return(['1.2.3-b456', '1.2.4-b123'])
    end
    context do
      let(:version_id) { '1.2' }
      it { should == '1.2.4-b123' }
    end
    context do
      let(:version_id) { '1.2.3-b456' }
      it { should == '1.2.3-b456' }
    end
  end

  describe '.simple_version?' do
    subject { Airenv::SdkDescription.simple_version?(version_id) }
    context do
      let(:version_id) { '1.2' }
      it { should be_true }
    end
    context do
      let(:version_id) { '1.2.2-b987' }
      it { should be_false }
    end
  end
end
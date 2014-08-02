require 'spec_helper'

describe Bruno::StringsFile do
  let (:android_path) { File.expand_path(File.join('spec','assets','strings.xml')) }
  let (:ios_path) { File.expand_path(File.join('spec','assets','Localizable.strings')) }
  let (:array_hashes) {[{:key=>"APP_NAME", :value=>"Test App"},
                        {:key=>"TITLE_ACTIVITY_MAIN", :value=>"Test"},
                        {:key=>"INFO_TITLE", :value=>"Information"},
                        {:key=>"INFO_SUBTITLE", :value=>"More information"}] }

  let(:ios_file) { Bruno::StringsFile.new(ios_path) }
  let(:android_file) { Bruno::StringsFile.new(android_path) }

  describe '#initialize' do
    it 'raises an error if file is not readable' do
      expect { Bruno::StringsFile.new('') }.to raise_error
    end
  end

  describe '#transform' do
    it 'selects #to_ios if it is an Android file' do
      expect(android_file).to receive('to_ios').once
      android_file.transform('/tmp/Localizable.strings')
    end

    it 'selects #to_android if it is an iOS file' do
      expect(ios_file).to receive('to_android').once
      ios_file.transform('/tmp/strings.xml')
    end
  end


  describe 'Android to iOS' do
    describe '#get_strings_from_android' do
      it 'returns array of hashes with keys and values' do
        expect(android_file.send(:get_strings_from_android)).to eq array_hashes
      end
    end

    describe '#to_ios' do
      it 'converts the strings file to Localizable.strings' do
        android_file.to_ios('/tmp/Localizable.strings')
        expect(File.read('/tmp/Localizable.strings')).to eq (File.read(ios_path))
      end

      it 'is empty if the content of the original file is empty' do
        file = Bruno::StringsFile.new('/dev/null')
        expect(file.to_ios('/tmp/Localizable.strings')).to be_nil
      end
    end
  end

  describe 'iOS to Android' do
    describe '#get_strings_from_ios' do
      it 'returns an array of hashes with keys and values' do
        expect(ios_file.send(:get_strings_from_ios)).to eq array_hashes
      end
    end

    describe '#to_android' do
      it 'converts the string file to strings.xml' do
        ios_file.to_android('/tmp/strings.xml')
        expect(File.read('/tmp/strings.xml')).to eq (File.read(android_path))
      end

      it 'is empty if the content of the original file is empty' do
        file = Bruno::StringsFile.new('/dev/null')
        expect(file.to_android('/tmp/strings.xml')).to be_nil
      end
    end
  end

  describe '#is_ios?' do
    it 'true when the file is an iOS Localizable file' do
      expect(ios_file.send(:is_ios?)).to be true
    end

    it 'false when is not an iOS Localizable file' do
      expect(android_file.send(:is_ios?)).to be false
    end
  end

  describe '#is_android?' do
    it 'true when the file has strings in XML (Android)' do
      expect(android_file.send(:is_android?)).to be true
    end

    it 'false when the file has not strings in XML (not Android)' do
      expect(ios_file.send(:is_android?)).to be false
    end
  end
end

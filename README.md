# Bruno [![Build Status](https://travis-ci.org/josem/bruno.png?branch=master)](https://travis-ci.org/josem/bruno) [![Code Climate](https://codeclimate.com/github/josem/bruno.png)](https://codeclimate.com/github/josem/bruno) [![Gem Version](https://badge.fury.io/rb/bruno.svg)](http://badge.fury.io/rb/bruno)
Bruno is a small tool to convert your Localizable.strings (iOS) files into strings.xml (Android) and viceversa.

## Installation
To install Bruno:
```bash
gem install bruno
```

## Examples

From iOS to Android:
```bash
bruno convert --in Localizable.strings --out strings.xml
```

Or, if you already have the strings.xml file:
```bash
bruno convert --in strings.xml --out Localizable.strings
```

Bruno will detect automatically the format for you, so the name of the file does not matter.

## In future releases
* Support for comments
* Handle invalid formats of files

## Tested Compatibility
* Ruby 2.1.2
* Ruby 2.0.0
* Ruby 1.9.3
* Ruby 1.8.7
* JRuby 1.8 Mode
* JRuby 1.9 Mode
* Rubinius 1.8 Mode
* Rubinius 1.9 Mode

## Changelog
### 0.0.2 August 2, 2014
Improved code, fixed some minor mistakes
### 0.0.1 May 18, 2013
First release


## Development
Fork the project and install all the dependencies with:
```bash
bundle
```

To run the tests:
```bash
rake
```

## Author
José M. Gilgado

##License
MIT License

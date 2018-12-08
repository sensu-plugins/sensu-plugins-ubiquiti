# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

## [3.0.0] - 2018-12-08
### Breaking Changes
- Update sensu-plugin to 3.0: https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#300---2018-12-04 @jaredledvina

### Changes
- Update rubocp to 0.57.2 @jaredledvina
- Update codeclimate to 1.0 @jaredledvina
- Update rake to 12.3 @jaredledvina
- Update unifi-api to 0.1.2 @jaredledvina
- Update github-markup to 3.0 @jaredledvina


## [2.0.0] - 2018-01-31
### Security
- updated `rubocop` dependency to `~> 0.51.0` per: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8418. (@jaredledvina)

### Breaking Changes
- in order to bring in new rubocop dependency we need to drop ruby 2.0 support as it is EOL and aligns with out support policy. (@jaredledvina)

### Added
- Ruby 2.4.1 testing

### Changed
- update Changelog guidelines location (@majormoses)

### Fixed
- PR template spelling
- misc formatting (@majormoses)

## [1.1.0] - 2016-10-26
### Added
- Add `site_id` option for collecting metrics from a non-default site

## [1.0.0] - 2016-10-21

Note: this release changes the check parameters due to removing the shell out to `unifi-get-stats.py`.

### Changed
- Use `unifi-api` gem instead of shelling out to unifi-get-stats.py script
- Update to Rubocop 0.40 and cleanup

### Added
- Add Ruby 2.3.0 support

### Removed
- Remove Ruby 1.9.3 support
- Remove unused unifi-get-stats.py script

## [0.0.1] - 2015-08-24
### Added
- initial release of this sensu plugin repo

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-ubiquiti/compare/2.0.0...HEAD
[2.0.0]: https://github.com/sensu-plugins/sensu-plugins-ubiquiti/compare/1.1.0...2.0.0
[1.1.0]: https://github.com/sensu-plugins/sensu-plugins-ubiquiti/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-ubiquiti/compare/0.0.1...1.0.0

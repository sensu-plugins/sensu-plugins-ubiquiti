#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
### Added
- Ruby 2.4.1 testing

### Fixed
- PR template spelling

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

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-ubiquiti/compare/1.1.0...HEAD
[1.1.0]: https://github.com/sensu-plugins/sensu-plugins-ubiquiti/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-ubiquiti/compare/0.0.1...1.0.0

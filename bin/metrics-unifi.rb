#! /usr/bin/env ruby
#
#   metrics-unifi.rb
#
# DESCRIPTION:
#   This plugin collects metrics from a Unifi wireless controller
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   metrics-unifi.rb
#
# NOTES:
#
#
# LICENSE:
#   Copyright Eric Heydrick <eheydrick@gmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/metric/cli'
require 'open3'
require 'socket'

# Collect unifi metrics
class UnifiMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.unifi"

  option :hostname,
         description: 'Unifi AP controller hostname',
         short: '-h HOSTNAME',
         long: '--hostname HOSTNAME',
         default: 'unifi'

  option :username,
         description: 'Username',
         short: '-u USERNAME',
         long: '--username USERNAME',
         default: 'unifi'

  option :password,
         description: 'Password',
         short: '-p PASSWORD',
         long: '--password PASSWORD'

  option :path,
         description: 'Path to unifi-get-stats.py',
         short: '-i PATH',
         default: '/usr/local/bin'

  def unifi_stats
    stdout, result = Open3.capture2("#{config[:path]}/unifi-get-stats.py -c #{config[:hostname]} -u #{config[:username]} -p #{config[:password]}")
    unknown 'Unable to get Unifi AP stats' unless result.success?
    stdout
  end

  def run
    unifi_stats = JSON.parse(unifi_stats)
    unifi_stats.each do |metric, value|
      output "#{config[:scheme]}.#{metric}", value
    end
    ok
  end
end

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
#   metrics-unifi.rb -c unifi.int.mycompany.co -i /dir/containing/unifi-get-stats/binary/ -u admin -p unifipassword
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
require 'json'

# Collect unifi metrics
class UnifiMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.unifi"

  option :controller,
         description: 'Unifi AP controller hostname',
         short: '-c HOSTNAME',
         long: '--controller HOSTNAME',
         default: 'unifi'

  option :username,
         description: 'Username',
         short: '-u USERNAME',
         long: '--username USERNAME',
         default: 'admin'

  option :password,
         description: 'Password',
         short: '-p PASSWORD',
         long: '--password PASSWORD',
         required: true

  option :path,
         description: 'Path to unifi-get-stats.py',
         short: '-i PATH',
         default: '/usr/local/bin'

  def unifi_stats
    unknown "Could not find #{config[:path]}/unifi-get-stats.py" unless File.exist?("#{config[:path]}/unifi-get-stats.py")
    stdout, result = Open3.capture2("#{config[:path]}/unifi-get-stats.py -c #{config[:controller]} -u #{config[:username]} -p #{config[:password]}")
    unknown 'Unable to get Unifi AP stats' unless result.success?
    stdout
  end

  def run
    stats = JSON.parse(unifi_stats)
    stats.each do |metric, value|
      output "#{config[:scheme]}.#{metric}", value
    end
    ok
  end
end

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
#   collect metrics from the default site:
#   metrics-unifi.rb -c unifi.int.mycompany.co -u admin -p unifipassword
#
#   collect metrics from site 'mywifi':
#   metrics-unifi.rb -c unifi.int.mycompany.co -u admin -p unifipassword -S mywifi
#
# NOTES:
#   Specify the site ID if using a non-default site. The site ID can be obtained from the
#   web UI e.g. /manage/s/<site>/dashboard
#
# LICENSE:
#   Copyright Eric Heydrick <eheydrick@gmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/metric/cli'
require 'socket'
require 'unifi/api'

# Collect unifi metrics
class UnifiMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.unifi"

  option :controller,
         description: 'Unifi AP controller hostname (default: unifi)',
         short: '-c HOSTNAME',
         long: '--controller HOSTNAME',
         default: 'unifi'

  option :username,
         description: 'Username (default: admin)',
         short: '-u USERNAME',
         long: '--username USERNAME',
         default: 'admin'

  option :password,
         description: 'Password',
         short: '-p PASSWORD',
         long: '--password PASSWORD',
         required: true

  option :port,
         description: 'Port (default: 8443)',
         short: '-P PORT',
         long: '--port PORT',
         default: 8443

  option :unifi_version,
         description: 'Unifi API version (default: v4)',
         short: '-V VERSION',
         long: '--unifi-version VERSION',
         default: 'v4'

  option :site_id,
         description: 'Site ID (default: default)',
         short: '-S SITE ID',
         long: '--site-id SITE ID',
         default: 'default'

  def unifi_stats
    unifi = Unifi::Api::Controller.new(config[:controller], config[:username], config[:password], config[:port], config[:unifi_version], config[:site_id])
    aps = unifi.get_aps

    metrics = Hash.new(0)

    aps.each do |ap|
      metrics['total'] += ap['num_sta']
      metrics['guests'] += ap['guest-num_sta']
      metrics['users'] += ap['user-num_sta']
    end

    metrics
  end

  def run
    unifi_stats.each do |metric, value|
      output "#{config[:scheme]}.#{metric}", value
    end
    ok
  end
end

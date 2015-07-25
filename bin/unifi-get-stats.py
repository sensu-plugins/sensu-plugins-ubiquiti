#!/usr/bin/env python
#
# Get stats from a Unifi AP controller using the API
#
# Requires the unifi python module
#

import argparse
import json

from unifi.controller import Controller

parser = argparse.ArgumentParser()
parser.add_argument('-c', '--controller', default='unifi', help='the controller address (default "unifi")')
parser.add_argument('-u', '--username', default='admin', help='the controller username (default("admin")')
parser.add_argument('-p', '--password', default='', help='the controller password')
parser.add_argument('-b', '--port', default='8443', help='the controller port (default "8443")')
parser.add_argument('-v', '--version', default='v2', help='the controller base version (default "v2")')
parser.add_argument('-s', '--siteid', default='default', help='the site ID, UniFi >=3.x only (default "default")')
args = parser.parse_args()

c = Controller(args.controller, args.username, args.password, args.port, args.version, args.siteid)

aps = c.get_aps()

total = guests = users = 0

for ap in aps:
    total += ap['num_sta']
    guests += ap['guest-num_sta']
    users += ap['user-num_sta']

stats = {'total': total, 'guests': guests, 'users': users}

print json.dumps(stats)
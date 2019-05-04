import os
import argparse
from hosts import Hosts

BLACK_HOLE_IP='127.0.0.1'
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Block/unblock hosts')

    parser.add_argument('hosts_path')
    parser.add_argument('-ba', '--block-all', action='store', dest='block_all')
    parser.add_argument('-ua', '--unblock-all', action='store', dest='unblock_all')
    parser.add_argument('-b', '--block', action='store', dest='block')
    parser.add_argument('-u', '--unblock', action='store', dest='unblock')

    args = parser.parse_args()
    hosts = Hosts(args.hosts_path)
    hosts.print_all()
    try:
        if args.block_all:
            with open(args.block_all,'r') as f:
                names = f.read().split()
                for hostname in names:
                    print('Blocking ' + hostname)
                    hosts.set_one(hostname, BLACK_HOLE_IP)

        elif args.unblock_all is not None:
            with open(args.unblock_all,'r') as f:
                names = f.read().split()
                for hostname in names:
                    print('Unblcoking ' + hostname)
                    hosts.remove_one(hostname, False)


        elif args.block:
            hosts.set_one(args.block, BLACK_HOLE_IP)
        elif args.unblock:
            hosts.remove_one(args.unblock, False)
 
        hosts.write(args.hosts_path)
    except Exception as e:
        print('Error: %s' % (e,))
        exit(1)

#!/usr/bin/env python3
import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument('--workdir', default='/home/pokyuser',
                    help='The active directory once the container is running. '
                         'In the abscence of the "id" argument, the uid and '
                         'gid of the workdir will also be used for the user '
                         'in the container.')

parser.add_argument("--id",
                    help='uid and gid to use for the user inside the '
                         'container. It should be in the form uid:gid')

parser.add_argument("cmd", nargs=argparse.REMAINDER,
                    help='command to run after setting up container. '
                         'Often used for testing.')

args = parser.parse_args()

if os.getcwd() != "/home/yoctouser":
    # --workdir was given to the docker command, not to us, so
    # we need to pretend it was given to us...
    args.workdir = os.getcwd()

idargs = ""
if args.id:
    uid, gid = args.id.split(":")
    idargs = "--uid={} --gid={}".format(uid, gid)

elif args.workdir == '/home/pokyuser':
    # If the workdir wasn't specified pick a default uid and gid since
    # usersetup won't be able to calculate it from the non-existent workdir
    idargs = "--uid=1000 --gid=1000"

cmd = """usersetup.py --username=pokyuser --workdir={wd}
         {idargs} poky-launch.sh {wd}""" \
             .format(wd=args.workdir, idargs=idargs)
cmd = cmd.split()
if args.cmd:
    cmd.extend(args.cmd)
os.execvp(cmd[0], cmd)
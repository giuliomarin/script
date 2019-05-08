#!/usr/bin/env python

import os
import math
import sys
import subprocess
from matplotlib import pyplot as plt

def getlog(folder):
    if not os.path.isdir(folder):
        return ''
    try:
        p = subprocess.Popen('git log --no-merges --author="' + author + '" --pretty=format:"%aD"',
                             cwd=folder, stdout=subprocess.PIPE, shell=True)
        entries, _ = p.communicate()
    except OSError:
        print('Git not installed?')
        sys.exit(-1)
    if entries == '':
        print('Not a git repository?')
        sys.exit(-1)
    print '[%d] %s' % (len(entries.split('\n')), folder)
    return entries


if __name__ == '__main__':

    # get list of authors
    # git log --pretty=format:"%an" | sort | uniq -c | sort -r

    # default values
    scaley = 1.7

    # author
    author = ''
    if len(sys.argv) > 1:
        author = sys.argv[1]

    # list of directories to use to compute statistics
    listdirs = ['.']
    # if len(sys.argv) > 1:
    #     listdirs = sys.argv[1:]

    # get all the logs
    alllogs = ''
    for f in listdirs:
        alllogs += getlog(f) + r'\n'

    # extract day and hour
    dayhour = [[x.strip().split(',')[0], x.strip().split(' ')[4].split(':')[0]] for x in alllogs.split('\n')]

    # compute statistics
    days = ['Sun', 'Sat', 'Fri', 'Thu', 'Wed', 'Tue', 'Mon']
    hours = [str(x) for x in xrange(24)]
    stats = {}
    for d in days:
        stats[d] = {}
        for h in xrange(24):
            stats[d][h] = 0
    for dh in dayhour:
        stats[dh[0]][int(dh[1])] += 1.0

    # normalize
    allvalues = []
    for d, hn in stats.items():
        for h, n in hn.items():
            allvalues.append(n)
    nmax = max(allvalues)
    statsnorm = []
    for d, hn in stats.items():
        for h, n in hn.items():
            statsnorm.append([(h, days.index(d) * scaley), n / nmax / 2.])

    ##############
    # print data
    ##############

    plt.figure('punchcard')

    # data
    ax = plt.gca()
    for each in statsnorm:
        r = each[1]
        if r == 0:
            continue
        clr = [0.2, 0.2, 0.2]
        area = (3.14 * r ** 2) * 200
        # plt.scatter(x, y, s=area, c=clr, alpha=1)
        c = plt.Circle(each[0], radius=r, color=clr, alpha=0.8)
        ax.add_patch(c)

    # other
    for d in range(7):
        y = (d - 0.5) * scaley
        plt.plot([-1, 24], [y, y], 'k-', lw=0.5)
        for h in range(12):
            plt.plot([h * 2, h * 2], [y, y + 0.3], 'k-', lw=0.5)
            plt.plot([h * 2 + 1, h * 2 + 1], [y, y + 0.1], 'k-', lw=0.5)

    # labels
    x = [hour for hour in range(24)]
    y = [day * scaley for day in range(7)]
    plt.xticks(x, hours)
    plt.yticks(y, days)
    # ax.yaxis.grid(True)
    ax.tick_params(axis=u'both', which=u'both', length=0)
    # plt.gca().xaxis.grid(True)
    plt.title('Author: %s' % author if len(author) > 0 else '')
    plt.axis('scaled')
    ax.set_xlim([x[0] - 1, x[-1] + 1])
    ax.set_ylim([y[0] - 1, y[-1] + 1])
    for spine in ax.spines.itervalues():
        spine.set_visible(False)
    plt.savefig('punchcard.png', dpi = 200)
    plt.show()

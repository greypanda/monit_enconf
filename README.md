# monit_enconf and monit_disconf for quick configuration enabling and disabling

# This is a work-in-progress. The basic operation is working, but docs are still incomplete #
# There is also some un-needed code in the script, but it only produces useless messages. #

## Description
This is a shell (Bash) script that replicates for monit the a2ensite 
and a2dissite for enabling and disabling configurations. It was
forked from pendalff/nginx_ensite.

The original `a2ensite` and `a2dissite` is written in
Perl. `a2dissite` is a symbolic link to `a2ensite`. This follows
the same approach, i.e., `monit_disconf` is a symbolic link to
`monit_enconf`.

## Installation 

Just drop the script and the symbolic link in `/usr/sbin` or other
location appropriate for your system. Meaning: `cp monit_* /usr/sbin`.
That's it you're done. 

Note that the script assumes a specific file system topology for your
`monit` configuration, close to the Ubuntu installation of monit.
Here's the rundown:

 1. All configuration files should be under
    `/etc/monit/conf-available`. For example the monitoring 
    configuration `foobar` is configured through a file in 
    `/etc/monit/conf-available`.

 2. After running the script with `foobar` as argument: `monit_enconf
    foobar`, a symbolic link `/etc/monit/conf-enabled/foobar ->
    /etc/monit/conf-available/foobar` is created. Note that if the
    `/etc/monit/conf-enabled` directory doesn't exist the script
    creates it.

 3. The script invokes `monit -t` to test if the configuration is
    correct. If the test fails no symbolic link is created and an error
    is signaled.

 4. If everything is correct now just reload monit, in Debian based
    systems that means invoking `/etc/init.d/monit reload`.
    ( In modern distributions, this would be systemctl reload monit. )

 5. Now point the browser to the monit web host and everything
    should work properly assuming your configuration is sensible.

 6. To disable the site just run `monit_disconf foobar`. Reload monit
    to update the running environment.

## Requirements

The script is written in Bash and uses what I believe to be some Bash
specific idioms. I never tested it in other shells. You're welcomed to
try it in any other shell. Please do tell me how it went. 

It requires also [awk](http://en.wikipedia.org/wiki/AWK). The original
`awk` (usually called BWK awk) from Bell Labs will do if you don't
have [gawk](http://www.gnu.org/software/gawk) (Gnu awk).  IN OS X and
*BSD the former is the default `awk`. The script should work in *BSD,
OS X and GNU/Linux.

## Command Completion

There's a Bash script for automatic completion of sites to be
enabled and disabled located in the `bash_completion.d` directory.

To make use of it you should:

 1. Source the script to Bash by issuing either `source
    monit-enconf` or `. monit-enconf`. 

 2. Now when you invoke `monit_enconf` the sites under
    `/etc/monit/conf-available` will appear as hypothesis for
    completion. For `monit_disconf you get all the sites listed in
    `/etc/monit/conf-enabled` as possible completions.

 3. To get the completion script to be sourced upon login please
    copy it to `/etc/bash_completion.d/` or whatever location your
    shell environment uses to place all the completion
    scripts. `/etc/bash_completion.d/` is the location in Debian
    (hence also in Ubuntu) of Bash completion scripts.
      
## Manual pages

Two UNIX manual pages are included in the man directory. They should
be copied to a proper directory in your system. Something along the
lines of `/usr/share/man/man8` or `/usr/local/share/man/man8`.

Here's an [online](http://github.perusio.org/nginx_ensite/) version of
the manpage.


## Security & Trust

The script is signed with my GPG key. Just do `gpg --keyserver
keys.gpg.net --recv-keys 4D722217`. Verify by issuing `gpg --verify
nginx_ensite.sig`.

## Acknowledgments

Thanks to [xufan6](http://github.com/xufan6) for setting me on the path of the Bash completion
script.

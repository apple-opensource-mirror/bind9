#!/usr/bin/env perl
#
# Copyright (C) 2009, 2010  Internet Systems Consortium, Inc. ("ISC")
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS.  IN NO EVENT SHALL ISC BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
# OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

# $Id: bindkeys.pl,v 1.3.104.2 2010-06-20 23:46:24 tbox Exp $

use strict;
use warnings;

my $rev = '$Id: bindkeys.pl,v 1.3.104.2 2010-06-20 23:46:24 tbox Exp $';
$rev =~ s/\$//g;
$rev =~ s/,v//g;
$rev =~ s/Id: //;

my $keys = "";

my $lines;
while (<>) {
    chomp;
    if (/\/\* .Id:.* \*\//) {
	$keys = $_;
        next;
    }
    s/\"/\\\"/g;
    s/$/\\n\\/;
    $lines .= $_ . "\n";
}

$keys =~ s/\$//g;
$keys =~ s/\/\* Id: //;
$keys =~ s/\*\/.*//;
$keys =~ s/,v//;

print "/*\n * Generated by $rev \n * From $keys\n */\n";

my $mkey = '#define MANAGED_KEYS "\\' . "\n" . $lines . "\"\n";

$lines =~ s/managed-keys/trusted-keys/;
$lines =~ s/\s+initial-key//;
my $tkey = '#define TRUSTED_KEYS "\\' . "\n" . $lines . "\"\n";

print $tkey;
print "\n";
print $mkey;

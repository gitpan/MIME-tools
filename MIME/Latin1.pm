package MIME::Latin1;

=head1 NAME

MIME::Latin1 - translate ISO-8859-1 into 7-bit approximations

=head1 SYNOPSIS

    use MIME::Latin1 qw(latin1_to_ascii);
    
    $dirty = "Fran\347ois";
    print latin1_to_ascii($dirty);      # prints out "Fran\c,ois"

=head1 DESCRIPTION

This is a small package used by the C<"7bit"> encoder/decoder for
handling the case where a user wants to 7bit-encode a document
that contains 8-bit (presumably Latin-1) characters.

=head1 PUBLIC INTERFACE 

=over

=cut

use strict;
use vars qw(@Map @ISA @EXPORT_OK $VERSION);

require Exporter;

@ISA = qw(Exporter);
@EXPORT_OK = qw(latin1_to_ascii);


# The package version, both in 1.23 style *and* usable by MakeMaker:
( $VERSION ) = '$Revision: 1.1 $ ' =~ /\$Revision:\s+([^\s]+)/;

# The map:
@Map = (
          #  char decimal description
          #------------------------------------------------------------
 "  "   , #  �   160   non-breaking space
 "!!"   , #  �   161   inverted exclamation
 "c/"   , #  �   162   cent sign
 "L-"   , #  �   163   pound sterling
 "ox"   , #  �   164   general currency sign
 "Y-"   , #  �   165   yen sign
 "||"   , #  �   166   broken vertical bar
 "so"   , #  �   167   section sign
 '""'   , #  �   168   umlaut (dieresis)
 "co"   , #  �   169   copyright
 "-a"   , #  �   170   feminine ordinal
 "<<"   , #  �   171   left angle quote, guillemotleft
 "-,"   , #  �   172   not sign
 "--"   , #  �   173   soft hyphen
 "ro"   , #  �   174   registered trademark
 "^-"   , #  �   175   macron accent
 "^*"   , #  �   176   degree sign
 "+-"   , #  �   177   plus or minus
 "^2"   , #  �   178   superscript two
 "^3"   , #  �   179   superscript three
 "' "   , #  �   180   acute accent
 "/u"   , #  �   181   micro sign
 "P!"   , #  �   182   paragraph sign
 "^."   , #  �   183   middle dot
 ",,"   , #  �   184   cedilla
 "^1"   , #  �   185   superscript one
 "_o"   , #  �   186   masculine ordinal
 ">>"   , #  �   187   right angle quote, guillemotright
 "14"   , #  �   188   fraction one-fourth
 "12"   , #  �   189   fraction one-half
 "34"   , #  �   190   fraction three-fourths
 "??"   , #  �   191   inverted question mark
 "A`"   , #  �   192   capital A, grave accent
 "A'"   , #  �   193   capital A, acute accent
 "A^"   , #  �   194   capital A, circumflex accent
 "A~"   , #  �   195   capital A, tilde
 'A"'   , #  �   196   capital A, dieresis or umlaut mark
 'A*'   , #  �   197   capital A, ring
 'AE'   , #  �   198   capital AE diphthong (ligature)
 'C,'   , #  �   199   capital C, cedilla
 "E`"   , #  �   200   capital E, grave accent
 "E'"   , #  �   201   capital E, acute accent
 'E^'   , #  �   202   capital E, circumflex accent
 'E"'   , #  �   203   capital E, dieresis or umlaut mark
 "I`"   , #  �   204   capital I, grave accent
 "I'"   , #  �   205   capital I, acute accent
 "I^"   , #  �   206   capital I, circumflex accent
 'I"'   , #  �   207   capital I, dieresis or umlaut mark
 'D-'   , #  �   208   capital Eth, Icelandic
 'N~'   , #  �   209   capital N, tilde
 "O`"   , #  �   210   capital O, grave accent
 "O'"   , #  �   211   capital O, acute accent
 "O^"   , #  �   212   capital O, circumflex accent
 "O~"   , #  �   213   capital O, tilde
 'O"'   , #  �   214   capital O, dieresis or umlaut mark
 'xx'   , #  �   215   multiply sign
 'O/'   , #  �   216   capital O, slash
 'U`'   , #  �   217   capital U, grave accent
 "U'"   , #  �   218   capital U, acute accent
 "U^"   , #  �   219   capital U, circumflex accent
 'U"'   , #  �   220   capital U, dieresis or umlaut mark
 "Y'"   , #  �   221   capital Y, acute accent
 "P|"   , #  �   222   capital THORN, Icelandic
 "ss"   , #  �   223   small sharp s, German (sz ligature)
 "a`"   , #  �   224   small a, grave accent
 "a'"   , #  �   225   small a, acute accent
 "a^"   , #  �   226   small a, circumflex accent
 "a~"   , #  �   227   small a, tilde
 'a"'   , #  �   228   small a, dieresis or umlaut mark
 'a*'   , #  �   229   small a, ring
 'ae'   , #  �   230   small ae diphthong (ligature)
 'c,'   , #  �   231   small c, cedilla
 "e`"   , #  �   232   small e, grave accent
 "e'"   , #  �   233   small e, acute accent
 "e^"   , #  �   234   small e, circumflex accent
 'e"'   , #  �   235   small e, dieresis or umlaut mark
 "i`"   , #  �   236   small i, grave accent
 "i'"   , #  �   237   small i, acute accent
 "i^"   , #  �   238   small i, circumflex accent
 'i"'   , #  �   239   small i, dieresis or umlaut mark
 'd-'   , #  �   240   small eth, Icelandic
 'n~'   , #  �   241   small n, tilde
 "o`"   , #  �   242   small o, grave accent
 "o'"   , #  �   243   small o, acute accent
 "o^"   , #  �   244   small o, circumflex accent
 "o~"   , #  �   245   small o, tilde
 'o"'   , #  �   246   small o, dieresis or umlaut mark
 '-:'   , #  �   247   division sign
 'o/'   , #  �   248   small o, slash
 "u`"   , #  �   249   small u, grave accent
 "u'"   , #  �   250   small u, acute accent
 "u^"   , #  �   251   small u, circumflex accent
 'u"'   , #  �   252   small u, dieresis or umlaut mark
 "y'"   , #  �   253   small y, acute accent
 "th"   , #  �   254   small thorn, Icelandic
 'y"'   , #  �   255   small y, dieresis or umlaut mark
);

=item latin1_to_ascii STRING,[OPTS]

Map the Latin-1 characters in the string to sequences of the form:

     \xy

Where C<xy> is a two-character sequence that visually approximates
the Latin-1 character.  For example:

     c cedilla      => \c,
     n tilde        => \n~
     AE ligature    => \AE
     small o slash  => \o/

The sequences are taken almost exactly from the Sun character composition
sequences for generating these characters.  The translation may be further
tweaked by the OPTS string:

B<If no OPTS string is given,> only 8-bit characters are affected,
and their output is of the form C<\xy>:

      \<<Fran\c,ois Mu\"ller\>>   c:\usr\games

B<If the OPTS string contains 'NOSLASH',> then the leading C<"\">
is not output, and the output is more compact:

      <<Franc,ois Mu"ller>>       c:\usr\games

B<If the OPTS string contains 'ENCODE',> then not only is the leading C<"\">
output, but any other occurences of C<"\"> are escaped as well by turning
them into C<"\\">.  This produces output which may easily be parsed
and turned back into the original 8-bit characters, so in a way it is
its own full-fledged encoding... and given that C<"\"> is a rare-enough
character, not much uglier that the normal output: 

      \<<Fran\c,ois Mu\"ller\>>   c:\\usr\\games

=cut

sub latin1_to_ascii {
    my ($str, $opts) = @_;

    # Extract options:
    $opts ||= '';
    my $o_encode  = ($opts =~ /\bENCODE\b/i);
    my $o_noslash = ($opts =~ /\bNOSLASH\b/i) && !$o_encode;
    my $slash = ($o_noslash ? '' : '\\');

    # Encode:
    $str =~ s/\\/\\\\/g if $o_encode;
    $str =~ s/[\240-\377]/$slash.$Map[ord($&)-0240]||''/eg;
    $str;
}

=back

=head1 AUTHOR

Copyright (c) 1996 by Eryq / eryq@rhine.gsfc.nasa.gov

All rights reserved.  This program is free software; you can redistribute 
it and/or modify it under the same terms as Perl itself.


=head1 VERSION

$Revision: 1.1 $ $Date: 1996/10/17 15:22:24 $

=cut



#------------------------------------------------------------
# Execute simple test if run as a script.
#------------------------------------------------------------
{ 
  package main; no strict;
  eval join('',<main::DATA>) || die "$@ $main::DATA" unless caller();
}
1;           # end the module
__END__


    
use MIME::Latin1 qw(latin1_to_ascii);


$dirty = "\253Fran\347ois M\374ller\273 c:\\usr\\games";
print "\n";

print "Option: default:\n";
print latin1_to_ascii($dirty), "\n\n";

print "Option: ENCODE:\n";
print latin1_to_ascii($dirty, 'ENCODE'), "\n\n";

print "Option: NOSLASH:\n";
print latin1_to_ascii($dirty, 'NOSLASH'), "\n\n";



#------------------------------------------------------------
1;

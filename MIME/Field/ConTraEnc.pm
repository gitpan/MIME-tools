package MIME::Field::ConTraEnc;

=head1 NAME

MIME::Field::ConTraEnc - a "Content-transfer-encoding" field

=head1 DESCRIPTION

A subclass of Mail::Field.  

I<Don't use this class directly... its name may change in the future!>
Instead, ask Mail::Field for new instances based on the field name!


=head1 SYNOPSIS

    use Mail::Field;
    use MIME::Head;
    
    # Create an instance from some text:
    $field = Mail::Field->new('Content-transfer-encoding', '7bit');
    
    # Get the encoding.
    #    Possible values: 'binary', '7bit', '8bit', 'quoted-printable', 
    #    'base64' and '' (unspecified).  Note that there can't be a 
    #    single default for this, since it depends on the content type!
    $encoding = $field->encoding;

=cut

require 5.001;
use strict;
use MIME::Field::ParamVal;
use vars qw($VERSION @ISA);

@ISA = qw(MIME::Field::ParamVal);

# The package version, both in 1.23 style *and* usable by MakeMaker:
( $VERSION ) = '$Revision: 1.1 $ ' =~ /\$Revision:\s+([^\s]+)/;

# Install it: 
bless([])->register('Content-transfer-encoding');

#------------------------------------------------------------

sub encoding {
    my $value = shift->param('_', @_);
    defined($value) ? lc($value) : '';      # all lowercase!
}

#------------------------------------------------------------
1;


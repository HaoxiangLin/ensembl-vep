=head1 LICENSE

Copyright [2016] EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut


=head1 CONTACT

 Please email comments or questions to the public Ensembl
 developers list at <http://lists.ensembl.org/mailman/listinfo/dev>.

 Questions may also be sent to the Ensembl help desk at
 <http://www.ensembl.org/Help/Contact>.

=cut

# EnsEMBL module for Bio::EnsEMBL::VEP::OutputFactory::BaseTab
#
#

=head1 NAME

Bio::EnsEMBL::VEP::OutputFactory::BaseTab - tab-delimited output factory base class

=cut


use strict;
use warnings;

package Bio::EnsEMBL::VEP::OutputFactory::BaseTab;

use base qw(Bio::EnsEMBL::VEP::OutputFactory);

sub headers {
  my $self = shift;

  my $info = $self->header_info();
  
  my @headers = (
    '## ENSEMBL VARIANT EFFECT PREDICTOR v'.$info->{vep_version},
    '## Output produced at '.$info->{time},
  );

  push @headers, sprintf("## Connected to %s on %s", $info->{db_name}, $info->{db_host}) if $info->{db_name};
  push @headers, "## Using cache in ".$info->{cache_dir} if $info->{cache_dir};

  push @headers, sprintf("## Using API version %i, DB version %s", $info->{api_version}, $info->{db_version} || '?');

  push @headers, "## $_ version ".$info->{version_data}->{$_} for keys %{$info->{version_data} || {}};

  push @headers, @{$self->description_headers};

  push @headers, $self->column_header;

  return \@headers;
}


return 1;

package SecretSanta;

use 5.010;
use strict;
use warnings;
use DDP;

#  1 Рита Игорь
#  2 Вадим Катя
#  3 Али
#  4 Ира


sub calculate {
	#my @members = ( 'Рита', 'Игорь', 'Вадим', ['Катя', 'Али'], 'Ира');
	my @members = @_; 
	my @res;
	my %presented;
	my @all = map {if (ref($_)) {@$_} else {$_} } @members;
	my %uniq;
	my @all_members = grep { !$uniq{$_}++ } @all;
	my $n = scalar @all_members;
	if ( $n > 2 ) {	
		if ( $n == 3 and ((scalar grep {ref($_)} @members) != 0) ) {
			@res = ();
		}
		else {
			my %hash;
			%hash = map {@$_} grep{ ref($_) } @members;
			my @all_members_temp = %hash;
			%hash =  (%hash, reverse map {@$_} grep{ ref($_) } @members );
			@all_members_temp[scalar @all_members_temp..$n-1] = grep{! exists $hash{$_}} @all_members;
			@all_members = ();
			@all_members = @all_members_temp;
		
			for (my $i = 0; $i < $n; $i++) {
				my $rand = int(rand($n));
				if ( grep {$_ eq  $all_members[$rand]  } values %presented ) {
		       	                 if ($i == $n-1) {
						$i = 0;
						%presented = ();
						@res = ();
					}
					redo;
		      	  	}
				$presented { $all_members[$i] } = $all_members [ $rand ];
				if ( $presented{$all_members[$i]} eq  $all_members[$i] ){
					redo;
				} 
				if ( exists $hash{$all_members[$i]} and ($presented{$all_members[$i]} eq  $hash{$all_members[$i]})) {
					redo;
				}
				if ( exists $presented{$all_members[$rand]} and $presented{$all_members[$rand]} eq $all_members[$i] ) { 
					redo;
				}
				push @res,[ $all_members[$i], $presented{$all_members[$i]} ];
			}
		}
	}
	else {
		@res = ();
	}
	#p @res;
	return @res;

}
#calculate;

1;

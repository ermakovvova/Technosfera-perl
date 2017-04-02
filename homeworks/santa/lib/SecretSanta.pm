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
	#my @members = ( 'Рита', 'Игорь', ['Вадим', 'Катя'], 'Али', 'Ира');
	my @members = @_; 
	my @res;
	my %presented;
	my @all = map {if (ref($_)) {@$_} else {$_} } @members;
	my %uniq;
	my @all_members = grep { !$uniq{$_}++ } @all;
	my $n = scalar @all_members;
	if ( $n > 3 ) {	
		my %hash;
		if ( (scalar grep {ref($_)} @members) != 0 ) {
			%hash = map {@$_} grep{ ref($_) } @members;
			my @all_members_temp = %hash;
			%hash =  (%hash, reverse map {@$_} grep{ ref($_) } @members );
			@all_members_temp[scalar @all_members_temp..$n-1] = grep{! exists $hash{$_}} @all_members;
			@all_members = ();
			@all_members = @all_members_temp;
		}
		else {
			my $non_friend1 = int(rand($n));
			my $non_friend2;
			do {
				$non_friend2 = int(rand($n))
			} while ($non_friend1 == $non_friend2);
			%hash = (
				$all_members[$non_friend1] => $all_members[$non_friend2]
			);
			$hash { $all_members [$non_friend2] } = $all_members[$non_friend1];
			my @all_members_temp;
			$all_members_temp[0] = $all_members [$non_friend1];
			$all_members_temp[1] = $all_members [$non_friend2];
			@all_members_temp [2..$n-1] = grep {$_ ne ($all_members_temp[0]) and  $_ ne ($all_members_temp[1])} @all_members;
			@all_members = ();
			@all_members = @all_members_temp;
		}
		
		for (my $i = 0; $i < $n; $i++) {
			my $rand = int(rand($n));
			if ( grep {$_ eq  $all_members[$rand]  } values %presented ) {
	                        if ($i == $n-1) {
					$i = 0;
					%presented = ();
					@res = ();
				}
				redo
		        }
			$presented { $all_members[$i] } = $all_members [ $rand ];
			if ( $presented{$all_members[$i]} eq  $all_members[$i] ){
				redo;
			} 
			if ( exists $hash{$all_members[$i]} and ($presented{$all_members[$i]} eq  $hash{$all_members[$i]})) {
				redo;
			}
			push @res,[ $all_members[$i], $presented{$all_members[$i]} ];
		}
		
	}
	else {
		@res = ()
	}
	return @res;

}
#calculate;

1;

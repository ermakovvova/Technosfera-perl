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
	my @members = @_; 
	my @res;
	my %presented;
	my @all = map {if (ref($_)) {@$_} else {$_}} @members;
	my %uniq;
	my @all_members = grep { !$uniq{$_}++ } @all;
	my $n = scalar @all_members;
	my %hash;
		if ( (scalar grep {ref($_)} @members) != 0 ) {
		%hash = map {@$_} grep{ ref($_) } @members;
		%hash =  (%hash, reverse map {@$_} grep{ ref($_) } @members );
	}
	else {
		my $non_friend1 = int(rand($n));
		my $non_friend2;
		do {
			$non_friend2 = int(rand($n))
		} while ($non_friend1 == $non_friend2);
		%hash = (
			$all_members[$non_friend1] => $all_members[$non_friend2],
			$all_members[$non_friend2] => $all_members[$non_friend1],
		)
	}	
	for (my $i = 0; $i < $n; $i++) {
		#print "$i\n";
		my $rand = int(rand($n));
		#print "$rand\n";
		$presented { $all_members[$i] } = $all_members [ $rand ];
		if ( $presented{$all_members[$i]} eq  $all_members[$i] ){
			redo;
		} 
		if ( exists $hash{$all_members[$i]} and ($presented{$all_members[$i]} eq  $hash{$all_members[$i]})) {
			redo;
		}	
		push @res,[ "$all_members[$i]", "$presented{$all_members[$i]}" ];
	}
	return @res;

}
#calculate;

1;

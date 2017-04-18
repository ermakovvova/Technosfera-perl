package DeepClone;

use 5.010;
use strict;
use warnings;

use DDP;

=encoding UTF8

=head1 SYNOPSIS

Клонирование сложных структур данных

=head1 clone($orig)

Функция принимает на вход ссылку на какую либо структуру данных и отдаюет, в качестве результата, ее точную независимую копию.
Это значит, что ни один элемент результирующей структуры, не может ссылаться на элементы исходной, но при этом она должна в точности повторять ее схему.

Входные данные:
* undef
* строка
* число
* ссылка на массив
* ссылка на хеш
Элементами ссылок на массив и хеш, могут быть любые из указанных выше конструкций.
Любые отличные от указанных типы данных -- недопустимы. В этом случае результатом клонирования должен быть undef.

Выходные данные:
* undef
* строка
* число
* ссылка на массив
* ссылка на хеш
Элементами ссылок на массив или хеш, не могут быть ссылки на массивы и хеши исходной структуры данных.

=cut

my $ref_hash = {};
#my $ref_sign->{sign} = 0;

sub clone {
	$| = 1;
	my $orig = shift;

	#my $sign = 
	#p $orig;
	my $cloned;
	#print "sign = $sign\n";
	#if ($sign == 1) {
	#	return undef $cloned;
	#}
	#my $ref_hash = {};
	
	#sub reccur {
		#my $source = shift;
		#my $ref_hash = shift;
		#my $result;
		my $sign = 0;
		
		if ( !ref($orig)) {
			$cloned = $orig;
		}	
		else {
			if (ref($orig) eq "HASH") {
				$cloned = {%{$orig}};
				$ref_hash -> { $orig } = $cloned; 
				for my $var (keys %{$cloned}) {
					if ($ref_hash-> {$orig-> {$var}}) {
						$cloned->{$var} = $ref_hash-> {$orig->{$var}} ;
					}
					else {	
						$cloned->{$var} = clone($cloned-> {$var});
						#$sign++;
						if ((!(defined $cloned->{$var}) )  and (defined $orig->{$var} )) {
							$| = 1;
							print "sub\n";
							return (undef $cloned);
						}
						
					}
				}
			}
			elsif( ref($orig) eq "ARRAY") {
				$cloned = [@{$orig}];
				$ref_hash -> {$orig}  = $cloned;
				my $i = 0;
				for my $var (@{$cloned}) {
					if ($ref_hash-> {$orig->[$i]}) {
						$cloned->[$i] = $ref_hash -> {$orig-> [$i]};
					}
					else {
						#my @arr = clone($var); #,$ref_hash);
						$cloned->[$i] = clone($var);
						$i++;
						#$sign++;
						if ((!(defined $cloned->[$i]))  and (defined $orig->[$i]) ) {
						#	print "test\n";
							return (undef $cloned);
						}
					}
				}
			}
			elsif( ref($orig) eq "CODE") {
				#$ref_hash->{sign} = 1;
				#print "sign= $sign\n"; 
				return (undef $cloned);	
			}
		}
	#p $orig;
	#p $ref_hash;
=for comment
	if (wantarray) {
		return $cloned, $sign;
	}
	eleif (defined wantarray){
		return $cloned;
	}
=cut
p $cloned;
return $cloned;

}
1;

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
	my $cloned;
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
						if ( !defined $cloned->{$var}  and  defined $orig->{$var} ) {
							undef $cloned;
							return  $cloned;
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
						$cloned->[$i] = clone($var);
						if ( !defined $cloned->[$i]   and defined $orig->[$i]  ) {	
							undef $cloned;
							return  $cloned;
						
						}
						$i++;
					}
				}
			}
			elsif( ref($orig) eq "CODE") {
				undef $cloned; 
				return  $cloned;	
			}
		}
=for comment
	if (wantarray) {
		return $cloned, $sign;
	}
	eleif (defined wantarray){
		return $cloned;
	}
=cut
#p $cloned;
return $cloned;

}
1;

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

sub clone {
	my $orig = shift;
	#p $orig;
	my $cloned;
	
	sub reccur {
		my ($source) = shift;
		my $result;
		my $sign = 0;
		if ( !ref($source)) {
			$result = $source;
		}	
		else {
			if (ref($source) eq "HASH") {
					$result = {%{$source}}; 
					for my $var (keys %{$result}) {
						if (exists $source->{$var} and $source->{$var} ne $source) {
							my @arr = reccur($result->{$var});
                                                        if ($arr[1] == 1) { $sign = 1}
							$result->{$var} = $arr[0];
						}
						else {
							$result->{$var} = $result;
						}
					}
				}
			elsif( ref($source) eq "ARRAY") {
					$result = [@{$source}];
					my $i = 0;
					for my $var (@{$result}) {
						if ($source->[$i] ne $source) {
							my @arr = reccur($var);
							if ($arr[1] == 1) { $sign = 1}
							$result->[$i] = $arr[0];
							$i++;
						}
						else {
							$result->[$i] = $result;
						}
					}
				}
			elsif( ref($source) eq "CODE") {
					$sign = 1;
					undef $result;
					
				}
						
		}
		return $result, $sign;
	}
	
	my @arr = reccur($orig);	
	if ($arr[1] == 0) {$cloned = $arr[0]}
	#p $cloned;
	return $cloned;
}

#clone;

1;

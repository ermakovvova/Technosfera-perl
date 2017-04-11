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
	my $ref_hash = {};
	
	sub reccur {
		my $source = shift;
		my $ref_hash = shift;
		my $result;
		my $sign = 0;
		
		if ( !ref($source)) {
			$result = $source;
		}	
		else {
			if (ref($source) eq "HASH") {
				$result = {%{$source}};
				$ref_hash -> { $source } = $result; 
				for my $var (keys %{$result}) {
					if (my @temp = grep{$_ eq $source->{$var}} keys %$ref_hash) {
						#$| = 1;	
						#print "$temp[0]\n";
						$result->{$var} = $ref_hash -> {$temp[0]};
					}
					else {	
						my @arr = reccur($result->{$var},$ref_hash);
                                                       if ($arr[1] == 1) { $sign = 1}
			 					$result->{$var} = $arr[0];
					}
				}
			}
			elsif( ref($source) eq "ARRAY") {
				$result = [@{$source}];
				$ref_hash -> {$source}  = $result;
				my $i = 0;
				for my $var (@{$result}) {
					if (my @temp = grep{$_ eq $source->[$i]} keys %$ref_hash) {
						$result->[$i] = $ref_hash -> {$temp[0]};
						#print "$temp[0]\n";
					}
					else {
						my @arr = reccur($var,$ref_hash);
						if ($arr[1] == 1) { 
							$sign = 1
						}
						$result->[$i] = $arr[0];
						$i++;
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
	
	my @arr = reccur($orig, $ref_hash);	
	if ($arr[1] == 0) {$cloned = $arr[0]}
	#p $cloned;
	return $cloned;
}

#clone;

1;

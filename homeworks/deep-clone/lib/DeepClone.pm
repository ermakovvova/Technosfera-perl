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
	#my $num = 10;
	#my $orig = \$num;
=for comment	
	my $orig = {
		key1 => "string",
		key2 => [2, 4, 'a'],
		key3 => {
			nested => "value",
			"key\0" => [1, 2]
		}
	};
=cut
	my @source;
	my @result;
	my @ref;
	my $i = 0;
	$source[$i] = $orig;
	my $cloned;
	
	if ( !ref($source[$i])) {
		$cloned = $source[$i];
	}	
	else {
		given (ref($source[$i])) {

			when ("HASH") {
				$ref [$i] = {%{$source [$i]}}; 
				foreach (keys %{$source [$i]}) {
					
				}
			}

			when("ARRAY") {$ref [$i]  = [@{$source [$i]}] }
		}
		$cloned = $ref [0];
	}
	#p %$cloned;
	return $cloned;
}
#clone;

1;

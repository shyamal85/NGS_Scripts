if (scalar(@ARGV) != 2)
	{
	print "\n\nUSAGE\: perl Extarcte_sequences.pl \[list of geneNames\] \[source of fasta sequences\]\n\n";
	exit;
	}
open (FILE1, "$ARGV[1]") or die "\n\nCannot find file $ARGV[1]\n\n" ;
while ($line = <FILE1>)
	{
	chomp $line;
	if ($line =~ /\>/)
		{
		$line =~ />.* \((.*)\).*/;
		$gene = uc($1);
		$myHash{$gene} = "$line\n";
#		print "$gene\n";
		next;
		}
	$myHash{$gene} .= "$line\n";
	}
close (FILE1);

open (OUT, ">Extracted_sequences.fna");

open (FILE2, "$ARGV[0]") or die "\n\nCannot find file $ARGV[0]\n\n" ;
while ($line = <FILE2>)
	{
	chomp $line;
	$line = uc($line);
	if (exists($myHash{$line}))
		{
		print OUT $myHash{$line};
		}
	else
		{
		print "$line\tNot Found\n";
		}
	}

print "\nSequence are in file Extracted_sequences\.fna\n\n";
close (FILE2);
close (OUT);
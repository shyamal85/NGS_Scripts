# This script takes a protein names from a provided list and search for each enzyme 
# in a 
if (scalar(@ARGV) != 4)
	{
	print "\n\nUSAGE\: perl Extarcte_sequences.pl \[list of geneNames\] \[source of fasta sequences\] \[output filename\] \[Percent word match\]\n\n";
	exit;
	}
open (FILE1, "$ARGV[1]") or die "\n\nCannot find file $ARGV[1]\n\n" ;
while ($line = <FILE1>)
	{
	chomp $line;
	if ($line =~ /\>/)
		{
		$seqNumber++;
		$line =~s /PREDICTED\:\s+Peromyscus maniculatus bairdii\s+//gi;
		$line =~s /Peromyscus maniculatus bairdii//g;
		$line =~s /\(.*\)\, transcript variant.*//g;
		$line =~s /\(.*\)//g;
		$line =~s /\[.*\]//g;
		($c1, $namePart) = split (/\s+/, $line, 2);
		
		push @ALL_HEADERS, "$namePart\t$seqNumber";
		$myHash{$seqNumber} = "$line\t$seqNumber\n";
		next;
		}
	$myHash{$seqNumber} .= "$line\n";
	}
close (FILE1);

$out = "$ARGV[2]";
open (OUT, ">$out");

open (FILE2, "$ARGV[0]") or die "\n\nCannot find file $ARGV[0]\n\n" ;
L0:while ($line = <FILE2>)
	{
	$matchNumber = 0;
	chomp $line;
	$line =~s /^\s+//g;
	$line =~s /\,//g;
	$line =~s /\(.*\)//g;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L0;
				}
			}
		}
	push @temp, $line;
	}
close (FILE2);


######################### Iteration 2 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration2, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration2);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print  "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L1:foreach $line (@NotFound_iteration2)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L1;
				}
			}
		}
	push @temp, $line;
	}


######################### Iteration 3 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration3, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration3);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L2:foreach $line (@NotFound_iteration3)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L2;
				}
			}
		}
	push @temp, $line;
	}

######################### Iteration 4 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration4, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration4);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L3:foreach $line (@NotFound_iteration4)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L3;
				}
			}
		}
	push @temp, $line;
	}


######################### Iteration 5 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration5, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration5);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L4:foreach $line (@NotFound_iteration5)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L4;
				}
			}
		}
	push @temp, $line;
	}


######################### Iteration 6 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration6, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration6);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L5:foreach $line (@NotFound_iteration5)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L5;
				}
			}
		}
	push @temp, $line;
	}


######################### Iteration 7 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration7, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration7);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L6:foreach $line (@NotFound_iteration7)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L6;
				}
			}
		}
	push @temp, $line;
	}

######################### Iteration 8 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration8, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration8);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L7:foreach $line (@NotFound_iteration8)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L7;
				}
			}
		}
	push @temp, $line;
	}

######################### Iteration 9 ###############################
@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NotFound_iteration9, $item;
	$oldItem = $item;
	}
@temp = ();
$s = scalar(@NotFound_iteration9);
print "Array size\= $s\n";

$ARGV[3] = $ARGV[3] - 10;
print OUT "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
print "\-\-\-\-\-\-\- matches \@ $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";
`say matches at $ARGV[3] percent stringency`;
L8:foreach $line (@NotFound_iteration9)
	{
	$matchNumber = 0;
	@ALL = split (/\s+/, $line);
	$x = scalar(@ALL);
	foreach $element (@ALL_HEADERS)
		{
		($header, $seqNumber) = split (/\t/, $element, 2);
		$matchNumber = 0;
		foreach $item (@ALL)
			{
			if ($header =~ /$item/i)
				{
				$matchNumber++;
				}
			$percentMatch = $matchNumber * 100 /$x;
			if ($percentMatch >=$ARGV[3])
				{
				print OUT "$line\t$header\t$percentMatch\n";
				next L8;
				}
			}
		}
	push @temp, $line;
	}


print OUT "\-\-\-\-\-\-\- NOT FOUND below $ARGV[3]\% stringency -\-\-\-\-\-\-\-\-\-\n";

@temp2 = sort(@temp);
foreach $item (@temp2)
	{
	next if ($oldItem eq $item);
	push @NOTfound, $item;
	$oldItem = $item;
	}
@temp = ();


foreach $line (@NOTfound)
	{
	print OUT "$line\n";
	}

print "\nSequence are in file $out\n\n";
close (OUT);
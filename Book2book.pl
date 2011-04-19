#!/usr/bin/perl
use Cwd;

print "**   rename Book.xml/Question.xml names to lower case   **\n";

if(defined($ARGV[0])){
	$curdir = $ARGV[0];
}
else{
	$curdir = getcwd;
}
print "rename books in $curdir directory\n";
opendir(CURDIR, $curdir) or die "Cannot read directory $curdir\n";
@books = grep {/Book/ig} readdir CURDIR;
#print @books;
foreach(@books){
	&folderRename($_);
	&bookRename($curdir."/".$_);
};
close(CURDIR);

sub bookRename{
	my $bookDir = $_[0];
	print "rename in directory: $_[0]\n";
	opendir(BOOKDIR, $bookDir) or die "Cannot read book directory $bookDir\n";
	@bookFiles = grep {/Book.xml|Questions.xml/ig} readdir BOOKDIR;
	foreach(@bookFiles){
		my $oldFile = "$bookDir/$_";
		my $newFile = "$bookDir/".lc;
		print "old file: $oldFile\n";
		print "new file: $newFile\n";
		rename($oldFile,$newFile);
	}
	close(BOOKDIR);
}

sub folderRename{
	my $dir = $_[0];
	if($dir =~ /([a-zA-Z]+)(\d+)$/){
		rename("$curdir$dir", $curdir."/Book".$2);
	}
}



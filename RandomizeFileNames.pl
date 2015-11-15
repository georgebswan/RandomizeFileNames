#! \strawberry\perl\bin\perl
    eval 'exec perl $0 ${1+"$@"}'
	if 0;
 
#------------------------------------------------------------------------------
#Script to rename files with a random number if extension matches
#Updated: uses a different comparison: now checks for exact match
# ignoring case
#Updated: outputs a file for undo feature
#------------------------------------------------------------------------------
 
## Define Variable ##
@files = <*>;
 
#Array variable to hold extensions you may check
@extensionArray = ("jpg", "zip", "tif");
 
#Variable for the largest value of the random #
$randNumCeiling = 100000;
 
#Simple file counter to keep track of # of files processed
$numFilesRenamed = 0;
 
#Open a file for writing undo info
open(UNDOFILE, '>_undo_')or die "$!";;
 
#------------------------------------------------------------------------------
##Loop through all files in the directory
#------------------------------------------------------------------------------
#If it is a file, get the extension
#Checks if the extension is equal to wanted extension(s)
#...If match, generate random number for filename and rename it
#------------------------------------------------------------------------------
foreach $file (@files)
{
    if (-f $file) {
        # find and ignore all characters that is not a dot, then get the rest
        my $ext = ($file =~ m/([^.]+)$/)[0];
 
        if(extensionMatch($ext) ) {
            $numFilesRenamed++;
            print "($numFilesRenamed)\n";
            #Old file name
            print UNDOFILE "$file:";
            print "Old file name: $file\n";
            my $newName = int(rand($randNumCeiling));
            rename($file, "$newName.$ext");
            #New file name
            print "New file name: $newName.$ext\n\n";
            print UNDOFILE "$newName.$ext\n";
        }
    }
}
close UNDOFILE;
 
#------------------------------------------------------------------------------
## Function to check extension ##
#------------------------------------------------------------------------------
#Loop through extention array (defined a the top)...
#...to check for match with the argment passed into
#...the function (which is the extension of the file
#...currently being processed
#------------------------------------------------------------------------------
#Returns a 1 if extensions match
#...else returns 0
#------------------------------------------------------------------------------
sub extensionMatch
{
    $passedInExt = @_[0];
    foreach $extension (@extensionArray){
        #check for exact string ignoring case
        if($extension =~ m/^$passedInExt$/i){
            return 1;
        }
    }
    return 0;
}


 



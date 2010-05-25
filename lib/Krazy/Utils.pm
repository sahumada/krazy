###############################################################################
# Sanity checks for your KDE source code                                      #
# Copyright 2007-2010 by Allen Winter <winter@kde.org>                        #
#                                                                             #
# This program is free software; you can redistribute it and/or modify        #
# it under the terms of the GNU General Public License as published by        #
# the Free Software Foundation; either version 2 of the License, or           #
# (at your option) any later version.                                         #
#                                                                             #
# This program is distributed in the hope that it will be useful,             #
# but WITHOUT ANY WARRANTY; without even the implied warranty of              #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the                #
# GNU General Public License for more details.                                #
#                                                                             #
# You should have received a copy of the GNU General Public License along     #
# with this program; if not, write to the Free Software Foundation, Inc.,     #
# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.               #
#                                                                             #
###############################################################################

package Krazy::Utils;

use strict;
use vars qw(@ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $VERSION);
use Cwd;
use Cwd 'abs_path';
use POSIX qw (setlocale strftime LC_TIME);
use File::Find;
use Getopt::Long;

use Exporter;
$VERSION = 1.13;
@ISA = qw(Exporter);

@EXPORT = qw(topComponent topModule topProject tweakPath Exit
             fileType fileTypeDesc findFiles asOf deDupe addRegEx
             addCommaSeparated commaSeparatedToArray arrayToCommaSeparated
             parseArgs helpArg versionArg priorityArg strictArg
             explainArg quietArg verboseArg installedArg
             validateExportType validatePriorityType validateStrictType validateOutputType);
@EXPORT_OK = qw();

my(@tmp);
my($CompRegex) = "trunk/(KDE|extragear|kdereview|kdesupport|koffice)|branches/KDE";
my($ModRegex) = "(kde(libs|pimlibs|base|base-apps|base-runtime|base-workspace|accessibility|addons|admin|artwork|bindings|edu|games|graphics|multimedia|network|pim|plasma-addons|sdk|toys|utils|webdev|office|security|sysadmin|review|support|koffice))";

#the path might be regularly used symlinks, so undo that
sub tweakPath {
  my($in) = @_;
  if (defined($in)) {
    $in =~ s+/kdebase/apps/+/kdebase-apps/+;
    $in =~ s+/kdebase/runtime/+/kdebase-runtime/+;
    $in =~ s+/kdebase/workspace/+/kdebase-workspace/+;
    return "$in";
  } else {
    return "";
  }
}

#full path to the top of the component where the specified file resides
sub topComponent {
  my($in) = @_;
  my($apath) = tweakPath(abs_path($in));
  my($bot) = $apath;
  $bot =~ s+.*/$CompRegex/++;
  return "" if ($bot eq $apath);  #not a component path
  return $apath if (!$bot);
  $apath =~ s+$bot++;
  return $apath;
}

#full path to the top of the module where the specified file resides
sub topModule {
  my($in) = @_;
  my($apath) = tweakPath(abs_path($in));
  my($cpath) = topComponent($in);
  return "" if (!$cpath);

  my($mpath) = $apath;
  $mpath =~ s+$cpath++;
  $mpath =~ s+^/++;
  $mpath =~ s+/.*++;
  return "" if (!$mpath);
  return "$cpath/$mpath";
}

#full path to the top of the project dir where the specified file resides
sub topProject {
  my($in) = @_;
  my($apath) = tweakPath(abs_path($in));
  my($mpath) = topModule($in);
  return "" if (!$mpath);

  my($ppath) = $apath;
  $ppath =~ s+$mpath++;
  $ppath =~  s+^/++;
  $ppath =~ s+/.*++;
  return "" if (!$ppath);
  return "$mpath/$ppath";
}

# Exit a checker with the number of issues
sub Exit {
  my($issues)=@_;
  if($issues > 0) {
    print "ISSUES=$issues\n";
  }
  exit $issues;
}

# remove duplicate entries from a list
sub deDupe {
  my (@list) = @_;
  my (%seen) = ();
  my ( @uniq, $item );
  foreach $item (@list) {
    push( @uniq, $item ) unless $seen{$item}++;
  }
  return @uniq;
}

sub addRegEx {
  my ($r1,$r2) = @_;

  if ($r1) {
    if ($r2) {
      $r1 .= "\\|" . $r2;
    }
  } else {
    $r1 = $r2;
  }
  return $r1;
}

sub addCommaSeparated {
  my ($l1,$l2) = @_;

  $l1 =~ s/\s*//g; $l2 =~ s/\s*//g; # remove whitespace
  $l1 =~ s/^,+//;  $l2 =~ s/^,+//;  # remove leading commas
  $l1 =~ s/,+$//;  $l2 =~ s/,+$//;  # remove trailing commas

  if ($l1) {
    if ($l2) {
      $l1 .= "," . $l2;
    }
  } else {
    $l1 = $l2;
  }
  return &arrayToCommaSeparated(&deDupe(&commaSeparatedToArray($l1)));
}

sub commaSeparatedToArray {
  my ($l) = @_;
  my (@a) = ();

  $l =~ s/\s*//g; # remove whitespace
  $l =~ s/^,+//;  # remove leading commas
  $l =~ s/,+$//;  # remove trailing commas
  @a = split( ",", $l );
  return @a;
}

sub arrayToCommaSeparated {
  my (@a) = @_;
  my ($l) = "";
  my ($guy);
  for $guy (@a) {
    $l .= $guy . ",";
  }
  $l =~ s/,$//;
  return $l;
}

# return a file type string determined by the filename extension
# returns an empty string if an unsupported file type is encountered.
sub fileType {
  my ($f) = @_;

  if ( $f =~ m/\.(?:cpp|cc|cxx|c|C|tcc|h|hxx|hpp|H\+\+)$/ ) {
    return "c++";
  } elsif ( $f =~ m/\.desktop$/ ) {
    return "desktop";
  } elsif ( $f =~ m/\.ui$/ ) {
    return "designer";
  } elsif ( $f =~ m/\.kcfg$/ ) {
    return "kconfigxt";
  } elsif ( $f =~ m/\.po$/ ) {
    return "po";
  } elsif ( $f =~ m/Messages\.sh$/ ) {
    return "messages";
  } elsif ( $f =~ m/\.rc$/ ) {
    return "kpartgui";
  } elsif ( $f =~ m/tips$/ ) {
    return "tips";
  } elsif ( $f =~ m/\.qml$/ ) {
    return "qml";
  }
  return "";
}

sub fileTypeDesc {
  my ($t) = @_;

  if ( $t eq "c++" ) {
    return "C/C++ source code";
  } elsif ( $t eq "desktop" ) {
    return "Freedesktop.org desktop files";
  } elsif ( $t eq "designer" ) {
    return "Qt Designer files";
  } elsif ( $t eq "kconfigxt" ) {
    return "KConfigXT XML files";
  } elsif ( $t eq "po" ) {
    return "GNU gettext files";
  } elsif ( $t eq "messages" ) {
    return "Messages.sh files";
  } elsif ( $t eq "kpartgui" ) {
    return "KPartGUI files";
  } elsif ( $t eq "tips" ) {
    return "Tips files";
  } elsif ( $t eq "qml") {
    return "Qt Declarative UI files";
  }
  return "";
}

# return a string containing all the supported files found in specified dirs
# the files are newline-separated.
sub findFiles {
  my (@dirs) = @_;
  push(@dirs, getcwd) if ($#dirs<0);

  @tmp = ();
  find( \&aok, @dirs );

  sub aok {
    -f && !-d && push( @tmp, $File::Find::name );
  }
  my ($i,$l);
  $l="";
  foreach $i (@tmp) {
    $l = "$l" . "$i\n" if (&fileType($i));
  }
  return $l;
}

# asOf function: return nicely formatted string containing the current time
sub asOf {
  my $locale = setlocale( LC_TIME );
  setlocale( LC_TIME, "C" );
  my $time = strftime( "%B %d %Y %H:%M:%S %Z", localtime( time() ) );
  setlocale( LC_TIME, $locale );
  return $time;
}

my($krazy) = '';
my($help) = '';
my($version) = '';
my($priority) = 'all';
my($strict) = 'all';
my($explain) = '';
my($installed) = '';
my($quiet) = '';
my($verbose) = '';

sub parseArgs {

  exit 1
  if (!GetOptions('krazy' => \$krazy, 'help' => \$help, 'version' => \$version,
		  'priority=s' => \$priority, 'strict=s' => \$strict,
		  'explain' => \$explain, 'installed' => \$installed,
		  'verbose' => \$verbose, 'quiet' => \$quiet));

  if (!$help && !$version && !$explain) {
    if (!$krazy) {
      die "Checker not called as part of Krazy... exiting\n";
    }
  }

  if (!&validatePriorityType($priority)) {
    die "Bad priority level \"$priority\" specified... exiting\n";
  }

  if (!&validateStrictType($strict)) {
    die "Bad strictness level \"$strict\" specified... exiting\n";
  }
}

sub helpArg { return $help; }
sub versionArg { return $version; }
sub priorityArg { return $priority; }
sub strictArg { return $strict; }
sub explainArg { return $explain; }
sub installedArg { return $installed; }
sub quietArg { return $quiet; }
sub verboseArg { return $verbose; }

sub validateExportType {
  my ($export) = @_;
  if ($export) {
    $export = lc($export);
    if ( ( $export eq "text" ) ||
         ( $export eq "textlist" ) ||
         ( $export eq "textedit" ) ||
         ( $export eq "xml" ) ) {
      return 1;
    }
  }
  return 0;
}

sub validatePriorityType {
  my ($priority) = @_;
  if ($priority) {
    $priority = lc($priority);
    if ( ( $priority eq "all" ) ||        # low+normal+high
	 ( $priority eq "low" ) ||        # low only
	 ( $priority eq "normal" ) ||     # normal only
	 ( $priority eq "important" ) ||  # low+normal
	 ( $priority eq "high" ) ) {      # high only
      return 1;
    }
  }
  return 0;
}

sub validateStrictType {
  my ($strict) = @_;
  if ($strict) {
    $strict = lc($strict);
    if ( ( $strict eq "all" ) ||          # super+normal
	 ( $strict eq "super" ) ||        # super only
	 ( $strict eq "normal" ) ) {      # normal only
      return 1;
    }
  }
  return 0;
}

sub validateOutputType { #output type doesn't consider verbosity (except in the 'quiet' case)
  my ($output) = @_;
  if ($output) {
    $output = lc($output);
    if ( ( $output eq "normal" ) ||       # standard stuff (default)
	 ( $output eq "brief" ) ||        # only checks with issues
	 ( $output eq "quiet" ) ) {       # no output, even if verbosity turned-on
      return 1;
    }
  }
  return 0;
}

1;

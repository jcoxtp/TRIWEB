# jmail.pls

# $WScript object always defined when running under the scripting host..
$msg = $WScript->CreateObject('JMail.Message');

# Call a member function
$msg->AddRecipient('my@recipient.com');

# Set a few properties
$msg->{From}='test@test.com';
$msg->{FromName}='Mr. Test';
$msg->{Subject}='hi';
$msg->{Body}=<<EOF;
Hello!

Here's the message body.
I'd say it's a rather nice one!

regards
EOF

# Send the message
if($msg->Send('mail.myDomain.com'))
{
	$WScript->Echo("Mail Successfully sent!");
}
else 
{
	$WScript->Echo("Connection Failed ...");
}

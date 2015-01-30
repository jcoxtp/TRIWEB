/*
*************************************************
*                                               *
*   Produced by Dimac                           *
*                                               *
*   More examples can be found at               *
*   http://tech.dimac.net                       *
*                                               *
*   Support is available at our helpdesk        *
*   http://support.dimac.net                    *
*                                               *
*   Our main website is located at              *
*   http://www.dimac.net                        *
*                                               *
*************************************************
*/

// Example of using JMail from C++ using ATL.
// The JMail.tlb file is required for this example.
	#include "stdafx.h"
	#include <iostream.h>
	#import "..\..\jmail.dll" // The path to the jmail.dll file here!



// The strings later used as parameters to JMail
// And of course they should be edited before building this project.

	const char *sender				= "me@mydomain.com";                     // Edit this!!
	const char *recipient			= "recipient@hisdomain.com";             // Edit this!!
	const char *subject				= "Hello JMail!";
	const char *body				= "This message was sent with JMail version 4.0\n"
									   "using the JMailCppEx example!\n";
	const char *mailserver		= "mymailserver.mydomain.com";               // Edit this!!



	int main(int argc, char* *argv)
	{

		CoInitialize(NULL);

		{
			try
			{
				// jmail::ISpeedMailerPtr is generated and declared by the #import directive.

				jmail::ISpeedMailerPtr spJMail("JMail.SpeedMailer");
				// Ok, send the mail.
				spJMail->SendMail( sender, recipient, subject, body, mailserver );

			}
			catch( _com_error & E)
			{
				cerr
					<< "Error: 0x" << hex << E.Error() << endl
					<< E.ErrorMessage() << endl;

			}

		}

		CoUninitialize();

		return 0;
	}
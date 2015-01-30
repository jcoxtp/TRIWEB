JMAIL 4.3.1
-----------

- Fixed some ASP examples.

- Some minor issues regarding POP3 were fixed.


JMAIL 4.3
---------

JMail.Message

- Various optimazations and performance improvements in the Message object.
  The internal state of the Message object is now more efficiently re-used
  between calls to the Send() method. This should result in a noticable
  increase of speed.

- The initialization code of the Message object has been improved, fixing
  issues with extremely slow initialization of the Message object.

- Two new registry settings has been added:
  (located under HKEY_LOCAL_MACHINE\SOFTWARE\Dimac\w3JMail4)

  "Enque FileExtension"
    The default file ending of queued mails is ".eml".
    It's now possible to override this ending, by specifying another
    one as the value of this registry key.

  "AltQueueFormat"
    When not set, or when set to false, the standard (default) format
    is used.
    The alternative format is used when the value is "true".
    It may get the queue functionality to work on mailservers which
    doesn't support the default format.


JMail.Attachment

-  A new read/write property "BinaryData" has been added to the attachment
   object. It'll return the binary data of the attachment, without any
   translation.


JMail.POP3

- New Method: DownloadSingleMessage( n ); Method was added for clarification
  reasons, this method is equivalent to fetching the mails through the Messages
  collection.

- New property: Timeout; it allows you to change the socket timeout for the
  socket used to connect to the mail server. This value has in previous
  versions defaulted to 120 seconds (and still does).

- Greatly improved performance.


JMail.MailMerge

- Changed to merge only certain parts of a mail. These parts are Subject, From
  Fromname, body, htmlbody, charset, replyto, recipients & attachments (optional).


Misc

- Fixed XML-mailer, so it can have multiple recipients in the To/CC/BCC fields.


JMAIL 4.2.0
-----------

-  Added the property EnableCharsetTranslation in the message object.
   Character set translation can now be disabled so pre-encoded text can be
   assigned to the Body or HTMLBody properties.

-  Some issues regarding the message object state when using mailmerge were
   fixed.

-  Added the method PGPDecode() in the message object, along with new objects
   for querying the results of a decode operation.
   PGP decryption is now fully supported.

-  Some issues that could cause signed mails to fail verifcation or
   generate a PGP -12000 error was fixed and erased from the system.



JMAIL 4.1.4
-----------

Minor release/bugfix release

- ISOEncodeHeaders now works properly when dealing with multipart mails.
  This property will now disable the charset-encoding of headers throughout the
  entire mail.

- Specifying a custom Content-Transfer-Encoding will now always be included
  in the mail headers.
  ( no more "Content-Transfer-Encoding: unknown" in the headers )

- Fixed some issues regarding encoding of headers with custom charsets.

- Fixed and corrected some minor issues with the rendering of multipart MIME
  mails, mostly regarding the support for multipart/related
  ( html mails with inline images )

- Some minor issues regarding POP3 were fixed.

- Special characters are now allowed as field names, in mailmerge.


JMAIL 4.1.0
-----------

 - Mail-header encoding/decoding improved
 - Various bugfixes
 - Support for international charsets



JMAIL 4.0.0
-----------

 - the inner architecture of JMail has been redesigned. E-mails are now sent
   using the Message Object.
 - support for receiving e-mails, using POP3.
 - SMTP authentication is now supported.
 - Queue messages using local mail server such as Microsoft SMTP Server.
 - Mailmerge (Mass mailing functionality).
 - PGP support (requires PGP: http://www.nai.com,http://www.pgp.com/ or
   http://www.pgpi.com/ ).
 - Speedmailer, to send e-mails using just one function
   call.
Note that despite all this, JMail 4 is 100% compatible with the old 3.7 version.

For more information:
See the jmail manual , http://www.dimac.net and http://tech.dimac.net.
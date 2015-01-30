unit jmailTlb;

interface

uses Windows, ActiveX;

const
  // TypeLibrary Major and minor versions
  jmailMajorVersion = 4;
  jmailMinorVersion = 0;

  LIBID_jmail: TGUID = '{AED3A6B0-2171-11D2-B77C-0008C73ACA8F}';

  IID_IPOP3: TGUID = '{607A06FE-2FDA-4ADC-854D-D016D98D83DB}';
  CLASS_POP3: TGUID = '{F812B147-0E26-4222-8EE4-9F753CD2B39C}';
  IID_IMessages: TGUID = '{684130B2-2B8A-4E8D-BE71-8F4052882076}';
  CLASS_Messages: TGUID = '{A62C8BDB-D1FC-4FDD-A2A2-EEFF73262A41}';
  IID_IMessage: TGUID = '{3A037057-57F0-4904-A1E0-AD0EA2FB564E}';
  CLASS_Message: TGUID = '{E5FF9F62-0E7C-4372-8AD5-DA7D2418070C}';
  IID_IHeaders: TGUID = '{CF2ED965-E0BA-4FE4-ADE2-38BD48F112E8}';
  CLASS_Headers: TGUID = '{B1CC9084-0177-4136-9B1B-C06C061F1E1D}';
  IID_IRecipients: TGUID = '{56930358-AD72-408F-83C4-A2B0DC8037B2}';
  CLASS_Recipients: TGUID = '{B10BF17C-F7EC-4EE2-AD7A-6F42816AEC0F}';
  IID_IRecipient: TGUID = '{65C53BE7-ED21-4C25-B189-DA0E8FAD5231}';
  CLASS_Recipient: TGUID = '{DBAAEA4B-AD29-47BD-8776-C787D5BE28AA}';
  IID_IAttachments: TGUID = '{1E6D8684-755D-4847-BF40-68EC5E4BC1E9}';
  CLASS_Attachments: TGUID = '{B3A0ACB9-3D8C-4999-9E6B-3E44372E11DD}';
  IID_IAttachment: TGUID = '{952F0B99-50B6-44B3-AE0D-700D5B98B416}';
  CLASS_Attachment: TGUID = '{53DECA78-C334-4235-9165-1FE7D8912A76}';
  IID_ISMTPMail: TGUID = '{AED3A6B1-2171-11D2-B77C-0008C73ACA8F}';
  CLASS_SMTPMail: TGUID = '{AED3A6B3-2171-11D2-B77C-0008C73ACA8F}';
  IID_IPOP3Mail: TGUID = '{14E61A41-8846-11D2-B7E4-0008C73ACA8F}';
  CLASS_POP3Mail: TGUID = '{14E61A43-8846-11D2-B7E4-0008C73ACA8F}';
  IID_IPGPKeys: TGUID = '{23E86816-772B-4B28-A924-A135CFF6469A}';
  CLASS_PGPKeys: TGUID = '{CEF9EA1F-BBCA-4E19-87A4-2E26C22F1D26}';
  IID_IPGPKeyInfo: TGUID = '{B89D0E7A-0F5B-40EE-8AF3-08FA2ED9534F}';
  CLASS_PGPKeyInfo: TGUID = '{37F2DDBD-5CD9-4CDF-9B30-2A904246C112}';
  IID_IMailMerge: TGUID = '{0C21B3B1-2B11-45F2-8A9E-DCC5032DE98A}';
  CLASS_MailMerge: TGUID = '{0D821067-FCF9-4704-9287-0D8F76FE6513}';
  IID_ISpeedMailer: TGUID = '{821AAFE5-2F19-47EB-ACA9-3B4C1D64AC27}';
  CLASS_SpeedMailer: TGUID = '{90D0A753-AD45-40FD-8C6E-555600EE5EB4}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IPOP3 = interface;
  IPOP3Disp = dispinterface;
  IMessages = interface;
  IMessagesDisp = dispinterface;
  IMessage = interface;
  IMessageDisp = dispinterface;
  IHeaders = interface;
  IHeadersDisp = dispinterface;
  IRecipients = interface;
  IRecipientsDisp = dispinterface;
  IRecipient = interface;
  IRecipientDisp = dispinterface;
  IAttachments = interface;
  IAttachmentsDisp = dispinterface;
  IAttachment = interface;
  IAttachmentDisp = dispinterface;
  ISMTPMail = interface;
  ISMTPMailDisp = dispinterface;
  IPOP3Mail = interface;
  IPOP3MailDisp = dispinterface;
  IPGPKeys = interface;
  IPGPKeysDisp = dispinterface;
  IPGPKeyInfo = interface;
  IPGPKeyInfoDisp = dispinterface;
  IMailMerge = interface;
  IMailMergeDisp = dispinterface;
  ISpeedMailer = interface;
  ISpeedMailerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  POP3 = IPOP3;
  Messages = IMessages;
  Message = IMessage;
  Headers = IHeaders;
  Recipients = IRecipients;
  Recipient = IRecipient;
  Attachments = IAttachments;
  Attachment = IAttachment;
  SMTPMail = ISMTPMail;
  POP3Mail = IPOP3Mail;
  PGPKeys = IPGPKeys;
  PGPKeyInfo = IPGPKeyInfo;
  MailMerge = IMailMerge;
  SpeedMailer = ISpeedMailer;


// *********************************************************************//
// Interface: IPOP3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {607A06FE-2FDA-4ADC-854D-D016D98D83DB}
// *********************************************************************//
  IPOP3 = interface(IDispatch)
    ['{607A06FE-2FDA-4ADC-854D-D016D98D83DB}']
    procedure Connect(const Username: WideString; const Password: WideString;
                      const Server: WideString; Port: Integer); safecall;
    procedure Disconnect; safecall;
    function  Get_Log: WideString; safecall;
    function  Get_Logging: WordBool; safecall;
    procedure Set_Logging(Log: WordBool); safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Size: Integer; safecall;
    function  Get_Messages: IMessages; safecall;
    function  GetLastUnreadMessage: Integer; safecall;
    procedure DownloadSingleHeader(MessageID: Integer); safecall;
    procedure DeleteSingleMessage(MessageID: Integer); safecall;
    procedure DownloadHeaders; safecall;
    procedure DownloadMessages; safecall;
    function  GetMessageUID(MessageID: Integer): WideString; safecall;
    procedure DeleteMessages; safecall;
    procedure DownloadUnreadMessages; safecall;
    property Log: WideString read Get_Log;
    property Logging: WordBool read Get_Logging write Set_Logging;
    property Count: Integer read Get_Count;
    property Size: Integer read Get_Size;
    property Messages: IMessages read Get_Messages;
  end;

// *********************************************************************//
// DispIntf:  IPOP3Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {607A06FE-2FDA-4ADC-854D-D016D98D83DB}
// *********************************************************************//
  IPOP3Disp = dispinterface
    ['{607A06FE-2FDA-4ADC-854D-D016D98D83DB}']
    procedure Connect(const Username: WideString; const Password: WideString; 
                      const Server: WideString; Port: Integer); dispid 6;
    procedure Disconnect; dispid 7;
    property Log: WideString readonly dispid 8;
    property Logging: WordBool dispid 9;
    property Count: Integer readonly dispid 1;
    property Size: Integer readonly dispid 2;
    property Messages: IMessages readonly dispid 3;
    function  GetLastUnreadMessage: Integer; dispid 4;
    procedure DownloadSingleHeader(MessageID: Integer); dispid 5;
    procedure DeleteSingleMessage(MessageID: Integer); dispid 10;
    procedure DownloadHeaders; dispid 11;
    procedure DownloadMessages; dispid 12;
    function  GetMessageUID(MessageID: Integer): WideString; dispid 13;
    procedure DeleteMessages; dispid 14;
    procedure DownloadUnreadMessages; dispid 15;
  end;

// *********************************************************************//
// Interface: IMessages
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {684130B2-2B8A-4E8D-BE71-8F4052882076}
// *********************************************************************//
  IMessages = interface(IDispatch)
    ['{684130B2-2B8A-4E8D-BE71-8F4052882076}']
    function  Get_Count: Integer; safecall;
    procedure Clear; safecall;
    function  Get_Item(Index: Integer): IMessage; safecall;
    procedure Set_Item(Index: Integer; const Value: IMessage); safecall;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: IMessage read Get_Item write Set_Item;
  end;

// *********************************************************************//
// DispIntf:  IMessagesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {684130B2-2B8A-4E8D-BE71-8F4052882076}
// *********************************************************************//
  IMessagesDisp = dispinterface
    ['{684130B2-2B8A-4E8D-BE71-8F4052882076}']
    property Count: Integer readonly dispid 1;
    procedure Clear; dispid 3;
    property Item[Index: Integer]: IMessage dispid 2;
  end;

// *********************************************************************//
// Interface: IMessage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3A037057-57F0-4904-A1E0-AD0EA2FB564E}
// *********************************************************************//
  IMessage = interface(IDispatch)
    ['{3A037057-57F0-4904-A1E0-AD0EA2FB564E}']
    function  Get_Date: TDateTime; safecall;
    function  Get_Size: Integer; safecall;
    function  Get_MessageOrder: WideString; safecall;
    procedure Set_MessageOrder(const Value: WideString); safecall;
    procedure LoadFromStream(const Stream: IUnknown); safecall;
    procedure SaveToStream(const Stream: IUnknown); safecall;
    procedure ParseMessage(const MessageSource: WideString); safecall;
    function  Get_Text: WideString; safecall;
    function  Get_Headers: IHeaders; safecall;
    function  Get_Recipients: IRecipients; safecall;
    function  Get_Attachments: IAttachments; safecall;
    function  Get_Subject: WideString; safecall;
    procedure Set_Subject(const Value: WideString); safecall;
    function  Get_From: WideString; safecall;
    procedure Set_From(const Value: WideString); safecall;
    function  Get_FromName: WideString; safecall;
    procedure Set_FromName(const Value: WideString); safecall;
    function  Get_Body: WideString; safecall;
    procedure Set_Body(const Value: WideString); safecall;
    function  Get_Priority: Byte; safecall;
    procedure Set_Priority(Value: Byte); safecall;
    function  Get_ContentType: WideString; safecall;
    procedure Set_ContentType(const Value: WideString); safecall;
    procedure Send(const mailServer: WideString; enque: WordBool); safecall;
    function  Get_BodyText: WideString; safecall;
    function  DecodeHeader(const Header: WideString): WideString; safecall;
    procedure SendToNewsGroup(const ServerName: WideString; const Newsgroups: WideString); safecall;
    function  Get_Envelope: IUnknown; safecall;
    procedure Set_Envelope(const Value: IUnknown); safecall;
    function  Get_MsPickupdirectory: WideString; safecall;
    procedure Set_MsPickupdirectory(const Value: WideString); safecall;
    procedure nq; safecall;
    function  KeyInformation(const keyIdentifier: WideString): IPGPKeys; safecall;
    function  Get_PGPEncrypt: WordBool; safecall;
    procedure Set_PGPEncrypt(Value: WordBool); safecall;
    function  Get_PGPSign: WordBool; safecall;
    procedure Set_PGPSign(Value: WordBool); safecall;
    function  Get_PGPPassphrase: WideString; safecall;
    procedure Set_PGPPassphrase(const passPhrase: WideString); safecall;
    function  Get_PGPSignkey: WideString; safecall;
    procedure Set_PGPSignkey(const signKey: WideString); safecall;
    function  Get_ReplyTo: WideString; safecall;
    procedure Set_ReplyTo(const Value: WideString); safecall;
    function  Get_HideRecipients: WideString; safecall;
    procedure Set_HideRecipients(const Value: WideString); safecall;
    function  Get_MailDomain: WideString; safecall;
    procedure Set_MailDomain(const Value: WideString); safecall;
    function  Get_Charset: WideString; safecall;
    procedure Set_Charset(const Value: WideString); safecall;
    function  Get_ContentTransferEncoding: WideString; safecall;
    procedure Set_ContentTransferEncoding(const Value: WideString); safecall;
    function  Get_MimeVersion: WideString; safecall;
    procedure Set_MimeVersion(const Value: WideString); safecall;
    function  Get_Encoding: WideString; safecall;
    procedure Set_Encoding(const Value: WideString); safecall;
    function  Get_ReturnReceipt: WordBool; safecall;
    procedure Set_ReturnReceipt(Value: WordBool); safecall;
    procedure LogCustomMessage(const Message: WideString); safecall;
    function  Get_Log: WideString; safecall;
    function  Get_Logging: WordBool; safecall;
    procedure Set_Logging(Value: WordBool); safecall;
    function  Get_HTMLBody: WideString; safecall;
    procedure Set_HTMLBody(const Value: WideString); safecall;
    procedure Close; safecall;
    function  Get_ISOEncodeHeaders: WordBool; safecall;
    procedure Set_ISOEncodeHeaders(Value: WordBool); safecall;
    procedure ClearCustomHeaders; safecall;
    function  Get_UsePipelining: WordBool; safecall;
    procedure Set_UsePipelining(Value: WordBool); safecall;
    function  Get_Silent: WordBool; safecall;
    procedure Set_Silent(Value: WordBool); safecall;
    function  Get_ErrorCode: Integer; safecall;
    function  Get_ErrorMessage: WideString; safecall;
    function  Get_ErrorSource: WideString; safecall;
    function  Get_SimpleLayout: WordBool; safecall;
    procedure Set_SimpleLayout(Value: WordBool); safecall;
    procedure GetMessageBodyFromURL(const bstrURL: WideString; const bstrAuth: WideString); safecall;
    function  AddURLAttachment(const bstrURL: WideString; const bstrAttachAs: WideString; 
                               const bstrAuth: WideString): WideString; safecall;
    procedure ExtractEmailAddressesFromURL(const bstrURL: WideString; const bstrAuth: WideString); safecall;
    function  Get_RecipientsString: WideString; safecall;
    function  Get_DeferredDelivery: TDateTime; safecall;
    procedure Set_DeferredDelivery(Value: TDateTime); safecall;
    function  Get_MailData: WideString; safecall;
    function  Get_About: WideString; safecall;
    procedure AddRecipient(const emailAddress: WideString; const recipientName: WideString; 
                           const PGPKey: WideString); safecall;
    procedure AddRecipientCC(const emailAddress: WideString; const recipientName: WideString; 
                             const PGPKey: WideString); safecall;
    procedure AddRecipientBCC(const emailAddress: WideString; const PGPKey: WideString); safecall;
    function  Get_Version: WideString; safecall;
    function  VerifyKeys(const keyString: WideString): WordBool; safecall;
    procedure ClearRecipients; safecall;
    procedure ClearAttachments; safecall;
    procedure AppendBodyFromFile(const FileName: WideString); safecall;
    procedure AppendText(const Text: WideString); safecall;
    function  AddAttachment(const FileName: WideString; const ContentType: WideString): WideString; safecall;
    function  AddCustomAttachment(const FileName: WideString; const Data: WideString): WideString; safecall;
    procedure AddHeader(const XHeader: WideString; const Value: WideString); safecall;
    procedure AddNativeHeader(const Header: WideString; const Value: WideString); safecall;
    function  Get_EncryptAttachments: WordBool; safecall;
    procedure Set_EncryptAttachments(Value: WordBool); safecall;
    function  Get_MailServerUserName: WideString; safecall;
    procedure Set_MailServerUserName(const Value: WideString); safecall;
    function  Get_MailServerPassWord: WideString; safecall;
    procedure Set_MailServerPassWord(const Value: WideString); safecall;
    procedure Clear; safecall;
    property Date: TDateTime read Get_Date;
    property Size: Integer read Get_Size;
    property MessageOrder: WideString read Get_MessageOrder write Set_MessageOrder;
    property Text: WideString read Get_Text;
    property Headers: IHeaders read Get_Headers;
    property Recipients: IRecipients read Get_Recipients;
    property Attachments: IAttachments read Get_Attachments;
    property Subject: WideString read Get_Subject write Set_Subject;
    property From: WideString read Get_From write Set_From;
    property FromName: WideString read Get_FromName write Set_FromName;
    property Body: WideString read Get_Body write Set_Body;
    property Priority: Byte read Get_Priority write Set_Priority;
    property ContentType: WideString read Get_ContentType write Set_ContentType;
    property BodyText: WideString read Get_BodyText;
    property Envelope: IUnknown read Get_Envelope write Set_Envelope;
    property MsPickupdirectory: WideString read Get_MsPickupdirectory write Set_MsPickupdirectory;
    property PGPEncrypt: WordBool read Get_PGPEncrypt write Set_PGPEncrypt;
    property PGPSign: WordBool read Get_PGPSign write Set_PGPSign;
    property PGPPassphrase: WideString read Get_PGPPassphrase write Set_PGPPassphrase;
    property PGPSignkey: WideString read Get_PGPSignkey write Set_PGPSignkey;
    property ReplyTo: WideString read Get_ReplyTo write Set_ReplyTo;
    property HideRecipients: WideString read Get_HideRecipients write Set_HideRecipients;
    property MailDomain: WideString read Get_MailDomain write Set_MailDomain;
    property Charset: WideString read Get_Charset write Set_Charset;
    property ContentTransferEncoding: WideString read Get_ContentTransferEncoding write Set_ContentTransferEncoding;
    property MimeVersion: WideString read Get_MimeVersion write Set_MimeVersion;
    property Encoding: WideString read Get_Encoding write Set_Encoding;
    property ReturnReceipt: WordBool read Get_ReturnReceipt write Set_ReturnReceipt;
    property Log: WideString read Get_Log;
    property Logging: WordBool read Get_Logging write Set_Logging;
    property HTMLBody: WideString read Get_HTMLBody write Set_HTMLBody;
    property ISOEncodeHeaders: WordBool read Get_ISOEncodeHeaders write Set_ISOEncodeHeaders;
    property UsePipelining: WordBool read Get_UsePipelining write Set_UsePipelining;
    property Silent: WordBool read Get_Silent write Set_Silent;
    property ErrorCode: Integer read Get_ErrorCode;
    property ErrorMessage: WideString read Get_ErrorMessage;
    property ErrorSource: WideString read Get_ErrorSource;
    property SimpleLayout: WordBool read Get_SimpleLayout write Set_SimpleLayout;
    property RecipientsString: WideString read Get_RecipientsString;
    property DeferredDelivery: TDateTime read Get_DeferredDelivery write Set_DeferredDelivery;
    property MailData: WideString read Get_MailData;
    property About: WideString read Get_About;
    property Version: WideString read Get_Version;
    property EncryptAttachments: WordBool read Get_EncryptAttachments write Set_EncryptAttachments;
    property MailServerUserName: WideString read Get_MailServerUserName write Set_MailServerUserName;
    property MailServerPassWord: WideString read Get_MailServerPassWord write Set_MailServerPassWord;
  end;

// *********************************************************************//
// DispIntf:  IMessageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3A037057-57F0-4904-A1E0-AD0EA2FB564E}
// *********************************************************************//
  IMessageDisp = dispinterface
    ['{3A037057-57F0-4904-A1E0-AD0EA2FB564E}']
    property Date: TDateTime readonly dispid 5;
    property Size: Integer readonly dispid 7;
    property MessageOrder: WideString dispid 12;
    procedure LoadFromStream(const Stream: IUnknown); dispid 13;
    procedure SaveToStream(const Stream: IUnknown); dispid 14;
    procedure ParseMessage(const MessageSource: WideString); dispid 15;
    property Text: WideString readonly dispid 16;
    property Headers: IHeaders readonly dispid 8;
    property Recipients: IRecipients readonly dispid 9;
    property Attachments: IAttachments readonly dispid 10;
    property Subject: WideString dispid 24;
    property From: WideString dispid 25;
    property FromName: WideString dispid 26;
    property Body: WideString dispid 27;
    property Priority: Byte dispid 28;
    property ContentType: WideString dispid 29;
    procedure Send(const mailServer: WideString; enque: WordBool); dispid 1;
    property BodyText: WideString readonly dispid 2;
    function  DecodeHeader(const Header: WideString): WideString; dispid 3;
    procedure SendToNewsGroup(const ServerName: WideString; const Newsgroups: WideString); dispid 4;
    property Envelope: IUnknown dispid 6;
    property MsPickupdirectory: WideString dispid 51;
    procedure nq; dispid 52;
    function  KeyInformation(const keyIdentifier: WideString): IPGPKeys; dispid 53;
    property PGPEncrypt: WordBool dispid 55;
    property PGPSign: WordBool dispid 56;
    property PGPPassphrase: WideString dispid 57;
    property PGPSignkey: WideString dispid 58;
    property ReplyTo: WideString dispid 11;
    property HideRecipients: WideString dispid 17;
    property MailDomain: WideString dispid 18;
    property Charset: WideString dispid 19;
    property ContentTransferEncoding: WideString dispid 20;
    property MimeVersion: WideString dispid 21;
    property Encoding: WideString dispid 22;
    property ReturnReceipt: WordBool dispid 23;
    procedure LogCustomMessage(const Message: WideString); dispid 30;
    property Log: WideString readonly dispid 31;
    property Logging: WordBool dispid 32;
    property HTMLBody: WideString dispid 33;
    procedure Close; dispid 34;
    property ISOEncodeHeaders: WordBool dispid 35;
    procedure ClearCustomHeaders; dispid 36;
    property UsePipelining: WordBool dispid 37;
    property Silent: WordBool dispid 38;
    property ErrorCode: Integer readonly dispid 39;
    property ErrorMessage: WideString readonly dispid 40;
    property ErrorSource: WideString readonly dispid 41;
    property SimpleLayout: WordBool dispid 42;
    procedure GetMessageBodyFromURL(const bstrURL: WideString; const bstrAuth: WideString); dispid 43;
    function  AddURLAttachment(const bstrURL: WideString; const bstrAttachAs: WideString;
                               const bstrAuth: WideString): WideString; dispid 44;
    procedure ExtractEmailAddressesFromURL(const bstrURL: WideString; const bstrAuth: WideString); dispid 45;
    property RecipientsString: WideString readonly dispid 46;
    property DeferredDelivery: TDateTime dispid 47;
    property MailData: WideString readonly dispid 48;
    property About: WideString readonly dispid 49;
    procedure AddRecipient(const emailAddress: WideString; const recipientName: WideString; 
                           const PGPKey: WideString); dispid 54;
    procedure AddRecipientCC(const emailAddress: WideString; const recipientName: WideString; 
                             const PGPKey: WideString); dispid 59;
    procedure AddRecipientBCC(const emailAddress: WideString; const PGPKey: WideString); dispid 60;
    property Version: WideString readonly dispid 61;
    function  VerifyKeys(const keyString: WideString): WordBool; dispid 62;
    procedure ClearRecipients; dispid 63;
    procedure ClearAttachments; dispid 64;
    procedure AppendBodyFromFile(const FileName: WideString); dispid 65;
    procedure AppendText(const Text: WideString); dispid 66;
    function  AddAttachment(const FileName: WideString; const ContentType: WideString): WideString; dispid 67;
    function  AddCustomAttachment(const FileName: WideString; const Data: WideString): WideString; dispid 68;
    procedure AddHeader(const XHeader: WideString; const Value: WideString); dispid 69;
    procedure AddNativeHeader(const Header: WideString; const Value: WideString); dispid 70;
    property EncryptAttachments: WordBool dispid 50;
    property MailServerUserName: WideString dispid 71;
    property MailServerPassWord: WideString dispid 72;
    procedure Clear; dispid 73;
  end;

// *********************************************************************//
// Interface: IHeaders
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CF2ED965-E0BA-4FE4-ADE2-38BD48F112E8}
// *********************************************************************//
  IHeaders = interface(IDispatch)
    ['{CF2ED965-E0BA-4FE4-ADE2-38BD48F112E8}']
    function  GetHeader(const Headername: WideString): WideString; safecall;
    function  Get_Text: WideString; safecall;
    property Text: WideString read Get_Text;
  end;

// *********************************************************************//
// DispIntf:  IHeadersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CF2ED965-E0BA-4FE4-ADE2-38BD48F112E8}
// *********************************************************************//
  IHeadersDisp = dispinterface
    ['{CF2ED965-E0BA-4FE4-ADE2-38BD48F112E8}']
    function  GetHeader(const Headername: WideString): WideString; dispid 1;
    property Text: WideString readonly dispid 2;
  end;

// *********************************************************************//
// Interface: IRecipients
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {56930358-AD72-408F-83C4-A2B0DC8037B2}
// *********************************************************************//
  IRecipients = interface(IDispatch)
    ['{56930358-AD72-408F-83C4-A2B0DC8037B2}']
    function  Get_Count: Integer; safecall;
    function  Get_Item(Index: Integer): IRecipient; safecall;
    procedure Add(const Value: IRecipient); safecall;
    procedure Clear; safecall;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: IRecipient read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IRecipientsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {56930358-AD72-408F-83C4-A2B0DC8037B2}
// *********************************************************************//
  IRecipientsDisp = dispinterface
    ['{56930358-AD72-408F-83C4-A2B0DC8037B2}']
    property Count: Integer readonly dispid 1;
    property Item[Index: Integer]: IRecipient readonly dispid 2;
    procedure Add(const Value: IRecipient); dispid 3;
    procedure Clear; dispid 4;
  end;

// *********************************************************************//
// Interface: IRecipient
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65C53BE7-ED21-4C25-B189-DA0E8FAD5231}
// *********************************************************************//
  IRecipient = interface(IDispatch)
    ['{65C53BE7-ED21-4C25-B189-DA0E8FAD5231}']
    function  Get_Name: WideString; safecall;
    function  Get_EMail: WideString; safecall;
    function  Get_ReType: Integer; safecall;
    function  New(const Name: WideString; const EMail: WideString; recipientType: Shortint): IRecipient; safecall;
    property Name: WideString read Get_Name;
    property EMail: WideString read Get_EMail;
    property ReType: Integer read Get_ReType;
  end;

// *********************************************************************//
// DispIntf:  IRecipientDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {65C53BE7-ED21-4C25-B189-DA0E8FAD5231}
// *********************************************************************//
  IRecipientDisp = dispinterface
    ['{65C53BE7-ED21-4C25-B189-DA0E8FAD5231}']
    property Name: WideString readonly dispid 1;
    property EMail: WideString readonly dispid 2;
    property ReType: Integer readonly dispid 3;
    function  New(const Name: WideString; const EMail: WideString;
                  recipientType: {??Shortint} OleVariant): IRecipient; dispid 4;
  end;

// *********************************************************************//
// Interface: IAttachments
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1E6D8684-755D-4847-BF40-68EC5E4BC1E9}
// *********************************************************************//
  IAttachments = interface(IDispatch)
    ['{1E6D8684-755D-4847-BF40-68EC5E4BC1E9}']
    function  Get_Count: Integer; safecall;
    procedure Add(var Attachment: IAttachment); safecall;
    function  Get_Item(Index: Integer): IAttachment; safecall;
    procedure Clear; safecall;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: IAttachment read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IAttachmentsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1E6D8684-755D-4847-BF40-68EC5E4BC1E9}
// *********************************************************************//
  IAttachmentsDisp = dispinterface
    ['{1E6D8684-755D-4847-BF40-68EC5E4BC1E9}']
    property Count: Integer readonly dispid 1;
    procedure Add(var Attachment: IAttachment); dispid 3;
    property Item[Index: Integer]: IAttachment readonly dispid 2;
    procedure Clear; dispid 4;
  end;

// *********************************************************************//
// Interface: IAttachment
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {952F0B99-50B6-44B3-AE0D-700D5B98B416}
// *********************************************************************//
  IAttachment = interface(IDispatch)
    ['{952F0B99-50B6-44B3-AE0D-700D5B98B416}']
    function  Get_Name: WideString; safecall;
    function  Get_Size: Integer; safecall;
    function  Get_ContentType: WideString; safecall;
    procedure SaveToFile(const FileName: WideString); safecall;
    function  Get_Data: WideString; safecall;
    procedure Set_Data(const Value: WideString); safecall;
    function  New(const FileName: WideString; const ContentType: WideString; const Data: WideString): IAttachment; safecall;
    property Name: WideString read Get_Name;
    property Size: Integer read Get_Size;
    property ContentType: WideString read Get_ContentType;
    property Data: WideString read Get_Data write Set_Data;
  end;

// *********************************************************************//
// DispIntf:  IAttachmentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {952F0B99-50B6-44B3-AE0D-700D5B98B416}
// *********************************************************************//
  IAttachmentDisp = dispinterface
    ['{952F0B99-50B6-44B3-AE0D-700D5B98B416}']
    property Name: WideString readonly dispid 1;
    property Size: Integer readonly dispid 2;
    property ContentType: WideString readonly dispid 3;
    procedure SaveToFile(const FileName: WideString); dispid 4;
    property Data: WideString dispid 5;
    function  New(const FileName: WideString; const ContentType: WideString; const Data: WideString): IAttachment; dispid 6;
  end;

// *********************************************************************//
// Interface: ISMTPMail
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AED3A6B1-2171-11D2-B77C-0008C73ACA8F}
// *********************************************************************//
  ISMTPMail = interface(IDispatch)
    ['{AED3A6B1-2171-11D2-B77C-0008C73ACA8F}']
    function  Execute: WordBool; safecall;
    procedure AppendBodyFromFile(const FileName: WideString); safecall;
    procedure AppendText(const Text: WideString); safecall;
    function  AddAttachment(const FileName: WideString; const ContentType: WideString): WideString; safecall;
    function  AddCustomAttachment(const FileName: WideString; const Data: WideString): WideString; safecall;
    procedure AddRecipient(const EMail: WideString); safecall;
    procedure AddRecipientCC(const EMail: WideString); safecall;
    procedure AddRecipientBCC(const EMail: WideString); safecall;
    procedure AddHeader(const XHeader: WideString; const Value: WideString); safecall;
    procedure AddNativeHeader(const Header: WideString; const Value: WideString); safecall;
    procedure ClearRecipients; safecall;
    procedure ClearAttachments; safecall;
    function  Get_ServerAddress: WideString; safecall;
    procedure Set_ServerAddress(const Value: WideString); safecall;
    function  Get_ServerPort: Integer; safecall;
    procedure Set_ServerPort(Value: Integer); safecall;
    function  Get_Sender: WideString; safecall;
    procedure Set_Sender(const Value: WideString); safecall;
    function  Get_SenderName: WideString; safecall;
    procedure Set_SenderName(const Value: WideString); safecall;
    function  Get_ReplyTo: WideString; safecall;
    procedure Set_ReplyTo(const Value: WideString); safecall;
    function  Get_Subject: WideString; safecall;
    procedure Set_Subject(const Value: WideString); safecall;
    function  Get_Body: WideString; safecall;
    procedure Set_Body(const Value: WideString); safecall;
    function  Get_ContentType: WideString; safecall;
    procedure Set_ContentType(const Value: WideString); safecall;
    function  Get_Priority: Integer; safecall;
    procedure Set_Priority(Value: Integer); safecall;
    function  Get_HideRecipients: WideString; safecall;
    procedure Set_HideRecipients(const Value: WideString); safecall;
    function  Get_MailDomain: WideString; safecall;
    procedure Set_MailDomain(const Value: WideString); safecall;
    function  Get_Lazysend: WordBool; safecall;
    procedure Set_Lazysend(Value: WordBool); safecall;
    function  Get_Charset: WideString; safecall;
    procedure Set_Charset(const Value: WideString); safecall;
    function  Get_ContentTransferEncoding: WideString; safecall;
    procedure Set_ContentTransferEncoding(const Value: WideString); safecall;
    function  Get_MimeVersion: WideString; safecall;
    procedure Set_MimeVersion(const Value: WideString); safecall;
    function  Get_Encoding: WideString; safecall;
    procedure Set_Encoding(const Value: WideString); safecall;
    procedure AddRecipientEx(const EMail: WideString; const Name: WideString); safecall;
    function  Get_ReturnReceipt: WordBool; safecall;
    procedure Set_ReturnReceipt(Value: WordBool); safecall;
    procedure LogCustomMessage(const Message: WideString); safecall;
    function  Get_Log: WideString; safecall;
    function  Get_Logging: WordBool; safecall;
    procedure Set_Logging(Value: WordBool); safecall;
    function  Get_HTMLBody: WideString; safecall;
    procedure Set_HTMLBody(const Value: WideString); safecall;
    procedure Close; safecall;
    function  Get_ISOEncodeHeaders: WordBool; safecall;
    procedure Set_ISOEncodeHeaders(Value: WordBool); safecall;
    procedure ClearCustomHeaders; safecall;
    function  Get_UsePipelining: WordBool; safecall;
    procedure Set_UsePipelining(Value: WordBool); safecall;
    function  Get_Silent: WordBool; safecall;
    procedure Set_Silent(Value: WordBool); safecall;
    function  Get_ErrorCode: Integer; safecall;
    function  Get_ErrorMessage: WideString; safecall;
    function  Get_ErrorSource: WideString; safecall;
    function  Get_SimpleLayout: WordBool; safecall;
    procedure Set_SimpleLayout(Value: WordBool); safecall;
    procedure GetMessageBodyFromURL(const bstrURL: WideString; const bstrAuth: WideString); safecall;
    function  AddURLAttachment(const bstrURL: WideString; const bstrAttachAs: WideString; 
                               const bstrAuth: WideString): WideString; safecall;
    procedure ExtractEmailAddressesFromURL(const bstrURL: WideString; const bstrAuth: WideString); safecall;
    function  Get_Recipients: WideString; safecall;
    function  Get_DeferredDelivery: TDateTime; safecall;
    procedure Set_DeferredDelivery(Value: TDateTime); safecall;
    function  Get_Version: WideString; safecall;
    function  Get_MemCount: Integer; safecall;
    function  Get_MemSize: Integer; safecall;
    function  Get_Message: IMessage; safecall;
    procedure Set_Message(const Value: IMessage); safecall;
    property ServerAddress: WideString read Get_ServerAddress write Set_ServerAddress;
    property ServerPort: Integer read Get_ServerPort write Set_ServerPort;
    property Sender: WideString read Get_Sender write Set_Sender;
    property SenderName: WideString read Get_SenderName write Set_SenderName;
    property ReplyTo: WideString read Get_ReplyTo write Set_ReplyTo;
    property Subject: WideString read Get_Subject write Set_Subject;
    property Body: WideString read Get_Body write Set_Body;
    property ContentType: WideString read Get_ContentType write Set_ContentType;
    property Priority: Integer read Get_Priority write Set_Priority;
    property HideRecipients: WideString read Get_HideRecipients write Set_HideRecipients;
    property MailDomain: WideString read Get_MailDomain write Set_MailDomain;
    property Lazysend: WordBool read Get_Lazysend write Set_Lazysend;
    property Charset: WideString read Get_Charset write Set_Charset;
    property ContentTransferEncoding: WideString read Get_ContentTransferEncoding write Set_ContentTransferEncoding;
    property MimeVersion: WideString read Get_MimeVersion write Set_MimeVersion;
    property Encoding: WideString read Get_Encoding write Set_Encoding;
    property ReturnReceipt: WordBool read Get_ReturnReceipt write Set_ReturnReceipt;
    property Log: WideString read Get_Log;
    property Logging: WordBool read Get_Logging write Set_Logging;
    property HTMLBody: WideString read Get_HTMLBody write Set_HTMLBody;
    property ISOEncodeHeaders: WordBool read Get_ISOEncodeHeaders write Set_ISOEncodeHeaders;
    property UsePipelining: WordBool read Get_UsePipelining write Set_UsePipelining;
    property Silent: WordBool read Get_Silent write Set_Silent;
    property ErrorCode: Integer read Get_ErrorCode;
    property ErrorMessage: WideString read Get_ErrorMessage;
    property ErrorSource: WideString read Get_ErrorSource;
    property SimpleLayout: WordBool read Get_SimpleLayout write Set_SimpleLayout;
    property Recipients: WideString read Get_Recipients;
    property DeferredDelivery: TDateTime read Get_DeferredDelivery write Set_DeferredDelivery;
    property Version: WideString read Get_Version;
    property MemCount: Integer read Get_MemCount;
    property MemSize: Integer read Get_MemSize;
    property Message: IMessage read Get_Message write Set_Message;
  end;

// *********************************************************************//
// DispIntf:  ISMTPMailDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AED3A6B1-2171-11D2-B77C-0008C73ACA8F}
// *********************************************************************//
  ISMTPMailDisp = dispinterface
    ['{AED3A6B1-2171-11D2-B77C-0008C73ACA8F}']
    function  Execute: WordBool; dispid 6;
    procedure AppendBodyFromFile(const FileName: WideString); dispid 20;
    procedure AppendText(const Text: WideString); dispid 21;
    function  AddAttachment(const FileName: WideString; const ContentType: WideString): WideString; dispid 22;
    function  AddCustomAttachment(const FileName: WideString; const Data: WideString): WideString; dispid 25;
    procedure AddRecipient(const EMail: WideString); dispid 9;
    procedure AddRecipientCC(const EMail: WideString); dispid 11;
    procedure AddRecipientBCC(const EMail: WideString); dispid 12;
    procedure AddHeader(const XHeader: WideString; const Value: WideString); dispid 10;
    procedure AddNativeHeader(const Header: WideString; const Value: WideString); dispid 13;
    procedure ClearRecipients; dispid 61;
    procedure ClearAttachments; dispid 19;
    property ServerAddress: WideString dispid 2;
    property ServerPort: Integer dispid 3;
    property Sender: WideString dispid 4;
    property SenderName: WideString dispid 18;
    property ReplyTo: WideString dispid 5;
    property Subject: WideString dispid 7;
    property Body: WideString dispid 8;
    property ContentType: WideString dispid 23;
    property Priority: Integer dispid 24;
    property HideRecipients: WideString dispid 14;
    property MailDomain: WideString dispid 15;
    property Lazysend: WordBool dispid 16;
    property Charset: WideString dispid 17;
    property ContentTransferEncoding: WideString dispid 1;
    property MimeVersion: WideString dispid 26;
    property Encoding: WideString dispid 27;
    procedure AddRecipientEx(const EMail: WideString; const Name: WideString); dispid 28;
    property ReturnReceipt: WordBool dispid 29;
    procedure LogCustomMessage(const Message: WideString); dispid 31;
    property Log: WideString readonly dispid 33;
    property Logging: WordBool dispid 34;
    property HTMLBody: WideString dispid 30;
    procedure Close; dispid 32;
    property ISOEncodeHeaders: WordBool dispid 35;
    procedure ClearCustomHeaders; dispid 36;
    property UsePipelining: WordBool dispid 37;
    property Silent: WordBool dispid 38;
    property ErrorCode: Integer readonly dispid 39;
    property ErrorMessage: WideString readonly dispid 40;
    property ErrorSource: WideString readonly dispid 41;
    property SimpleLayout: WordBool dispid 42;
    procedure GetMessageBodyFromURL(const bstrURL: WideString; const bstrAuth: WideString); dispid 43;
    function  AddURLAttachment(const bstrURL: WideString; const bstrAttachAs: WideString; 
                               const bstrAuth: WideString): WideString; dispid 44;
    procedure ExtractEmailAddressesFromURL(const bstrURL: WideString; const bstrAuth: WideString); dispid 45;
    property Recipients: WideString readonly dispid 46;
    property DeferredDelivery: TDateTime dispid 47;
    property Version: WideString readonly dispid 48;
    property MemCount: Integer readonly dispid 49;
    property MemSize: Integer readonly dispid 50;
    property Message: IMessage dispid 60;
  end;

// *********************************************************************//
// Interface: IPOP3Mail
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {14E61A41-8846-11D2-B7E4-0008C73ACA8F}
// *********************************************************************//
  IPOP3Mail = interface(IDispatch)
    ['{14E61A41-8846-11D2-B7E4-0008C73ACA8F}']
  end;

// *********************************************************************//
// DispIntf:  IPOP3MailDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {14E61A41-8846-11D2-B7E4-0008C73ACA8F}
// *********************************************************************//
  IPOP3MailDisp = dispinterface
    ['{14E61A41-8846-11D2-B7E4-0008C73ACA8F}']
  end;

// *********************************************************************//
// Interface: IPGPKeys
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {23E86816-772B-4B28-A924-A135CFF6469A}
// *********************************************************************//
  IPGPKeys = interface(IDispatch)
    ['{23E86816-772B-4B28-A924-A135CFF6469A}']
    function  Get_Count: Integer; safecall;
    function  Get_Item(Index: Integer): IPGPKeyInfo; safecall;
    procedure AddKey(const key: IPGPKeyInfo); safecall;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: IPGPKeyInfo read Get_Item;
  end;

// *********************************************************************//
// DispIntf:  IPGPKeysDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {23E86816-772B-4B28-A924-A135CFF6469A}
// *********************************************************************//
  IPGPKeysDisp = dispinterface
    ['{23E86816-772B-4B28-A924-A135CFF6469A}']
    property Count: Integer readonly dispid 1;
    property Item[Index: Integer]: IPGPKeyInfo readonly dispid 2;
    procedure AddKey(const key: IPGPKeyInfo); dispid 3;
  end;

// *********************************************************************//
// Interface: IPGPKeyInfo
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B89D0E7A-0F5B-40EE-8AF3-08FA2ED9534F}
// *********************************************************************//
  IPGPKeyInfo = interface(IDispatch)
    ['{B89D0E7A-0F5B-40EE-8AF3-08FA2ED9534F}']
    function  Get_KeyUser: WideString; safecall;
    function  Get_KeyID: WideString; safecall;
    function  Get_KeyCreationDate: WideString; safecall;
    property KeyUser: WideString read Get_KeyUser;
    property KeyID: WideString read Get_KeyID;
    property KeyCreationDate: WideString read Get_KeyCreationDate;
  end;

// *********************************************************************//
// DispIntf:  IPGPKeyInfoDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {B89D0E7A-0F5B-40EE-8AF3-08FA2ED9534F}
// *********************************************************************//
  IPGPKeyInfoDisp = dispinterface
    ['{B89D0E7A-0F5B-40EE-8AF3-08FA2ED9534F}']
    property KeyUser: WideString readonly dispid 1;
    property KeyID: WideString readonly dispid 3;
    property KeyCreationDate: WideString readonly dispid 5;
  end;

// *********************************************************************//
// Interface: IMailMerge
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C21B3B1-2B11-45F2-8A9E-DCC5032DE98A}
// *********************************************************************//
  IMailMerge = interface(IDispatch)
    ['{0C21B3B1-2B11-45F2-8A9E-DCC5032DE98A}']
    function  Get_MergeAttachments: WordBool; safecall;
    procedure Set_MergeAttachments(Value: WordBool); safecall;
    function  Get_MailTemplate: IMessage; safecall;
    procedure Set_MailTemplate(const Value: IMessage); safecall;
    procedure SetDebugMode(const TestMailAddress: WideString; TestCount: Integer); safecall;
    function  Get_Item(const VariableName: WideString): WideString; safecall;
    procedure Set_Item(const VariableName: WideString; const Value: WideString); safecall;
    function  Expand: IMessage; safecall;
    function  ExpandFromRecordSet(RecordSet: OleVariant): IMessage; safecall;
    procedure BulkMerge(RecordSet: OleVariant; enque: WordBool; const Maildestination: WideString); safecall;
    property MergeAttachments: WordBool read Get_MergeAttachments write Set_MergeAttachments;
    property MailTemplate: IMessage read Get_MailTemplate write Set_MailTemplate;
    property Item[const VariableName: WideString]: WideString read Get_Item write Set_Item;
  end;

// *********************************************************************//
// DispIntf:  IMailMergeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0C21B3B1-2B11-45F2-8A9E-DCC5032DE98A}
// *********************************************************************//
  IMailMergeDisp = dispinterface
    ['{0C21B3B1-2B11-45F2-8A9E-DCC5032DE98A}']
    property MergeAttachments: WordBool dispid 1;
    property MailTemplate: IMessage dispid 2;
    procedure SetDebugMode(const TestMailAddress: WideString; TestCount: Integer); dispid 4;
    property Item[const VariableName: WideString]: WideString dispid 5;
    function  Expand: IMessage; dispid 6;
    function  ExpandFromRecordSet(RecordSet: OleVariant): IMessage; dispid 7;
    procedure BulkMerge(RecordSet: OleVariant; enque: WordBool; const Maildestination: WideString); dispid 8;
  end;

// *********************************************************************//
// Interface: ISpeedMailer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {821AAFE5-2F19-47EB-ACA9-3B4C1D64AC27}
// *********************************************************************//
  ISpeedMailer = interface(IDispatch)
    ['{821AAFE5-2F19-47EB-ACA9-3B4C1D64AC27}']
    procedure SendMail(const FromEMail: WideString; const RecipientEMails: WideString; 
                       const Subject: WideString; const Body: WideString; 
                       const MailServers: WideString); safecall;
    procedure EnqueMail(const FromEMail: WideString; const RecipientEMails: WideString; 
                        const Subject: WideString; const Body: WideString;
                        const MsPickupdirectory: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  ISpeedMailerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {821AAFE5-2F19-47EB-ACA9-3B4C1D64AC27}
// *********************************************************************//
  ISpeedMailerDisp = dispinterface
    ['{821AAFE5-2F19-47EB-ACA9-3B4C1D64AC27}']
    procedure SendMail(const FromEMail: WideString; const RecipientEMails: WideString;
                       const Subject: WideString; const Body: WideString;
                       const MailServers: WideString); dispid 1;
    procedure EnqueMail(const FromEMail: WideString; const RecipientEMails: WideString;
                        const Subject: WideString; const Body: WideString;
                        const MsPickupdirectory: WideString); dispid 2;
  end;


implementation


end.

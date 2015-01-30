{
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
}

unit uJMail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ActiveX, JMailTLB, comobj;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Label7: TLabel;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit5.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var msg : IMessage;
begin
  CoInitialize( nil );

  msg := CreateOleObject( 'JMail.Message' ) as IMessage;   // Creating the JMail object

  msg.Subject := Edit3.Text;                   // and setting some properties

  msg.From := Edit1.Text;
  msg.AddRecipient( Edit2.Text, '', '' );

  msg.Body := Memo1.Text;

  if Edit5.Text <> '' then
    msg.AddAttachment( Edit5.Text, '' );

  Label7.Caption := 'Sending mail...';
  msg.Send( Edit4.Text, false );

  msg := nil;                                  // Cleaining up
  CoUninitialize;
  Label7.Caption := 'Mail has been sent';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  PostQuitMessage( 0 );
end;

end.
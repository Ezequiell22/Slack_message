unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
   System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  slackMessage.model.message;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

USES slackMessage.model.interfaces;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var SlackMsg : iModelMessage;
begin
  SlackMsg := TModelMessage.New;

  SlackMsg.messageSend('Hello from Delphi!');
end;


end.

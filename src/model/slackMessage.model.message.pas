unit slackMessage.model.message;

interface

uses
  slackMessage.model.interfaces, System.JSON, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Classes,
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TModelMessage = class(TInterfacedObject, iModelMessage)
  private
    FHttpClient: TNetHTTPClient;
    FHttpRequest: TNetHTTPRequest;
    FJsonResponse: TStringStream;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelMessage;
    function MessageSend(aValue: string): iModelMessage;
  end;

implementation

const
  TOKEN = '';

const
  CHANNEL = '';

const
  URL = 'https://slack.com/api/chat.postMessage';

  { TModelMessage }

constructor TModelMessage.Create;
begin
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpRequest := TNetHTTPRequest.Create(nil);
  FJsonResponse := TStringStream.Create('');

  FHttpClient.Accept := 'application/json';
  FHttpClient.ContentType := 'application/json; charset=UTF-8';
  FHttpRequest.Client := FHttpClient;
  FHttpRequest.CustomHeaders['Authorization'] := 'Bearer ' + TOKEN;
end;

destructor TModelMessage.Destroy;
begin
  FHttpClient.Free;
  FHttpRequest.Free;
  FJsonResponse.Free;
  inherited;
end;

function TModelMessage.MessageSend(aValue: string): iModelMessage;
var
  JsonObject: TJSONObject;
begin
  JsonObject := TJSONObject.Create;
  try
    JsonObject.AddPair('channel', CHANNEL);
    JsonObject.AddPair('text', aValue);
    try
      FHttpRequest.Post(URL, TStringStream.Create(JsonObject.ToString,
        TEncoding.UTF8), FJsonResponse);
    except
      on E: Exception do
//        ShowMessage('Failed to send message: ' + E.message);
    end;
  finally
    JsonObject.Free;
  end;
end;

class function TModelMessage.New: iModelMessage;
begin
  result := Self.Create;
end;

end.

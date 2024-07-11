unit slackMessage.model.interfaces;

interface
  type
    iModelMessage = interface
      ['{88E46351-4397-4B6C-BFBC-4778543F91FD}']
      function MessageSend(aValue : string) : iModelMessage;
    end;

implementation

end.

program UseHTML2CanvasForScreenshot;

uses
  VirtualUI_AutoRun,
  Vcl.Forms,
  frmUIMain in 'frmUIMain.pas' {UIMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUIMain, UIMain);
  Application.Run;
end.

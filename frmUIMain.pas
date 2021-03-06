unit frmUIMain;
{$WARN SYMBOL_PLATFORM OFF}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VirtualUI_SDK,
  Vcl.ExtCtrls;

type
  TUIMain = class(TForm)
    btnScreenshot: TButton;
    GroupBox1: TGroupBox;
    lbxScreens: TListBox;
    btnViewScreen: TButton;
    Timer1: TTimer;
    pnlTime: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnScreenshotClick(Sender: TObject);
    procedure btnViewScreenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    ro: TJSObject;
    procedure Base64ToImageFile(aBase64Str: string; aFileName: string);
    function GetJSDir: string;
  public
    { Public declarations }
  end;

var
  UIMain: TUIMain;

implementation

{$R *.dfm}

uses
  Vcl.Imaging.pngimage
, Soap.EncdDecd
, System.IOUtils
, System.NetEncoding
  ;

procedure TUIMain.Base64ToImageFile(aBase64Str: string; aFileName: string);
var
  Input: TStringStream;
  Output: TBytesStream;
  Idx : Integer;
  Mime : string;
begin
  Idx := Pos(',',aBase64Str);
  if Idx > 0 then
    begin
      Mime := Copy(aBase64Str,1,idx-1);
      aBase64Str := Copy(aBase64Str,Idx+1,Length(aBase64Str));
      Input := TStringStream.Create(aBase64Str, TEncoding.ASCII);
      Output := TBytesStream.Create;
      try
        DecodeStream(Input, Output);
        Output.Position := 0;
        Output.SaveToFile(aFileName);
      finally
        Input.Free;
        Output.Free;
      end;
    end;
end;

procedure TUIMain.btnScreenshotClick(Sender: TObject);
begin
  ro.Events['dohtml2canvasop'].Fire;
end;

procedure TUIMain.btnViewScreenClick(Sender: TObject);
var
  lFileName: string;
  lSelectedIdx: integer;
  BaseDir : string;
  lUrl: string;
begin
  BaseDir := ExtractFilePath(ParamStr(0));
  lSelectedIdx := lbxScreens.ItemIndex;
  if lSelectedIdx > -1 then
    begin
      lFileName := lbxScreens.items[lSelectedIdx];
      lFileName := TPath.Combine(BaseDir, lFileName);
      lUrl := VirtualUI.HTMLDoc.GetSafeURL(lFileName, 1);
      VirtualUI.OpenLinkDlg(lURL, 'Screenshot Results');
    end;
end;

function TUIMain.GetJSDir: string;
var
  lBaseDir : string;
  lJSDirTest: string;
begin
  result := '';
  lBaseDir := ExtractFilePath(ParamStr(0));
  while (lBaseDir <> '') and (length(lBaseDir) > 2) do
    begin
      lJSDirTest := lBaseDir + 'js\';
      if DirectoryExists(lJSDirTest) then
        begin
          result := lJSDirTest;
          break;
        end;
      lBaseDir := ExtractFilePath(ExcludeTrailingBackSlash(lBaseDir));
    end;
end;

procedure TUIMain.Timer1Timer(Sender: TObject);
begin
  pnlTime.Caption := formatdatetime('mm-dd-yyy hh:mm:ss',now);
end;

procedure TUIMain.FormCreate(Sender: TObject);
var
  lJSDir: string;
begin
  var lAppName := ParamStr(0);
  lJSDir := GetJSDir;
  if lJSDir <> '' then
    begin
      ro := TJSObject.Create('ro');
      ro.Properties.Add('data')
        .OnSet(TJSBinding.Create(
          procedure(const Parent: IJSObject; const Prop: IJSProperty)
          var
            lData: string;
            lFileName: string;
          begin
            lData := Prop.AsString;
            {2021-12-22 Property is coming in with spaces. Need to replace them with plus symbol.}
            lData := StringReplace(lData, ' ', '+', [rfReplaceAll]);
            {---}
            lFileName := 'ScreenShot-' + formatdatetime('yyyymmddhhnnss',now) + '.png';
            Base64ToImageFile(lData, lFileName);
            UIMain.lbxScreens.Items.Add(lFileName);
          end))
        .AsString := '';
      ro.Events.Add('dohtml2canvasop');
      ro.ApplyModel;
      VirtualUI.HTMLDoc.CreateSessionURL('/js/', lJSDir);
      VirtualUI.HTMLDoc.LoadScript('/js/html2canvas.min.js','');
      VirtualUI.HTMLDoc.LoadScript('/js/vui-jsro.js','');
    end;
end;

end.


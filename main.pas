unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, Registry, SHDocVw, MSHTML,
  Menus, ComCtrls, ToolWin, ImgList, Settings, selectlabels;

const
  VALID_ZPL_CHECKER_STRING = '${ ^FX ��� NETTO ^FS}';
  LABEL_NUBMER_STRING = '^FO91,925^A0,100,110^FB750,1,0,C,0^FD';
  COMMAND_FILENAME = 'subst.zpl';
  DEFAULT_PRINTER = '\\otk-0394\GenericT';
  PRINT_FILENAME = 'temp.txt';
  TagID = '\{10954C80-4F0F-11d3-B17C-00C0DFE39736}\';

  LOAD_FONTS_ZPL_COMMAND = '^XA^CW2,E:ARI000.FNT^FS^XZ';
  LIST_FONTS_ZPL = '^XA^WD*:*.FNT*^XZ';
  CODE39_TEST_ZPL = '^XA^FO100,100^BY3^B3N,N,100,Y,N^FD123ABC^FS^XZ';

  zplUNKNOWN = 0;
  zplWIN = 1;
  zplDOS = 2;

  Koi: array[0..66] of Char =
   ('T', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�');

  Win: array[0..66] of Char =
   ('�', '�', 'T', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�', '�', '�', '�',
    '�', '�', '�', '�', '�', '�', '�');

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    Memo1: TMemo;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Dsjl1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    N13: TMenuItem;
    N14: TMenuItem;
    ilToolbar: TImageList;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Splitter1: TSplitter;
    ListBox1: TListBox;
    SpeedButton5: TSpeedButton;
    Label2: TLabel;
    ZPL1: TMenuItem;
    HTM1: TMenuItem;
    OpenMenu: TPopupMenu;
    ZPL2: TMenuItem;
    N15: TMenuItem;
    SaveDialog1: TSaveDialog;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    Code391: TMenuItem;
    Unicode1: TMenuItem;
    KOIWIN1: TMenuItem;
    N25: TMenuItem;
    WINDOS1: TMenuItem;
    KOI8ANSI1: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    WINDOS2: TMenuItem;
    DOSWIN1: TMenuItem;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    N28: TMenuItem;
    N29: TMenuItem;
    ToolButton18: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure HTM1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure Dsjl1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure ZPL1Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure Code391Click(Sender: TObject);
    procedure Unicode1Click(Sender: TObject);
    procedure KOIWIN1Click(Sender: TObject);
    procedure WINDOS1Click(Sender: TObject);
    procedure KOI8ANSI1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo1Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure WINDOS2Click(Sender: TObject);
    procedure DOSWIN1Click(Sender: TObject);
    procedure StatusBar1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N29Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
  private
    Ini: TIniFile;
    strChecker, strLoadFonts, strPrinterPath, strCurrentFilename: String;
    bValidateZPL, bRegisterIEButton, bFormatZPL, bStartupSearchIE,
      bAssocFiles, bShowAfterPrint: boolean;
    iZPLCopies : integer;
    procedure CreateExplorerButton;
    function FormatZPL(strZPL: string): string;
    procedure LoadFromIE;
    procedure LoadFromHTM;
    procedure LoadZPLFile(strfilename : string);
    procedure PrintZPL;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure PrintSimpleZPL(strZPL: String);
    function isZPLValidated(strs : TStrings) : word;
    function CountLabels(str : String) : integer;
    function GetCaretPos : string;
    procedure Log(str : string);
    procedure CheckSomeLabels;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

/////////////////////////////////////////////////////////////////////////////
///
/// ������������� �� win-1251 � CP 866
///
function WinToDos(strSource: String): AnsiString;
var
  Ch: PAnsiChar;
begin
  Ch := AnsiStrAlloc(Length(strSource) + 1);
  CharToOem(PChar(strSource), Ch);
  Result := StrPas(Ch);
  StrDispose(Ch)
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������������� �� CP 866 � win-1251
///
function DosToWin(strSource: AnsiString): AnsiString;
var
  Ch: PAnsiChar;
begin
  Ch := AnsiStrAlloc(Length(strSource) + 1);
  OemToAnsi(PAnsiChar(strSource), Ch);
  Result := StrPas(Ch);
  StrDispose(Ch)
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������������� �� win-1251 � KOI8-R
///
function ANSI2KOI8R(S: string): string;
var
  Ansi_CODE, KOI8_CODE: string;
  i: integer;
begin
  KOI8_CODE := '���������������������������������������������������������������ї�';
  ANSI_CODE := '������������������������������������������������������������������';
  Result := S;
  for i := 1 to Length(Result) do
    if Pos(Result[i], ANSI_CODE) > 0 then
      Result[i] := KOI8_CODE[Pos(Result[i], ANSI_CODE)];
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������������� �� KOI8-R � win-1251
///
function KOI8ANSI(S: string): string;
var
  Ansi_CODE, KOI8_CODE: string;
  i: integer;
begin
  KOI8_CODE := '������������������������������������������������������������������';
  ANSI_CODE := '���������������������������������������������������������������ї�';
  Result := S;
  for i := 1 to Length(Result) do
    if Pos(Result[i], ANSI_CODE) > 0 then
    Result[i] := KOI8_CODE[Pos(Result[i], ANSI_CODE)];
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������������� �� win-1251 � KOI
///
function WinToKoi(Str: string): string;
var
  i, j, Index: Integer;
begin
  Result := '';
  for i := 1 to Length(Str) do begin
    Index := -1;
    for j := Low(Win) to High(Win) do
      if Win[j] = Str[i] then begin
        Index := j;
        Break;
      end;
      if Index = -1 then
        Result := Result + Str[i]
      else
        Result := Result + Koi[Index];
  end; // for i
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������������� �� KOI � win-1251
///
function KoiToWin(Str: string): string;
var
  i, j, Index: Integer;
begin
  Result := '';
  for i := 1 to Length(Str) do begin
    Index := -1;
    for j := Low(Win) to High(Win) do
      if Koi[j] = Str[i] then begin
        Index := j;
        Break;
      end;
      if Index = -1 then
        Result := Result + Str[i]
      else
        Result := Result + Win[Index];
  end; // for i
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ���������� MessageDlg � �������������� ��������
///
function RusMessageDialog(const Msg: string; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; Captions: array of string): Integer;
var
  aMsgDlg: TForm;
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
  aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons);
  captionIndex := 0;
  // ������� �� �������� � �������
  for i := 0 to aMsgDlg.ComponentCount - 1 do begin
    // ���� ������
    if (aMsgDlg.Components[i] is TButton) then begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      // ��������� ����� ��������� �� ������ ������� ����������
      dlgButton.Caption := Captions[CaptionIndex];
      inc(CaptionIndex);
    end;
  end;
  Result := aMsgDlg.ShowModal;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "����������� -> ��������� ������� -> ���� Code 39"
///
procedure TForm1.Code391Click(Sender: TObject);
begin
  PrintSimpleZPL(CODE39_TEST_ZPL);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// �������� ������ "�������� ZPL" � ������ ������������ Internet Explorer
///
procedure TForm1.CreateExplorerButton;
var
  Reg: TRegistry;
  ProgramPath: string;
  RegKeyPath: string;
begin
  ProgramPath := Application.ExeName;
  Reg := TRegistry.Create;
  try
    with Reg do begin
      RootKey := HKEY_LOCAL_MACHINE;
      RegKeyPath := 'Software\Microsoft\Internet Explorer\Extensions';
      OpenKey(RegKeyPath + TagID, True);
      WriteString('ButtonText', '�������� ZPL');
      WriteString('MenuText', 'Your program Menu text');
      WriteString('MenuStatusBar', 'Run Script');
      WriteString('ClSid', '{1FBA04EE-3024-11d2-8F1F-0000F87ABD16}');
      WriteString('Default Visible', 'Yes');
      WriteString('Exec', ProgramPath);
      WriteString('HotIcon', ProgramPath + ',4');
      WriteString('Icon', ProgramPath + ',4');
    end
  finally
    Reg.CloseKey;
    Reg.Free;
  end; //try
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ����� ������ � ���� ���������
///
procedure TForm1.Log(str : string);
begin
  with ListBox1 do begin
    Items.Add(FormatDateTime('[hh:mm:ss] ', Now()) + str);
    TopIndex := Items.Count - 1;
  end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ����� ����� � ������� Memo1
/// �������� ���������� �������
///
procedure TForm1.Memo1Click(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := GetCaretPos;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������� � ������� Memo1
/// �������� ���������� �������
///
procedure TForm1.Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  StatusBar1.Panels[1].Text := GetCaretPos;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// �������������� ZPL
/// ����������� ��������� ����� (������ ������ - � ������� "$")
///
function TForm1.FormatZPL(strZPL: string): string;
var
  i: longint;
begin
  if bFormatZPL then begin
    for i := length(strZPL) downto 2 do
      if strZPL[i] = '$' then insert(#13 + #10, strZPL, i);
    Log('����� �������������� (����������� �������� �����)');
  end;
  FormatZPL := strZPL;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ����������� ����� ���������� ��
/// ������������ ��� �������� ������ �� �������
///
function FileCopy(Source, Dest: string): boolean;
var
  SourceFile, DestFile: TFileStream;
begin
  Result := false;
  try
    try
      // Open the source file
      SourceFile := TFileStream.Create(Source, fmOpenRead + fmShareDenyWrite);
      try
        // Open the destination file
        DestFile := TFileStream.Create(Dest, fmCreate);
        // Copy the entire source file to the destination
        DestFile.CopyFrom(SourceFile, 0);
        Result := True;
      finally
        // close destination
        DestFile.Free;
      end;
    finally
      // close source
      SourceFile.Free;
    end;
    // Trap all errors
  except
  end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "��������� -> DOS => WIN"
///
procedure TForm1.DOSWIN1Click(Sender: TObject);
begin
  Memo1.Lines.Text := DosToWin(Memo1.Lines.Text);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "���� -> ������"
///
procedure TForm1.Dsjl1Click(Sender: TObject);
begin
  PrintZPL;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� �������� ����������
/// ������
///
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeleteFile(COMMAND_FILENAME);
  DeleteFile(PRINT_FILENAME);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� �������� ������� �����
///
procedure TForm1.FormCreate(Sender: TObject);
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\zplprint.ini');
  SetCurrentDir(ExtractFilePath(Application.ExeName) + '\');
  strCurrentFilename := '';
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ����������� ������� �����
/// ������������� �������� ZPL
///
procedure TForm1.FormShow(Sender: TObject);
begin
  LoadSettings;
  if bRegisterIEButton then CreateExplorerButton;
  if ParamCount <> 0 then LoadZPLFile(ParamStr(1))
  else if bStartupSearchIE then LoadFromIE;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ���������� ��������
///
procedure TForm1.SaveSettings;
begin
  with Ini do begin
    WriteString('Printer', 'Path', frmSettings.Edit1.Text);
    WriteBool('ZPL', 'VALIDATE_ZPL_ON_LOAD', frmSettings.CheckBox2.Checked);
    WriteString('ZPL', 'VALID_ZPL_CHECKER_STRING', frmSettings.Edit3.Text);
    WriteString('ZPL', 'LOAD_FONTS_ZPL_COMMAND', frmSettings.Edit2.Text);
    WriteBool('Internet Explorer', 'RegisterButton', frmSettings.CheckBox3.Checked);
    WriteBool('Internet Explorer','FormatZPLOnLoad', frmSettings.CheckBox1.Checked);
    WriteBool('Internet Explorer','StartupIESerach', frmSettings.CheckBox4.Checked);
    WriteBool('General','AccociateWithZPLFiles', frmSettings.CheckBox5.Checked);
    WriteBool('General','ShowAfterPrint', frmSettings.CheckBox6.Checked);
    WriteString('Printer', 'Copies', frmSettings.Edit4.Text);
  end; // with Ini
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "������� ���� ���������"
///
procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  Panel1.Hide;
  N16.Checked := False;
end;

procedure TForm1.StatusBar1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

/////////////////////////////////////////////////////////////////////////////
///
/// �������� ��������
///
procedure TForm1.LoadSettings;
begin
  with Ini do begin
    strPrinterPath := ReadString('Printer', 'Path', DEFAULT_PRINTER);
    StatusBar1.Panels[0].Text := '�������: ' + strPrinterPath;
    bValidateZPL := ReadBool('ZPL', 'VALIDATE_ZPL_ON_LOAD', True);
    strChecker := ReadString('ZPL', 'VALID_ZPL_CHECKER_STRING', VALID_ZPL_CHECKER_STRING);
    strLoadFonts := ReadString('ZPL', 'LOAD_FONTS_ZPL_COMMAND', LOAD_FONTS_ZPL_COMMAND);
    bRegisterIEButton := ReadBool('Internet Explorer', 'RegisterButton', True);
    bFormatZPL := ReadBool('Internet Explorer','FormatZPLOnLoad', True);
    bStartupSearchIE := ReadBool('Internet Explorer','StartupIESerach', True);
    bAssocFiles := ReadBool('General','AccociateWithZPLFiles', False);
    bShowAfterPrint := ReadBool('General','ShowAfterPrint', True);
    iZPLCopies := ReadInteger('Printer', 'Copies', StrToInt(frmSettings.Edit4.Text));
  end; // with Ini
  with frmSettings do begin
    Edit1.Text := strPrinterPath;
    CheckBox2.Checked := bValidateZPL;
    Edit3.Text := strChecker;
    Edit2.Text := strLoadFonts;
    CheckBox3.Checked := bRegisterIEButton;
    CheckBox1.Checked := bFormatZPL;
    CheckBox4.Checked := bStartupSearchIE;
    CheckBox5.Checked := bAssocFiles;
    CheckBox6.Checked := bShowAfterPrint;
    Edit4.Text := IntToStr(iZPLCopies);
  end; // with frmSettings
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "���� -> �������... -> HTM"
///
procedure TForm1.HTM1Click(Sender: TObject);
begin
  LoadFromHTM;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������ ZPL �� Memo1
///
procedure TForm1.PrintZPL;
var
  slSubst, slBuffer : TStringList;
  i, j, iZPLLength : longint;
begin
  Log('���������� ����� ��� ������');
  if iZPLCopies > 1 then begin
    if isZPLValidated(Memo1.Lines) > zplUNKNOWN then begin
      Log('������������� ����� �������� (' + IntToStr(iZPLCopies) + ' ���.)');
      try
        slBuffer := TStringList.Create;
        slSubst := TStringList.Create;
        for i := 0 to Memo1.Lines.Count - 1 do begin
          slBuffer.Add(Memo1.Lines.Strings[i]);
          if Pos('^XA', Memo1.Lines.Strings[i]) <> 0 then slSubst.Clear;
          slSubst.Add(Memo1.Lines.Strings[i]);
          if Pos(' ^XZ', Memo1.Lines.Strings[i]) <> 0 then begin
            for j := 2 to iZPLCopies do slBuffer.AddStrings(slSubst);
          end; // if Pos(' ^XZ')
        end; // for i
        slBuffer.SaveToFile(PRINT_FILENAME, TEncoding.UTF8);
      finally
        slSubst.Free;
        slBuffer.Free;
      end;
    end; // if isZPLValidated
  end
  else Memo1.Lines.SaveToFile(PRINT_FILENAME, TEncoding.UTF8);
  Log('�������� �������');
  try
    slSubst := TStringList.Create;
    slSubst.Add(strLoadFonts);
    slSubst.SaveToFile(COMMAND_FILENAME, TEncoding.UTF8);
  finally
    slSubst.Free;
  end;
  FileCopy(COMMAND_FILENAME, strPrinterPath);
  Log('������...');
  FileCopy(PRINT_FILENAME, strPrinterPath);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// �������� ZPL �� HTM-����� � Memo1
///
procedure TForm1.LoadFromHTM;
var
  slBuffer, slEncoded: TStringList;
  iStart, i: longint;
begin
  OpenDialog1.Filter := '����� HTM (*.htm)|*.htm';
  if OpenDialog1.Execute then
  begin
    try
      slBuffer := TStringList.Create;
//      slBuffer.LoadFromFile(OpenDialog1.FileName, TEncoding.ASCII);
      slBuffer.LoadFromFile(OpenDialog1.FileName);
      Log('��������� ����� ' + OpenDialog1.FileName);
      iStart := 0;
      while slBuffer[iStart] <> '<body>' do inc(iStart);
      i := iStart + 1;
      try
        slEncoded := TStringList.Create;
        while slBuffer[i] <> '</body>' do
        begin
          if slBuffer[i] <> '' then
            slEncoded.Add(AnsiToUtf8(slBuffer[i])); ;
          inc(i);
        end; // while slBuffer[i]
        slEncoded.SaveToFile(PRINT_FILENAME, TEncoding.UTF8);
        Memo1.Lines.Clear;
        Memo1.Lines := slEncoded;
        Log('���� ���������. ��� ZPL �������� � ��������');
        Caption := Application.Title + ' [' + OpenDialog1.FileName + ']';
        StatusBar1.Panels[2].Text := '';
        strCurrentFilename := '';
      finally
        slEncoded.Free;
      end; // try
    finally
      slBuffer.Free;
    end; // try
  end; // if OpenDialog1end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ZPL
/// ����� ����������� ������, ����������� ���������
///
function TForm1.isZPLValidated(strs : TStrings) : word;
var
  i: longint;
begin
  if bValidateZPL then begin
    isZPLValidated := zplUNKNOWN;
    for i := 0 to strs.Count - 1 do begin
      // ���������� ��������� ��������� ������
      if Pos(strChecker, strs.Strings[i]) <> 0 then isZPLValidated := zplDOS;
      if AnsiPos(WinToDos(strChecker), strs.Strings[i]) <> 0 then isZPLValidated := zplWIN;
    end;
  end
  // �� ��������� (��� ��������) ������� ��������� ��� DOS
  else isZPLValidated := zplDOS;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "��������� -> KOI8 => ANSI"
///
procedure TForm1.KOI8ANSI1Click(Sender: TObject);
begin
  Memo1.Lines.Text := KOI8ANSI(Memo1.Lines.Text);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "��������� -> KOI => WIN"
///
procedure TForm1.KOIWIN1Click(Sender: TObject);
begin
  Memo1.Lines.Text := KoiToWin(Memo1.Lines.Text);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "�������� �� ������ ������"
///
procedure TForm1.ToolButton10Click(Sender: TObject);
begin
  Memo1.PasteFromClipboard;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "�������� �� Internet Explorer"
///
procedure TForm1.ToolButton12Click(Sender: TObject);
begin
  LoadFromIE;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "���������"
///
procedure TForm1.ToolButton14Click(Sender: TObject);
begin
  frmSettings.ShowModal;
  SaveSettings;
  LoadSettings;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "�������� ��������� ��������"
///
procedure TForm1.ToolButton18Click(Sender: TObject);
begin
  CheckSomeLabels;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "������� ����"
///
procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if Memo1.Lines.Text <> '' then if RusMessageDialog(
    '������� ����� ZPL? ��� ������������ ��������� ����� �������.',
    mtConfirmation, mbYesNo, ['��', '������']) = mryes
  then begin
    Memo1.Lines.Clear;
    strCurrentFilename := '';
    StatusBar1.Panels[2].Text := '';
    Caption := Application.Title + ' *';
    N29.Enabled := false;
    ToolButton18.Enabled := false;
    Log('�������� ������ �����');
  end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "��������� ����"
///
procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  if strCurrentFilename = '' then begin
    if SaveDialog1.Execute then begin
      Memo1.Lines.SaveToFile(SaveDialog1.Filename, TEncoding.UTF8);
      Log('����� ZPL ������� � ���� ' + SaveDialog1.Filename
        + ' � ��������� Unicode (UTF-8)');
      strCurrentFilename := SaveDialog1.FileName;
      Caption := Application.Title + ' [' + strCurrentFilename + ']';
    end;
  end else begin
    Memo1.Lines.SaveToFile(strCurrentFilename, TEncoding.UTF8);
    Log('����� ZPL ������� � ���� ' + strCurrentFilename
      + ' � ��������� Unicode (UTF-8)');
  end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "������"
///
procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  PrintZPL;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "�������� � ����� ������"
///
procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  Memo1.CutToClipboard;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "���������� �� ������ ������"
///
procedure TForm1.ToolButton9Click(Sender: TObject);
begin
  Memo1.CopyToClipboard;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "��������� -> WIN => KOI"
///
procedure TForm1.Unicode1Click(Sender: TObject);
begin
  Memo1.Lines.Text := WinToKoi(Memo1.Lines.Text);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "��������� -> ANSI => KOI8-R"
///
procedure TForm1.WINDOS1Click(Sender: TObject);
begin
  Memo1.Lines.Text := ANSI2KOI8R(Memo1.Lines.Text);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "��������� -> WIN => DOS"
///
procedure TForm1.WINDOS2Click(Sender: TObject);
begin
  Memo1.Lines.Text := WinToDos(Memo1.Lines.Text);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "���� -> �������... -> ZPL"
///
procedure TForm1.ZPL1Click(Sender: TObject);
begin
  OpenDialog1.Filter := '����� ZPL (*.zpl)|*.zpl';
  if OpenDialog1.Execute then begin
    LoadZPLFile(OpenDialog1.FileName);
    StatusBar1.Panels[2].Text := '�������� : ' + IntToStr(CountLabels(Memo1.Lines.Text));
  end; // if OpenDialog1.
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������� ZPL �� Internet Explorer � Memo1
///
procedure TForm1.LoadFromIE;
var
  ShellWindow: IShellWindows;
  WB: IWebbrowser2;
  spDisp: IDispatch;
  IDoc1: IHTMLDocument2;
  i, k: Integer;
  slBuffer: TStringList;
  bValid: boolean;
  zplFlag, msgResult : word;
begin
  ShellWindow := CoShellWindows.Create;
  // ������� �� �������� �����
  for k := 0 to ShellWindow.Count do
  begin
    spDisp := ShellWindow.Item(k);
    if spDisp = nil then
      Continue;
    spDisp.QueryInterface(IWebbrowser2, WB);
    if WB <> nil then
    begin
      WB.Document.QueryInterface(IHTMLDocument2, IDoc1);
      if IDoc1 <> nil then
      begin
        WB := ShellWindow.Item(k) as IWebbrowser2;
        try
          slBuffer := TStringList.Create;
          slBuffer.Add(AnsiToUtf8((WB.Document as IHTMLDocument2).body.innerText));
          // ���� �������� ZPL, �� �������� � Memo
          zplFlag := isZPLValidated(slBuffer);
          if zplFlag <> zplUNKNOWN then begin
            msgResult := RusMessageDialog('������ ��� ��������, ��������� ��� ������.',
              mtInformation, mbYesNoCancel, ['�������', '������', '������']);
            if (msgResult = mrYes) or (msgResult = mrNo) then begin
              Memo1.Lines.Clear;
              if zplFlag = zplDOS then begin
                Log('��������� ��������� ������ : ��������� (DOS)');
                Memo1.Lines.Add(FormatZPL(AnsiToUtf8((WB.Document as IHTMLDocument2).body.innerText)));
                Log('����� ������������� � Unicode (UTF-8)');
              end;
              if zplFlag = zplWIN then begin
                Log('��������� ��������� ������ : ��������� (Windows)');
                Memo1.Lines.Add(FormatZPL(AnsiToUtf8(DosToWin((WB.Document as IHTMLDocument2).body.innerText))));
                Log('����� ��������������� ������������� � DOS (IMB866) � Unicode (UTF-8)');
              end;
              Caption := Application.Title + ' [Internet Explorer]';
              Log('��� �������� �� Internet Explorer �������� �������.');
              strCurrentFilename := '';
              if msgResult = mrNo then begin
                PrintZPL;
                if not(bShowAfterPrint) then Close;
              end; // if msgResult = mrNo
              StatusBar1.Panels[2].Text := '�������� : ' + IntToStr(CountLabels(Memo1.Lines.Text));
              N29.Enabled := true;
              ToolButton18.Enabled := true;
            end;
          end // if zplFlag <> zplUNKNOWN
          else Log('� Internet Explorer �� ������ ��� ��������, ��������� ��� ������.'
            + ' ��������, ��������� �������� ���������, ���� ����� � �������� �� �������� ZPL-�����');
        finally
          slBuffer.Free;
        end; // try
      end; // if iDoc1 <> nil
    end; // if WB <> nil
  end; // for k
  with Memo1 do begin
    Perform(WM_VScroll, SB_TOP, 0);
    Perform(WM_HScroll, SB_LEFT, 0);
  end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������� ZPL �� �����
///
procedure TForm1.LoadZPLFile(strFileName : string);
begin
  strCurrentFilename := strFileName;
  Memo1.Lines.LoadFromFile(strFileName, TEncoding.UTF8);
  Log('�������� ZPL �� ����� ' + strFileName);
  Caption := Application.Title + ' [' + strFileName + ']';
  StatusBar1.Panels[2].Text := '';
  with Memo1 do begin
    Perform(WM_VScroll, SB_TOP, 0);
    Perform(WM_HScroll, SB_LEFT, 0);
  end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "���� -> ��������� ���..."
///
procedure TForm1.N11Click(Sender: TObject);
begin
  if SaveDialog1.Execute then begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName + '.zpl', TEncoding.UTF8);
    Log('����� ZPL ������� � ���� ' + SaveDialog1.FileName
      + '.zpl � ��������� Unicode (UTF-8)');
    strCurrentFilename := OpenDialog1.FileName + '.zpl';
  end; // if SaveDialog1.
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "���� -> �����"
///
procedure TForm1.N14Click(Sender: TObject);
begin
  Close;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������� ������ "������� ���� -> ���������� HTM"
///
procedure TForm1.N15Click(Sender: TObject);
begin
  LoadFromHTM;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "��� -> ���������"
///
procedure TForm1.N16Click(Sender: TObject);
begin
  N16.Checked := not(N16.Checked);
  Panel1.Visible := N16.Checked;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ������ ������� ZPL-�������
///
procedure TForm1.PrintSimpleZPL(strZPL: String);
var
  slToPrint: TStringList;
begin
  try
    slToPrint := TStringList.Create;
    slToPrint.Add(strZPL);
    slToPrint.SaveToFile(COMMAND_FILENAME, TEncoding.UTF8);
  finally
    slToPrint.Free;
  end;
  Log('���������� �� �������: ' + strZPL);
  FileCopy(COMMAND_FILENAME, strPrinterPath);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "����������� -> ��������� ������� -> ������ ������������� �������"
///
procedure TForm1.N23Click(Sender: TObject);
begin
  PrintSimpleZPL(LIST_FONTS_ZPL);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "������ -> �������� �������� �����"
///
procedure TForm1.N24Click(Sender: TObject);
begin
  Memo1.Lines.Text := FormatZPL(Memo1.Lines.Text);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "������ -> �������� ��������"
///
procedure TForm1.N26Click(Sender: TObject);
var
  Line, i, j, l: Integer;
begin
  with Memo1 do begin
    Line := Perform(EM_LINEFROMCHAR, SelStart, 0);
    for i := Line downto 0 do begin
      if Pos('^XA', Lines.Strings[i]) <> 0 then break;
    end; // for i
    SelStart := Perform(EM_LINEINDEX, i, 0);
    l := 0;
    for j := i to Lines.Count - 1 do begin
      l := l + Length(Lines[j]) + 2;
      if Pos(' ^XZ', Lines.Strings[j]) <> 0 then break;
    end; // for j
    SelLength := l;
  end;
end;

///////////////////////////////////////////////////////////////////////
///
/// ����� ����������� ��������, �������� ���������
///
procedure TForm1.CheckSomeLabels;
var
  strLabelNumber : string;
  i, j, k, iBeginPos, iEndPos, iLine : integer;
  slSelectedLabels, slBuffer : TStringList;
begin
  try
    slSelectedLabels := TStringList.Create;
    slBuffer := TStringList.Create;
    frmSelectLabels.CheckListBox1.Items.Clear;
    with Memo1 do begin
      for i := 0 to Lines.Count - 1 do begin
        iBeginPos := Pos(LABEL_NUBMER_STRING, Lines.Strings[i]);
        if iBeginPos <> 0 then begin
          iBeginPos := iBeginPos + Length(LABEL_NUBMER_STRING);
          iEndPos := Pos('^FS^FS', Lines.Strings[i]) - 1;
          strLabelNumber := '';
          for j := iBeginPos to iEndPos do strLabelNumber := strLabelNumber + Lines.Strings[i][j];
          k := frmSelectLabels.CheckListBox1.Items.Add(strLabelNumber);
          frmSelectLabels.CheckListBox1.Checked[k] := true;
        end; // if iBeginPos <> 0
      end; // for i
    end; // with Memo1
    frmSelectLabels.ShowModal;
    for i := 0 to frmSelectLabels.CheckListBox1.Items.Count - 1 do begin
      if frmSelectLabels.CheckListBox1.Checked[i]
        then slSelectedLabels.Add(frmSelectLabels.CheckListBox1.Items.Strings[i]);
    end; // for i

    Log('��������� �������� � �������� ' + slSelectedLabels.CommaText);
    with Memo1 do begin
      for j := 0 to slSelectedLabels.Count - 1 do begin
        for i := 0 to Lines.Count - 1 do begin
          if Pos(LABEL_NUBMER_STRING + slSelectedLabels[j], Lines[i]) <> 0 then iLine := i;
        end; // for i
        // ���� ������ ��������
        k := iLine;
        repeat
          k := k - 1;
        until Pos('^XA', Lines.Strings[k]) <> 0;
        // �������� �� ����� ��������
        repeat
          slBuffer.Add(Lines.Strings[k]);
          inc(k);
        until Pos('^XZ', Lines.Strings[k]) <> 0;
        slBuffer.Add(Lines.Strings[k]);
      end; // for j
      Lines := slBuffer;
      StatusBar1.Panels[2].Text := '�������� : ' + IntToStr(slSelectedLabels.Count);
    end; // with Memo1
  finally
    slBuffer.Free;
    slSelectedLabels.Free;
  end;
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ��������� ������ ������ ���� "������ -> �������� ��������� ��������"
///
procedure TForm1.N29Click(Sender: TObject);
begin
  CheckSomeLabels;
end;

///////////////////////////////////////////////////////////////////////
///
/// ������� ���������� ��������
///
function TForm1.CountLabels(str : String) : integer;
var
  subtext : String;
begin
  subtext := '^XZ';
  if (Length(subtext) = 0) or (Length(str) = 0) or (Pos(subtext, str) = 0) then Result := 0
  else
    Result := (Length(str) - Length(StringReplace(str, subtext, '', [rfReplaceAll]))) div
       Length(subtext);
end;

/////////////////////////////////////////////////////////////////////////////
///
/// ���������� ������� �������
///
function TForm1.GetCaretPos : string;
var
  LineNum, ColNum: Word;
begin
  LineNum := SendMessage(Memo1.Handle, EM_LINEFROMCHAR, -1, 0);
  ColNum := LoWord(SendMessage(Memo1.Handle, EM_GETSEL, 0, 0))
    - SendMessage(Memo1.Handle, EM_LINEINDEX, -1, 0);
  GetCaretPos := IntToStr(LineNum) + ':' + IntToStr(ColNum);
end;

end.

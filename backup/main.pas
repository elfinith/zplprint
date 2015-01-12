unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IniFiles, Registry, SHDocVw, MSHTML;

const
    VALID_ZPL_CHECKER_STRING = '${ ^FX Размеры бирки ^FS}';
    LOAD_FONTS_ZPL_COMMAND = '^XA^CW2,E:ARI000.FNT^FS^XZ';
    LOAD_FONTS_FILENAME = 'subst.zpl';
    DEFAULT_PRINTER = '\\otk-0394\GenericT';
    PRINT_FILENAME = 'temp.txt';
    TagID = '\{10954C80-4F0F-11d3-B17C-00C0DFE39736}\';

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    OpenDialog1: TOpenDialog;
    ListBox1: TListBox;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    SpeedButton3: TSpeedButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    SpeedButton4: TSpeedButton;
    Label14: TLabel;
    Label15: TLabel;
    GroupBox2: TGroupBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Ini : TIniFile;
    strChecker, strLoadFonts : String;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure CreateExplorerButton;
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
      WriteString('ButtonText', 'Печатать ZPL');
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
  end;
end;

function FormatZPL(strZPL : string) : string;
var
  i : longint;
begin
  for i := length(strZPL) downto 2 do
    if strZPL[i]='$' then insert(#13+#10, strZPL, i);
  FormatZPL := strZPL;
end;

function FileCopy(Source,Dest:string):boolean;
var
  SourceFile, DestFile : TFileStream;
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
        Result := true;
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


procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  ListBox1.Visible := CheckBox1.Checked;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  Ini.WriteString('Printer','Path',Edit1.Text);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeleteFile(LOAD_FONTS_FILENAME);
  DeleteFile(PRINT_FILENAME);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\zplprint.ini');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  with Ini do begin
    Edit1.Text := ReadString('Printer', 'Path', DEFAULT_PRINTER);
    strChecker := ReadString('ZPL', 'VALID_ZPL_CHECKER_STRING', VALID_ZPL_CHECKER_STRING);
    strLoadFonts := ReadString('ZPL', 'LOAD_FONTS_ZPL_COMMAND', LOAD_FONTS_ZPL_COMMAND);
  end; // with Ini
  CreateExplorerButton;
  SpeedButton4Click(Self);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  slSubst : TStringList;
begin
  ListBox1.Items.Add('Подготовка файла для печати');
  Memo1.Lines.SaveToFile(PRINT_FILENAME, TEncoding.UTF8);
  ListBox1.Items.Add('Загрузка шрифтов');
  try
    slSubst := TStringList.Create;
    slSubst.Add(strLoadFonts);
    slSubst.SaveToFile(LOAD_FONTS_FILENAME, TEncoding.UTF8);
  finally
    slSubst.Free;
  end;
  FileCopy(LOAD_FONTS_FILENAME, Edit1.Text);
  ListBox1.Items.Add('Печать');
  FileCopy(PRINT_FILENAME, Edit1.Text);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  slBuffer, slEncoded : TStringList;
  iStart, i : longint;
begin
  if OpenDialog1.Execute then begin
    try
      slBuffer := TStringList.Create;
      slBuffer.LoadFromFile(OpenDialog1.FileName, TEncoding.ASCII);
      ListBox1.Items.Add('Обработка файла');
      iStart := 0;
      while slBuffer[iStart] <> '<body>' do inc(iStart);
      i := iStart + 1;
      try
        slEncoded := TStringList.Create;
        while slBuffer[i] <> '</body>' do begin
          if slBuffer[i] <> '' then slEncoded.Add(AnsiToUtf8(slBuffer[i]));;
          inc(i);
        end; // while slBuffer[i]
        slEncoded.SaveToFile(PRINT_FILENAME, TEncoding.UTF8);
        Memo1.Lines.Clear;
        Memo1.Lines := slEncoded;
        ListBox1.Items.Add('Загружен файл ' + OpenDialog1.FileName);
      finally
        slEncoded.Free;
      end; // try
    finally
      slBuffer.Free;
    end; // try
  end; // if OpenDialog1end;
  SpeedButton1.Enabled := true;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  i : longint;
  bValid : boolean;
begin
  with Memo1 do begin
    Lines.Clear;
    PasteFromClipboard;
    Perform(WM_VScroll, SB_TOP,0);
    Perform(WM_HScroll, SB_LEFT,0);
  end;
  // проверка
  bValid := false;
  for i := 0 to Memo1.Lines.Count - 1 do begin
    if AnsiPos(strChecker, Memo1.Lines.Strings[i]) <> 0
      then bValid := true;
  end; // for i
  if bValid then SpeedButton1.Enabled := true
    else with ListBox1 do begin
      Items.Add('Неверный формат текста');
      Items.Add('Не обнаружена строка ' + strChecker);
    end;

end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  ShellWindow: IShellWindows;
  WB: IWebbrowser2;
  spDisp: IDispatch;
  IDoc1: IHTMLDocument2;
  i, k: Integer;
  slBuffer: TStringList;
  bValid : boolean;
begin
  ShellWindow := CoShellWindows.Create;
  // перебор по открытым окнам
  for k := 0 to ShellWindow.Count do begin
    spDisp := ShellWindow.Item(k);
    if spDisp = nil then Continue;
    spDisp.QueryInterface(iWebBrowser2, WB);
    if WB <> nil then begin
      WB.Document.QueryInterface(IHTMLDocument2, iDoc1);
      if iDoc1 <> nil then begin
        WB := ShellWindow.Item(k) as IWebbrowser2;
        try
          // если валидный ZPL, то помещаем в Memo
          slBuffer := TStringList.Create;
          slBuffer.Add(AnsiToUtf8((WB.Document as IHTMLDocument2).body.innerText));
          // проверка
          bValid := false;
          for i := 0 to slBuffer.Count - 1 do begin
            if AnsiPos(strChecker, slBuffer.Strings[i]) <> 0
              then bValid := true;
          end; // for i
          if bValid then begin
            if MessageDlg('Найден код этикеток, пригодный для печати. Загрузить его?', mtConfirmation,
              [mbyes, mbno], 0) = mryes then begin
                SpeedButton1.Enabled := true;
                Memo1.Lines.Clear;
                Memo1.Lines.Add(FormatZPL(AnsiToUtf8((WB.Document as IHTMLDocument2).body.innerText)));
                ListBox1.Items.Add('Загружен код этикеток');
              end; // if MessageDlg
          end; // if bValid
        finally
          slBuffer.Free;
        end; // try
      end; // if iDoc1 <> nil
    end; // if WB <> nil
  end; // for k
  if Memo1.Lines.Text = '' then ListBox1.Items.Add('Не найден код этикеток, пригодный для печати');
end;

end.

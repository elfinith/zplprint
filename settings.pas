unit Settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, ShlObj;

type
  TfrmSettings = class(TForm)
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Edit4: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

procedure Associate;
var
  s:string;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;

  Reg.OpenKey('.zpl\OpenWithProgids\', true);
  Reg.WriteString('ZPLPrint.zpl', '');

  Reg.OpenKey('\ZPLPrint.zpl\DefaultIcon\', true);
  s:=Application.ExeName+',0';
  Reg.WriteString('', s);

  Reg.OpenKey('\ZPLPrint.zpl\Shell\Open\', true);
  Reg.WriteString('', 'Открыть в Печать ZPL');

  Reg.OpenKey('command\', true);
  s := '"' + Application.ExeName + '" "%1"';
  Reg.WriteString('', s);

  Reg.Free;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure DeleteAssociate;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;

  reg.DeleteKey('.zpl');
  reg.DeleteKey('ZPLPrint.zpl');

  Reg.Free;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TfrmSettings.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSettings.CheckBox2Click(Sender: TObject);
begin
  Label3.Enabled := CheckBox2.Checked;
  Edit3.Enabled := CheckBox2.Checked;
end;

procedure TfrmSettings.CheckBox5Click(Sender: TObject);
begin
  if CheckBox1.Checked then Associate else DeleteAssociate;
end;

end.

unit selectlabels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons;

type
  TfrmSelectLabels = class(TForm)
    Button1: TButton;
    CheckListBox1: TCheckListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectLabels: TfrmSelectLabels;

implementation

{$R *.dfm}

procedure TfrmSelectLabels.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelectLabels.SpeedButton1Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do CheckListBox1.Checked[i] := true;
end;

procedure TfrmSelectLabels.SpeedButton2Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do CheckListBox1.Checked[i] := false;
end;

procedure TfrmSelectLabels.SpeedButton3Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to CheckListBox1.Items.Count - 1 do CheckListBox1.Checked[i] := not(CheckListBox1.Checked[i]);
end;

end.

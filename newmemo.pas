﻿unit newmemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

const
  KEYWORDLIST_SIZE = 1;
  KeywordList : array [0..KEYWORDLIST_SIZE] of String =
  ('^XA', '^XZ');

type
  // Interjected Class
  TMemo = class(stdctrls.TMemo)
  private
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure WMVScroll(var Message: TWMMove); message WM_VSCROLL;
    procedure WMMousewheel(var Message: TWMMove); message WM_MOUSEWHEEL;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      override;
  public
    PosLabel: TLabel;
    procedure Update_label;
    procedure GotoXY(mCol, mLine: Integer);
    function Line: Integer;
    function Col: Integer;
    function TopLine: Integer;
    function VisibleLines: Integer;
  end;


implementation

////////////////////////////////////////////////////////////////////////////////
// functions for managing keywords and numbers of each line of TMemo ///////////
////////////////////////////////////////////////////////////////////////////////
function IsSeparator(Car: Char): Boolean;
begin
  case Car of
    '.', ';', ',', ':', '¡', '!', '·', '"', '''', '^', '+', '-', '*', '/', '\', '¨', ' ',
    '`', '[', ']', '(', ')', 'º', 'ª', '{', '}', '?', '¿', '%', '=': Result := True;
    else
      Result := False;
  end;
end;
////////////////////////////////////////////////////////////////////////////////

function NextWord(var s: string; var PrevWord: string): string;
begin
  Result   := '';
  PrevWord := '';
  if s = '' then Exit;
  while (s <> '') and IsSeparator(s[1]) do
  begin
    PrevWord := PrevWord + s[1];
    Delete(s, 1,1);
  end;
  while (s <> '') and not IsSeparator(s[1]) do
  begin
    Result := Result + s[1];
    Delete(s, 1,1);
  end;
end;
////////////////////////////////////////////////////////////////////////////////

function IsKeyWord(s: string): Boolean;
var
  i : byte;
begin
  Result := False;
  if s = '' then Exit;
  for i := 0 to KEYWORDLIST_SIZE do begin
    if KeywordList[i] = s then Result := True;
  end;
end;
////////////////////////////////////////////////////////////////////////////////

function IsNumber(s: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(s) do
    case s[i] of
      '0'..'9':;
      else
        Exit;
    end;
  Result := True;
end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// New or overrided methods and properties for TMemo using Interjected Class ///
// Technique ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

function TMemo.VisibleLines: Integer;
begin
  Result := Height div (Abs(Self.Font.Height) + 2);
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.GotoXY(mCol, mLine: Integer);
begin
  Dec(mLine);
  SelStart  := 0;
  SelLength := 0;
  SelStart  := mCol + Self.Perform(EM_LINEINDEX, mLine, 0);
  SelLength := 0;
  SetFocus;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.Update_label;
begin
  if PosLabel = nil then Exit;
  PosLabel.Caption := '(' + IntToStr(Line + 1) + ',' + IntToStr(Col) + ')';
end;
////////////////////////////////////////////////////////////////////////////////

function TMemo.TopLine: Integer;
begin
  Result := SendMessage(Self.Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
end;
////////////////////////////////////////////////////////////////////////////////

function TMemo.Line: Integer;
begin
  Result := SendMessage(Self.Handle, EM_LINEFROMCHAR, Self.SelStart, 0);
end;
////////////////////////////////////////////////////////////////////////////////

function TMemo.Col: Integer;
begin
  Result := Self.SelStart - SendMessage(Self.Handle, EM_LINEINDEX,
    SendMessage(Self.Handle,
    EM_LINEFROMCHAR, Self.SelStart, 0), 0);
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.WMVScroll(var Message: TWMMove);
begin
  Update_label;
  Invalidate;
  inherited;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.WMSize(var Message: TWMSize);
begin
  Invalidate;
  inherited;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.WMMove(var Message: TWMMove);
begin
  Invalidate;
  inherited;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.WMMousewheel(var Message: TWMMove);
begin
  Invalidate;
  inherited;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.Change;
begin
  Update_label;
  Invalidate;
  inherited Change;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  Update_label;
  inherited KeyDown(Key, Shift);
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.KeyUp(var Key: Word; Shift: TShiftState);
begin
  Update_label;
  inherited KeyUp(Key, Shift);
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Update_label;
  inherited MouseDown(Button, Shift, X, Y);
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Update_label;
  inherited MouseUp(Button, Shift, X, Y);
end;
////////////////////////////////////////////////////////////////////////////////

procedure TMemo.WMPaint(var Message: TWMPaint);
var
  PS: TPaintStruct;
  DC: HDC;
  Canvas: TCanvas;
  i: Integer;
  X, Y: Integer;
  OldColor: TColor;
  Size: TSize;
  Max: Integer;
  s, Palabra, PrevWord: string;
begin
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  Canvas := TCanvas.Create;
  try
    OldColor         := Font.Color;
    Canvas.Handle    := DC;
    Canvas.Font.Name := Font.Name;
    Canvas.Font.Size := Font.Size;
    with Canvas do
    begin
      Max := TopLine + VisibleLines;
      if Max > Pred(Lines.Count) then Max := Pred(Lines.Count);

      //Limpio la sección visible
      Brush.Color := Self.Color;
      FillRect(Self.ClientRect);
      Y := 1;
      for i := TopLine to Max do
      begin
        X := 2;
        s := Lines[i];

        //Detecto todas las palabras de esta línea
        Palabra := NextWord(s, PrevWord);
        while Palabra <> '' do
        begin
          Font.Color := OldColor;
          TextOut(X, Y, PrevWord);
          GetTextExtentPoint32(DC, PChar(PrevWord), Length(PrevWord), Size);
          Inc(X, Size.cx);

          Font.Color := clBlack;
          if IsKeyWord(Palabra) then
          begin
            Font.Color := clHighlight;
            TextOut(X, Y, Palabra);
             {
             //Draw dot underline
             Pen.Color := clHighlight;
             Pen.Style := psDot;
             PolyLine([ Point(X,Y+13), Point(X+TextWidth(Palabra),Y+13)]);
             }
          end
          else if IsNumber(Palabra) then
          begin
            Font.Color := $000000DD;
            TextOut(X, Y, Palabra);
          end
          else
            TextOut(X, Y, Palabra);

          GetTextExtentPoint32(DC, PChar(Palabra), Length(Palabra), Size);
          Inc(X, Size.cx);

          Palabra := NextWord(s, PrevWord);
          if (s = '') and (PrevWord <> '') then
          begin
            Font.Color := OldColor;
            TextOut(X, Y, PrevWord);
          end;
        end;
        if (s = '') and (PrevWord <> '') then
        begin
          Font.Color := OldColor;
          TextOut(X, Y, PrevWord);
        end;

        s := 'W';
        GetTextExtentPoint32(DC, PChar(s), Length(s), Size);
        Inc(Y, Size.cy);
      end;
    end;
  finally
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
  Canvas.Free;
  inherited;
end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

end.

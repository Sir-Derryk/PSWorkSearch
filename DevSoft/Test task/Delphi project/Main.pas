unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,  Vcl.ActnMan,
  Vcl.ActnColorMaps, Vcl.ExtCtrls, MyCustomControl, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    DisplayLabel: TLabel;
    CancelButton: TButton;
    FirstCustomControl: TMyCustomControl;
    SecondCustomControl: TMyCustomControl;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    Edit1: TEdit;
    Edit2: TEdit;
    MyTimer: TTimer;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure DisplayFullString(Collisions1 : cardinal; Collisions2 : cardinal);
    procedure MyTimerTimer(Sender: TObject);
  private
    { Private declarations }
  protected

  public
    { Public declarations }
  end;



var
  MainForm: TMainForm;
  Collisions1: cardinal;
  Collisions2: cardinal;
  Direction1: string;
  Direction2: string;

implementation

{$R *.dfm}

procedure TMainForm.CancelButtonClick(Sender: TObject);
begin
MainForm.Close
end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
if StrToInt(Edit1.Text) > Updown1.Max Then Edit1.Text:=IntToStr(Updown1.Max);
if StrToInt(Edit1.Text) < Updown1.Min Then Edit1.Text:=IntToStr(Updown1.Min);
UpDown1.Position:=StrToInt(Edit1.Text);
FirstCustomControl.BallSpeed:=UpDown1.Position;
end;

procedure TMainForm.Edit2Change(Sender: TObject);
begin
if StrToInt(Edit2.Text) > Updown2.Max Then Edit2.Text:=IntToStr(Updown2.Max);
if StrToInt(Edit2.Text) < Updown2.Min Then Edit2.Text:=IntToStr(Updown2.Min);
UpDown2.Position:=StrToInt(Edit2.Text);
SecondCustomControl.BallSpeed:=UpDown2.Position;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FirstCustomControl:=TMyCustomControl.Create(Self);
  FirstCustomControl.Left := 6;
  FirstCustomControl.Top := 28;
  FirstCustomControl.BallColor := clRed;
  FirstCustomControl.BallSpeed := UpDown1.Position;
  FirstCustomControl.Radius := 3;
  SecondCustomControl:=TMyCustomControl.Create(Self);
  SecondCustomControl.Left := 282;
  SecondCustomControl.Top := 28;
  SecondCustomControl.BallColor := clGreen;
  SecondCustomControl.BallSpeed := UpDown2.Position;
  SecondCustomControl.Radius := 5;
  Collisions1 := 0;
  Collisions2 := 0;
  Direction1 := 'Bottom Right';
  Direction2 := 'Bottom Right';
  DisplayFullString(Collisions1, Collisions2);
  MyTimer:= TTimer.Create(self);
  MyTimer.Interval:= 100;
  MyTimer.OnTimer:= MyTimerTimer;
end;

procedure TMainForm.MyTimerTimer(Sender: TObject);
begin
  if (Collisions1<>FirstCustomControl.CollisionCount) or (Collisions2<>SecondCustomControl.CollisionCount) then
  begin
    Collisions1 := FirstCustomControl.CollisionCount;
    Collisions2 := SecondCustomControl.CollisionCount;
    DisplayFullString(Collisions1, Collisions2);
  end;
  if Direction1<>FirstCustomControl.Direction then
  begin
    ListBox1.Items.Add(TimeToStr(Now) + ' ' + Direction1 + ' -> ' + FirstCustomControl.Direction);
    Direction1 := FirstCustomControl.Direction;
  end;
  if Direction2<>SecondCustomControl.Direction then
    begin
    ListBox2.Items.Add(TimeToStr(Now) + ' ' + Direction2 + ' -> ' + SecondCustomControl.Direction);
    Direction2 := SecondCustomControl.Direction;
  end;
end;

procedure TMainForm.DisplayFullString (Collisions1 : cardinal; Collisions2 : cardinal);
var FirstString, SecondString : string;
begin
  FirstString := 'Ball #1: ' + IntToStr(Collisions1) + ' collision';
  if Collisions1 <> 1 then FirstString := FirstString + 's';
  SecondString := ', ball #2: ' + IntToStr(Collisions2) + ' collision';
  if Collisions2 <> 1 then SecondString := SecondString + 's';
  DisplayLabel.Caption:= FirstString + SecondString;
end;


end.

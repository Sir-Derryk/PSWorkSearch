unit Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.StdCtrls , Vcl.Forms,
  Vcl.ComCtrls, Vcl.Controls, Vcl.ActnColorMaps, Vcl.ExtCtrls, MyCustomControl;

type
  TMainForm = class(TForm)
    MyTimer: TTimer;
    FirstCustomControl: TMyCustomControl;
    SecondCustomControl: TMyCustomControl;
    CloseButton: TButton;
    SpeedUpDown1: TUpDown;
    SpeedUpDown2: TUpDown;
    SpeedEdit1: TEdit;
    SpeedEdit2: TEdit;
    DirectionListBox1: TListBox;
    DirectionListBox2: TListBox;
    DisplayLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure SpeedEdit1Change(Sender: TObject);
    procedure SpeedEdit2Change(Sender: TObject);
    procedure DisplayFullString(Collisions1 : cardinal; Collisions2 : cardinal);
    procedure MyTimerTimer(Sender: TObject);
  private
    { Private declarations }
  protected

  public
    { Public declarations }
  end;



var
  //Collisions number to display on change only
  Collisions1: cardinal;
  Collisions2: cardinal;
  //Directions to display on change
  Direction1: string;
  Direction2: string;
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.CloseButtonClick(Sender: TObject);
//Terminate the application
begin
Application.Terminate;
end;

procedure TMainForm.SpeedEdit1Change(Sender: TObject);
//Correct SpeedEdit and set speed of the first ball
var aCode : integer;
    SpeedEditValue : integer;
begin
//Check if SpeedEdit contains non-digit characters. If yes, set value to 0.
Val(SpeedEdit1.Text, SpeedEditValue, aCode);
if aCode<>0 then
begin
  SpeedEditValue := 0;
  SpeedEdit2.Text := IntToStr(SpeedEditValue);
end;
//Check if the SpeedEdit value is outside the range. If yes, set it to max or min.
if StrToInt(SpeedEdit1.Text) > SpeedUpdown1.Max Then SpeedEdit1.Text:=IntToStr(SpeedUpdown1.Max);
if StrToInt(SpeedEdit1.Text) < SpeedUpdown1.Min Then SpeedEdit1.Text:=IntToStr(SpeedUpdown1.Min);
SpeedUpDown1.Position:=StrToInt(SpeedEdit1.Text);
FirstCustomControl.BallSpeed := SpeedUpDown1.Position;
end;

procedure TMainForm.SpeedEdit2Change(Sender: TObject);
//Correct SpeedEdit and set speed of the second ball
var aCode : integer;
    SpeedEditValue : integer;
begin
//Check if SpeedEdit contains non-digit characters. If yes, set value to 0.
Val(SpeedEdit2.Text, SpeedEditValue, aCode);
if aCode<>0 then
begin
  SpeedEditValue := 0;
  SpeedEdit2.Text := IntToStr(SpeedEditValue);
end;
//Check if the SpeedEdit value is outside the range. If yes, set it to max or min.
if SpeedEditValue > SpeedUpdown2.Max Then SpeedEdit2.Text:=IntToStr(SpeedUpdown2.Max);
if SpeedEditValue < SpeedUpdown2.Min Then SpeedEdit2.Text:=IntToStr(SpeedUpdown2.Min);
SpeedUpDown2.Position:=StrToInt(SpeedEdit2.Text);
SecondCustomControl.BallSpeed := SpeedUpDown2.Position;
end;

procedure TMainForm.FormCreate(Sender: TObject);
//Create and initialize the form
begin
  //Initialize timer
  MyTimer.Interval:= 100;
  MyTimer.OnTimer:= MyTimerTimer;
  //Place and initialize the first custom control
  FirstCustomControl:=TMyCustomControl.Create(Self);
  FirstCustomControl.Left := 6;
  FirstCustomControl.Top := 28;
  FirstCustomControl.BallColor := clRed;
  FirstCustomControl.BallSpeed := SpeedUpDown1.Position;
  FirstCustomControl.BallRadius := 3;
  //Placed and initialize the second custom control
  SecondCustomControl:=TMyCustomControl.Create(Self);
  SecondCustomControl.Left := 282;
  SecondCustomControl.Top := 28;
  SecondCustomControl.BallColor := clGreen;
  SecondCustomControl.BallSpeed := SpeedUpDown2.Position;
  SecondCustomControl.BallRadius := 5;
  //Initialize and display collisions
  Collisions1 := 0;
  Collisions2 := 0;
  DisplayFullString(Collisions1, Collisions2);
  //Initialize direction
  Direction1 := 'Bottom Right';
  Direction2 := 'Bottom Right';
end;

procedure TMainForm.MyTimerTimer(Sender: TObject);
//Refresh controls on the timer
begin
  //If any of collisions number changed, refresh DisplayLabel
  if (Collisions1<>FirstCustomControl.CollisionCount) or (Collisions2<>SecondCustomControl.CollisionCount) then
  begin
    Collisions1 := FirstCustomControl.CollisionCount;
    Collisions2 := SecondCustomControl.CollisionCount;
    DisplayFullString(Collisions1, Collisions2);
  end;
  //If the first ball bounces off the wall, log direction change
  if Direction1<>FirstCustomControl.Direction then
  begin
    DirectionListBox1.Items.Add(TimeToStr(Now) + ' ' + Direction1 + ' -> ' + FirstCustomControl.Direction);
    Direction1 := FirstCustomControl.Direction;
  end;
  //If the second ball bounces off the wall, log direction change
  if Direction2<>SecondCustomControl.Direction then
    begin
    DirectionListBox2.Items.Add(TimeToStr(Now) + ' ' + Direction2 + ' -> ' + SecondCustomControl.Direction);
    Direction2 := SecondCustomControl.Direction;
  end;
end;

procedure TMainForm.DisplayFullString (Collisions1 : cardinal; Collisions2 : cardinal);
//Compose a string to display collisions
var FirstString, SecondString : string;
begin
  FirstString := 'Ball #1: ' + IntToStr(Collisions1) + ' collision';
  if Collisions1 <> 1 then FirstString := FirstString + 's';
  SecondString := ', ball #2: ' + IntToStr(Collisions2) + ' collision';
  if Collisions2 <> 1 then SecondString := SecondString + 's';
  DisplayLabel.Caption:= FirstString + SecondString;
end;


end.

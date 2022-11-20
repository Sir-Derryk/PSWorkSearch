unit MyCustomControl;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ActnColorMaps,
  WinTypes, Vcl.ExtCtrls, WinProcs, ES.PaintBox;

type
  TMyCustomControl = class(TPaintBox)
  private
    { Private declarations }
    aBallColor : cardinal;
    aBallToRight : boolean;
    aBallToBottom : boolean;
    aBallSpeed : byte;
    XCenter : word;
    YCenter : word;
    MaxWidth : word;
    MaxHeight : word;
    aRadius : byte;
    aBackColor : cardinal;
    aCollisionCount : cardinal;
    aDirection : string;
    MyTimer : TTimer;
    procedure MyTimerTimer(AOwner: TObject);
    function SetDirection(toRight : boolean; toBottom: boolean) : string;
  published

  protected

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BallColor : cardinal read aBallColor write aBallColor;
    property BallSpeed : byte read aBallSpeed write aBallSpeed;
    property Radius: byte read aRadius write aRadius;
    property CollisionCount : cardinal read aCollisionCount write aCollisionCount;
    property Direction : string read aDirection write aDirection;
  end;


procedure Register;
implementation
procedure Register;
begin
  RegisterComponents('Samples', [TMyCustomControl]);
end;
{ TMyCustomControl }
constructor TMyCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := AOwner AS TWinControl;
  MyTimer:= TTimer.Create(self);
  MyTimer.Interval:= 100;
  MyTimer.OnTimer:= MyTimerTimer;
  Width:= 250;
  Height:= 250;
  MaxWidth:=Width;
  MaxHeight:=Height;
  XCenter:= 100;
  YCenter:= 150;
  aBallToRight:=true;
  aBallToBottom:=true;
  aDirection := SetDirection (aBallToRight, aBallToBottom);
  aBackColor:=self.Color;
  aCollisionCount:=0;
end;


destructor TMyCustomControl.Destroy;
begin
  inherited Destroy;
end;

procedure TMyCustomControl.MyTimerTimer(AOwner: TObject);
Var Collisions : byte;
begin
  Collisions := 0;
  Self.Canvas.Brush.Color:=aBackColor;
  Self.Canvas.FillRect(Self.Canvas.ClipRect);
  if XCenter+(2*integer(aBallToRight)-1)*aBallSpeed+aRadius > MaxWidth then
  begin
    aBallToRight:= False;
    if Collisions = 0 then Collisions := 1;
    aDirection := SetDirection (aBallToRight, aBallToBottom);
  end;
  if XCenter+(2*integer(aBallToRight)-1)*aBallSpeed-aradius < 0 then
  begin
    aBallToRight:= True;
    if Collisions = 0 then Collisions := 1;
    aDirection := SetDirection (aBallToRight, aBallToBottom);
  end;
  if YCenter+(2*integer(aBallToBottom)-1)*aBallSpeed+aradius > MaxHeight then
  begin
    aBallToBottom:= False;
    if Collisions = 0 then Collisions := 1;
    aDirection := SetDirection (aBallToRight, aBallToBottom);
  end;
  if YCenter+(2*integer(aBallToBottom)-1)*aBallSpeed-aradius < 0 then
  begin
    aBallToBottom:= True;
    if Collisions = 0 then Collisions := 1;
    aDirection := SetDirection (aBallToRight, aBallToBottom);
  end;
  XCenter:=XCenter+(2*integer(aBallToRight)-1)*aBallSpeed;
  YCenter:=YCenter+(2*integer(aBallToBottom)-1)*aBallSpeed;
  Self.Canvas.Brush.Color:=aBallColor;
  Self.Canvas.Ellipse(Rect(XCenter-aradius, yCenter-aRadius, XCenter+aradius, YCenter+aradius));
  aCollisionCount:=aCollisionCount+Collisions;
end;

function TMyCustomControl.SetDirection(toRight, toBottom: boolean): string;
var aResult : string;
begin
if toBottom then aResult := 'Bottom ' else aResult := aResult + 'Top ';
if toRight then aResult :=  aResult + 'Right' else aResult := aResult + 'Left';
result := aResult;
end;

end.

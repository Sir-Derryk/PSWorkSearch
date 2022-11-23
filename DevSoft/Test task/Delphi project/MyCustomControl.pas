unit MyCustomControl;

interface
uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.ExtCtrls;

type
  TMyCustomControl = class(TPaintBox)
  private
    { Private declarations }
    //Properties
    aBallColor : cardinal;
    aBallSpeed : byte;
    aBallRadius : byte;
    aCollisionCount : cardinal;
    //Current position
    XCenter : word;
    YCenter : word;
    //Current direction
    aBallToRight : boolean;
    aBallToBottom : boolean;
    //Color to clear the canvas
    aBackColor : cardinal;
    //Timer to calculate the ball position
    MyTimer : TTimer;
    procedure MyTimerTimer(AOwner: TObject);
    //Get the ball direction
    function GetDirection : string;
  published

  protected

  public
    { Public declarations }
    property BallColor : cardinal read aBallColor write aBallColor;
    property BallSpeed : byte read aBallSpeed write aBallSpeed;
    property BallRadius: byte read aBallRadius write aBallRadius;
    property CollisionCount : cardinal read aCollisionCount write aCollisionCount;
    property Direction : string read GetDirection;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation
{ TMyCustomControl }
constructor TMyCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := AOwner AS TWinControl;
  //Initialize timer
  MyTimer:= TTimer.Create(self);
  MyTimer.Interval:= 100;
  MyTimer.OnTimer:= MyTimerTimer;
  //Set control size
  Width:= 250;
  Height:= 250;
  //Initialize variables
  XCenter:= 100;
  YCenter:= 150;
  aBallToRight:=true;
  aBallToBottom:=true;
  aBackColor:=self.Color;
  aCollisionCount:=0;
end;


destructor TMyCustomControl.Destroy;
begin
  MyTimer.Destroy;
  inherited Destroy;
end;

procedure TMyCustomControl.MyTimerTimer(AOwner: TObject);
//On timer redraw the ball
Var Collisions : byte;
begin
  //Initialize collisions count
  Collisions := 0;
  //Clear canvas
  Self.Canvas.Brush.Color:=aBackColor;
  Self.Canvas.FillRect(Self.Canvas.ClipRect);
  //Check if the ball is near one of the four wall.
  //If yes, then change direction and set collision counter to 1.
  if XCenter+(2*integer(aBallToRight)-1)*aBallSpeed+aBallRadius > Width then
  begin
    aBallToRight:= False;
    if Collisions = 0 then Collisions := 1;
  end;
  if XCenter+(2*integer(aBallToRight)-1)*aBallSpeed-aBallRadius < 0 then
  begin
    aBallToRight:= True;
    if Collisions = 0 then Collisions := 1;
  end;
  if YCenter+(2*integer(aBallToBottom)-1)*aBallSpeed+aBallRadius > Height then
  begin
    aBallToBottom:= False;
    if Collisions = 0 then Collisions := 1;
  end;
  if YCenter+(2*integer(aBallToBottom)-1)*aBallSpeed-aBallRadius < 0 then
  begin
    aBallToBottom:= True;
    if Collisions = 0 then Collisions := 1;
  end;
  //Calculate new position
  XCenter:=XCenter+(2*integer(aBallToRight)-1)*aBallSpeed;
  YCenter:=YCenter+(2*integer(aBallToBottom)-1)*aBallSpeed;
  //Draw the ball
  Self.Canvas.Brush.Color:=aBallColor;
  Self.Canvas.Ellipse(Rect(XCenter-aBallRadius, yCenter-aBallRadius, XCenter+aBallRadius, YCenter+aBallRadius));
  //Increasing colllisions count
  aCollisionCount:=aCollisionCount+Collisions;
end;

function TMyCustomControl.GetDirection: string;
//Get Direction property
var aResult : string;
begin
if aBallToBottom then aResult := 'Bottom ' else aResult := aResult + 'Top ';
if aBallToRight then aResult :=  aResult + 'Right' else aResult := aResult + 'Left';
result := aResult;
end;

end.

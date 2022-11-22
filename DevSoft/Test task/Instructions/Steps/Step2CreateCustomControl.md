# Step 2. Create a Custom Control
>**Note**
>
>This article applies to Embarcadero® Delphi 10.4 and may be inapplicable to other versions or development software.
>
>You can find the source code of this module application in the [MyCustomControl.pas](https://github.com/Sir-Derryk/PSWorkSearch/blob/main/DevSoft/Test%20task/Delphi%20project/MyCustomControl.pas) file in the GitHub repository.

As the second step in developing the application, you create a custom component based on **TPaintBox**. This means [creating a module](#create-a-module), defining [variables](#define-variables) and [properties](#define-properties), [overriding the constructor and the destructor](#override-constructor-and-destructor), and [implementing the flying ball](#implement-the-flying-ball).

## Create a Module

To create a module, follow these steps:

1. In the main menu, select **Component** -> **New Component...**
1. In the list, select **TPaintBox** and click **Next>>**.
1. Specify a class name (e.g. **MyCustomControl**).
1. Specify a unit name (e.g. **MyCustomControl.pas**) including the path. Then click **Next>>**.
1. Select **Create Unit** and click **Finish**.
1. In the main menu, select **Project** -> **Add to Project...**
1. Find the component file, select it and click **Open** to add the unit to the project.
1. Open the unit to edit.
1. As you are not going to register it as a component, delete the implementation and declaration of the **Register** procedure.

## Define Variables

Use variables to implement the flying ball. In the **private** section of the **type** clause, declare the following variables:

    //Properties
    aBallColor : cardinal;
    aBallSpeed : byte;
    aBallRadius : byte;
    aCollisionCount : cardinal;
    aDirection : string;
    //Current position
    XCenter : word;
    YCenter : word;
    //Current direction
    aBallToRight : boolean;
    aBallToBottom : boolean;
    //Color to clear the canvas
    aBackColor : cardinal;
    MyTimer : TTimer;
Several of them you use to implement [properties](#define-properties). The **MyTimer** variable initiates the [implementation of the flying ball](#implement-the-flying-ball). To initialize variables, [override the constructor](#override-constructor-and-destructor).

## Define Properties

Use properties to set up the ball's appearance (radius and color) and speed. Besides that, the main form reads properties to log the ball movement.
In the **public** section, declare the following properties:

      public
        { Public declarations }
        property BallColor : cardinal read aBallColor write aBallColor;
        property BallSpeed : byte read aBallSpeed write aBallSpeed;
        property BallRadius: byte read aBallRadius write aBallRadius;
        property CollisionCount : cardinal read aCollisionCount write aCollisionCount;
        property Direction : string read GetDirection;
The **Direction** property consists of two parts: horizontal and vertical directions. Declare and implement the following function to get the **Direction** property:

    function TMyCustomControl.GetDirection: string;
    //Get Direction property
    var aResult : string;
    begin
        if aBallToBottom then aResult := 'Bottom ' else aResult := aResult + 'Top ';
        if aBallToRight then aResult :=  aResult + 'Right' else aResult := aResult + 'Left';
        result := aResult;
    end;

## Override Constructor and Destructor

Use the constructor to initialize variables. To initialize the timer, you need a procedure to handle the **OnTimer** event. Declare and add to the **implementation** clause the **MyTimerTimer** procedure: `procedure MyTimerTimer(AOwner: TObject);`. Leave the procedure body empty.

Declare and implement the constructor. Do not miss running the inherited constructor:

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
In the destructor, destroy the timer and then call the inherited destructor:

    destructor TMyCustomControl.Destroy;
    begin
      MyTimer.Destroy;
      inherited Destroy;
    end;

## Implement the Flying Ball

To implement the flying ball, use a timer. Every 100ms, it initiates the **OnTimer** event. The event handler clears the canvas, calculates a new ball position, and draws a ball.

To realize if a collision has occurred, calculate new coordinates of all the ball boundaries, considering the radius of the ball. Then compare them with 0 and the maximum values for the X and Y. If there is a collision with one or two walls, reverse the corresponding direction(s). Note that if the ball hits a corner (i.e. collides with two walls), the collision counter still increases by one.

To calculate a new position, use the current coordinates of the ball center **XCenter** and **YCenter**, directions **aBallToRight** and **aBallToBottom**, and **aBallSpeed**.

You have already declared, created, and initialized the timer. Now implement the **MyTimerTimer** event handler:

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

## See also

[Next step: Step 3. Add Custom Control Instances to the Form and Set up Interaction](Step3AddCCToFormAndSetUpInteraction)

[Previous step: Step 1. Create a Form](Step1CreateForm)

[Back to the overview topic](..\CreateApp)
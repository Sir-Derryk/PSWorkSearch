# Step 3. Add Custom Control Instances to the Form and Set up Interaction

>**Note**
>
>This article applies to Embarcadero® Delphi 10.4 and may be inapplicable to other versions or development software.
>
>You can find the source code of this tutorial application in the GitHub [repository](https://github.com/Sir-Derryk/PSWorkSearch/tree/main/DevSoft/Test%20task/Delphi%20project).

As the third step in developing the application, you [add custom control instances](#add-and-initialize-the-custom-controls-instances) to the form and set up the interaction between these instances and the main form:

* [Allow changing the ball's speed](#allow-changing-the-balls-speed)
* [Implement the logging information about the balls' movement](#implement-the-logging-information-about-the-balls-movement)  
To schedule getting information about the balls' movement, [add a timer](#add-and-initialize-a-timer).

## Add and Initialize the Custom Controls Instances

To allow the main form access to the custom controls, add the module name in the **uses** clause:

    uses
        System.SysUtils, System.Classes, Vcl.Graphics, Vcl.StdCtrls , Vcl.Forms,
        Vcl.ComCtrls, Vcl.Controls, Vcl.ActnColorMaps, Vcl.ExtCtrls, MyCustomControl;

Then add the declaration of the variables in the **TMainForm** type declaration:

    type
        TMainForm = class(TForm)
            FirstCustomControl: TMyCustomControl;
            SecondCustomControl: TMyCustomControl;

To create and initialize the custom control instances, add the following lines to the beginning of the **TMainForm.FormCreate** procedure:

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

## Allow changing the balls' speed

To change the ball's speed when the appropriate control changes, add the following line to the end of the **TMainForm.SpeedEdit1Change** procedure

    FirstCustomControl.BallSpeed := SpeedUpDown2.Position;
and a similar line to the end of the **TMainForm.SpeedEdit2Change** procedure

    SecondCustomControl.BallSpeed := SpeedUpDown2.Position;

## Add and Initialize a Timer

Add a timer to schedule getting information about the balls' movement. To do this, add the **TTimer** control to the main form.

To initialize the timer instance, add the following lines to the beginning of the **TMainForm.FormCreate** procedure:

    //Initialize timer
    MyTimer.Interval:= 100;
    MyTimer.OnTimer:= MyTimerTimer;

## Implement the Logging Information about the Balls' movement

To implement the logging information about the ball's movement, create a handler of the **OnTimer** event of the **MyTimerTimer**. To do this, declare and add to the **implementation** clause the **MyTimerTimer** procedure: `procedure MyTimerTimer(AOwner: TObject);`.

    procedure TMainForm.MyTimerTimer(Sender: TObject);
    //Refresh controls on the timer
    begin

    end;
The procedure checks if there are any changes in the movement log and refreshes an appropriate control:

* If the collision number changes for any of the balls, it refreshes the stored values and calls the **DisplayFullString** procedure to display changes
* If any ball bounces off the wall, it logs the direction change in the appropriate list control.

This is the body of the **TMainForm.MyTimerTimer** procedure:

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

## See also

[Previous step: Step 2. Create a Custom Control](Step2CreateCustomControl)

[Back to the overview topic](..\CreateApp)
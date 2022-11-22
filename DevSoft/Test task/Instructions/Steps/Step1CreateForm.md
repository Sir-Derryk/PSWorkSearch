# Step 1. Create a Form

>**Note**
>
>This article applies to Embarcadero® Delphi 10.4 and may be inapplicable to other versions or development software.
>
>You can find the source code of this form in the [Main.pas](https://github.com/Sir-Derryk/PSWorkSearch/blob/main/DevSoft/Test%20task/Delphi%20project/Main.pas) and [Main.dfm](https://github.com/Sir-Derryk/PSWorkSearch/blob/main/DevSoft/Test%20task/Delphi%20project/Main.dfm) files in the GitHub repository.

As the first step in developing the application, you will [create a form](#create-a-form). Also, you will add controls that [change the speed](#add-controls-to-change-a-speed) and [display the log of the balls' movement](#add-controls-to-display-the-log-of-the-balls-movement). Then you [declare and initialize variables](#declare-and-initialize-variables). The result should be like this:

![The main form design](..\Images\MainFormDesign.png)

Later (in [step 3](Step3AddCCToFormAndSetUpInteraction)) you will configure the interaction of the form controls and the custom controls that display balls.

## Create a Form

To develop the application, create a Windows project. By default, the project contains the form you will use. Set up the form dimension and add the **Close** button.

To do this, follow these steps:

1. Create a Windows VCL project. The main form of the application will open to edit.
1. Resize the form if needed. You may use the same dimensions as in the [example](https://github.com/Sir-Derryk/PSWorkSearch/blob/main/DevSoft/Test%20task/Delphi%20project/Main.dfm).
1. Add a button (**TButton**) in the right-down corner of the form.
1. Rename the button to **Close** and add the **OnClick** event handler for it. The handler should stop the application:

        Application.Terminate;  

## Add Controls to Change a Speed

To change a speed use a pair of controls for each ball: edit control to display the current speed and up-down control to change it. To do this, follow these steps:

1. Place the following controls on the form:
    * two edit controls (**TEdit**)
    * two up-down controls (**TUpdown**)
1. Associate each up-down control in pairs with the edit control.
1. For each up-down control specify the range (e.g. 0 to 10) by specifying the **Min** and **Max** property.
1. For each up-down control specify the position (e.g., 2 and 3).
1. By default, edit control may display a value not equal to the up-down position. To provide the proper display, add a change event handler for each edit control as follows. Do not miss changing all the control numbers for a second control:

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
        end;

Later (in [step 3](Step3AddCCToFormAndSetUpInteraction)) you will add here a line to set the speed property of the custom control.

## Add Controls to Display the Log of the Balls' Movement

To display the history of the balls' movement use a list box to display the history of each ball's bounces and a label to display the count of bounces for both balls. To do this, follow these steps:

1. Place the following controls on the form:
    * two list box controls (**TListBox**)
    * a label control (**TLabel**)
2. Add a procedure to display a message on the label. Note that singular is used when necessary.

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

Later (in [step 3](Step3AddCCToFormAndSetUpInteraction)) you will add a timer to request information from the custom controls and to display this information in the proper controls of the form.

## Declare and initialize variables

To log the ball movement, use variables to count the number of balls' bounces and to store the previous ball directions. To declare and initialize these variables, follow these steps:

1. Add the following lines to the **var** clause of the module:

        var
          //Collisions number to display on change only
          Collisions1: cardinal;
          Collisions2: cardinal;
          //Directions to display on change
          Direction1: string;
          Direction2: string;

2. To initialize the variables, add the following lines to the `TMainForm.FormCreate` procedure:

        //Initialize and display collisions
        Collisions1 := 0;
        Collisions2 := 0;
        DisplayFullString(Collisions1, Collisions2);
        //Initialize direction
        Direction1 := 'Bottom Right';
        Direction2 := 'Bottom Right';

Later (in [step 3](Step3AddCCToFormAndSetUpInteraction)) you will add lines to initialize and to set up the custom controls and the timer.

## See also

[Next step: Step 2. Create a Custom Control](Step2CreateCustomControl)

[Back to the overview topic](..\CreateApp)

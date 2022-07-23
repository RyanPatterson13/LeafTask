myShapes model = [
                   background
                   ,
                   leaf 
                   |> move model.pos1 
                   |> notifyMouseDown ChangeToDragging1
                   |> if model.dragState /= Dragging1 && getX model.pos1 > (-50)
                       then move ((12 * cos (4 * model.time + 2)), (20 * sin model.time))
                      else move (0, 0)
                   ,
                   leaf 
                   |> move model.pos2 
                   |> notifyMouseDown ChangeToDragging2 
                   |> if model.dragState /= Dragging2 && getX model.pos2 > (-50)
                       then move ((12 * cos (4 * model.time + 1)), (20 * sin model.time))
                      else move (0, 0)
                   ,
                   leaf
                   |> move model.pos3 
                   |> notifyMouseDown ChangeToDragging3 
                   |> if model.dragState /= Dragging3 && getX model.pos3 > (-50)
                       then move ((12 * cos (4 * model.time)), (20 * sin model.time))
                      else move (0, 0)
                   ,
                   leaf
                   |> move model.pos4 
                   |> notifyMouseDown ChangeToDragging4 
                   |> if model.dragState /= Dragging4 && getX model.pos4 > (-50)
                       then move ((12 * cos (4 * model.time + 4)), (20 * sin model.time))
                      else move (0, 0)
                   ,
                   leaf
                   |> move model.pos5 
                   |> notifyMouseDown ChangeToDragging5
                   |> if model.dragState /= Dragging5 && getX model.pos5 > (-50)
                       then move ((12 * cos (4 * model.time + 5)), (20 * sin model.time))
                      else move (0, 0)
                   ,
                   cleanretrybutton
                   |> move (0, -50)
                   |> notifyTap ResetCleanUp
                   ,
                   text ("Time: " ++ (Debug.toString model.countdown))
                   |> filled black
                   |> move (52, 50)
                   ,
                   case model.timerstate of
                     Playing -> group []
                     Won -> text "Task Complete!"
                         |> filled lightGreen
                         |> move (-30, 50)
                     Failed -> text "Task Failed!"
                         |> filled red
                         |> move (-30, 50)
                   ,
                   case model.dragState of 
                     Released -> group []
                     Dragging1 -> rect 185 125 
                         |> ghost 
                         |> notifyMouseMoveAt Drag1 
                         |> notifyLeave ChangeToRelease
                         |> notifyMouseUp ChangeToRelease
                     Dragging2 -> rect 185 125 
                         |> ghost 
                         |> notifyMouseMoveAt Drag2 
                         |> notifyLeave ChangeToRelease
                         |> notifyMouseUp ChangeToRelease
                     Dragging3 -> rect 185 125 
                         |> ghost 
                         |> notifyMouseMoveAt Drag3 
                         |> notifyLeave ChangeToRelease
                         |> notifyMouseUp ChangeToRelease
                     Dragging4 -> rect 185 125 
                         |> ghost 
                         |> notifyMouseMoveAt Drag4 
                         |> notifyLeave ChangeToRelease
                         |> notifyMouseUp ChangeToRelease
                     Dragging5 -> rect 185 125 
                         |> ghost 
                         |> notifyMouseMoveAt Drag5 
                         |> notifyLeave ChangeToRelease
                         |> notifyMouseUp ChangeToRelease
                         
                  
                 ]

type LeafState = Floating | Idle
type TimeState = Playing | Failed | Won
getX (x, y) = x
type DragState = Released | Dragging1 | Dragging2 | Dragging3 | Dragging4 | Dragging5
type Msg = Tick Float GetKeyState | Drag1 (Float, Float) | Drag2 (Float, Float) | Drag3 (Float, Float) | Drag4 (Float, Float) | Drag5 (Float, Float) | ChangeToDragging1 | ChangeToDragging2 | ChangeToDragging3 | ChangeToDragging4 | ChangeToDragging5 
         | ChangeToRelease | ResetCleanUp
update msg model = case msg of
                     Tick t _ -> { model | time = t, 
                                           timerstate = (if model.leaf1 == Idle && model.leaf2 == Idle && model.leaf3 == Idle && model.leaf4 == Idle && model.leaf5 == Idle && model.timerstate /= Failed then Won else (if model.timerstate == Playing && model.countdown == 0 then Failed
                                           else (if model.countdown > 29 then Playing else model.timerstate))),
                                           leaf1 = (if getX model.pos1 <= (-50) then Idle else Floating),
                                           leaf2 = (if getX model.pos2 <= (-50) then Idle else Floating),
                                           leaf3 = (if getX model.pos3 <= (-50) then Idle else Floating),
                                           leaf4 = (if getX model.pos4 <= (-50) then Idle else Floating),
                                           leaf5 = (if getX model.pos5 <= (-50) then Idle else Floating),
                                           countdown = if model.timerstate == Won then model.countdown else (if model.countdown > 0 then (30 - (model.time - model.currenttime)) else 0)
                                           
                                           
                                           }
                     
                     Drag1 (x, y) -> { model | pos1 = (x , y) }
                     
                     Drag2 (x, y) -> { model | pos2 = (x , y) }
                     
                     Drag3 (x, y) -> { model | pos3 = (x , y) }
                     
                     Drag4 (x, y) -> { model | pos4 = (x , y) }
                     
                     Drag5 (x, y) -> { model | pos5 = (x , y) }
                     
                     ChangeToRelease -> { model | dragState = Released
                                        }
                                        
                     ChangeToDragging1 -> { model | dragState = Dragging1
                                        }
                     
                     ChangeToDragging2 -> { model | dragState = Dragging2
                                        }
                     
                     ChangeToDragging3 -> { model | dragState = Dragging3
                                        }
                     
                     ChangeToDragging4 -> { model | dragState = Dragging4
                                        }
                     
                     ChangeToDragging5 -> { model | dragState = Dragging5
                                        }
                                        
                     ResetCleanUp -> { model | pos1 = (0,0), pos2 = (50,20), pos3 = (30,-40), pos4 = (0,40), pos5 = (30, 40), currenttime = model.time, countdown = 30.0, timerstate = Playing}

init = { time = 0 , dragState = Released, pos1 = (0,0), pos2 = (50,20), pos3 = (30,-40), pos4 = (0, 40), pos5 = (30, 40), countdown = 30.0, currenttime = 0, timerstate = Playing, leaf1 = Floating, 
        leaf2 = Floating, leaf3 = Floating, leaf4 = Floating, leaf5 = Floating}
        
cleanretrybutton = group [

                  rect 30 10
                    |> filled yellow
                  ,
                  text "Retry"
                    |> filled black
                    |> scale 0.5
                    |> move (-7, -2)
                          ]

leaf = group [ 
            circle 10
              |> filled darkGreen
            ,
            triangle 10
              |> filled darkGreen
              |> move (-5, -8)
            ,
            rect 2 7
              |> filled darkGreen
              |> rotate (degrees -40)
              |> move (8, 10)
             ]

background = group [
            rect 220 150
              |> filled lightBlue
            ,
            rect 2 125
              |> filled black
              |> move (-45, 0)
            ,
            rect 5 80
              |> filled grey
              |> move (-45, 0)
            ,
            triangle 3
              |> filled darkGrey
              |> rotate (degrees 180)
              |> move (-40, 0)
            ,
            rect 70 150
              |> filled darkGrey
              |> move (-80, 0)
            ,
            text "DISPOSAL"
              |> filled black
              |> rotate (degrees -60)
              |> move (-90, 25)
                   ]

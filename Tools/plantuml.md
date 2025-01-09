# PlantUML Activity Diagram Syntax Guide

PlantUML allows you to create activity diagrams using simple text syntax. This guide provides examples of basic syntax and commonly used features.

## Basic Syntax

```plantuml
@startuml
!theme mars
right header 
<font color=red>Warning:</font>
example header
endheader
title Basic Syntax
left footer @ example footer
start
:This is an action;
:Another action;
if (Condition?) then (yes)
  :Action for yes;
else (no)
  :Action for no;
endif
stop
@enduml
```
![Basic Syntax](../images/tools/uml_basic-syntax.png?raw=true "Basic Syntax")

## Adding Notes

```plantuml
@startuml
title Adding Notes
start
:Start action;
note left
  This is a note on the left.
end note
:Next action;
stop
@enduml
```
![Adding Notes](../images/tools/uml_adding-notes.png?raw=true "Adding Notes")

## Parallel Activities

```plantuml
@startuml
title Parallel Activities
start
fork
  :Action 1;
fork again
  :Action 2;
end fork
:Continue;
stop
@enduml
```
![Parallel Activities](../images/tools/uml_parallel-activities.png?raw=true "Parallel Activities")

## Swimlanes

```plantuml
@startuml
title Swimlanes
|User|
start
:User action;
|System|
:Process action;
stop
@enduml
```
![Swimlanes](../images/tools/uml_swimlanes.png?raw=true "Swimlanes")

## Loops

```plantuml
@startuml
title Loops
start
repeat
  :Loop action;
repeat while (Condition?)
stop
@enduml
```
![Loops](../images/tools/uml_loops.png?raw=true "Loops")

## While loop

```plantuml
@startuml
title While loop
while (check filesize ?) is (not empty)
  :read file;
  backward:log;
endwhile (empty)
:close file;
@enduml
```
![While loop](../images/tools/uml_while-loop.png?raw=true "While loop")

## Conditional

```plantuml
@startuml
title Conditional
start
if (Graphviz installed?) then (yes)
  :process all\ndiagrams;
else (no)
  :process only
  __sequence__ and __activity__ diagrams;
endif
stop
@enduml
```
![Conditional](../images/tools/uml_conditional.png?raw=true "Conditional")

## Best Practices

1. **Keep Diagrams Simple**:
   - Avoid overloading diagrams with too many elements. Use sub-diagrams when necessary to break down complexity.

2. **Use Meaningful Names**:
   - Name activities, decisions, and swimlanes descriptively to make the diagram self-explanatory.

3. **Add Notes**:
   - Use notes to provide additional context or explanations for complex parts of the diagram.

4. **Organize with Swimlanes**:
   - Use swimlanes to clearly separate responsibilities between different actors or systems.

5. **Use Consistent Style**:
   - Maintain a consistent naming convention and visual style to improve readability.

6. **Validate Syntax**:
   - Ensure your PlantUML code is free from syntax errors by testing it with a PlantUML renderer.

7. **Document Dependencies**:
   - If the diagram refers to external processes or systems, ensure they are documented elsewhere or linked via sub-diagrams.

## Reference

- [PlantUML Official Documentation](https://plantuml.com/activity-diagram-beta)
- [PlantUML Examples](https://plantuml.com/examples)

This guide demonstrates the basic and advanced syntax for creating activity diagrams in PlantUML. Modify and extend these examples to suit your requirements.

# To-Do App
A simple To-Do App to create, update and delete tasks.

## Assumptions
- Tasks will be stored only on local storage (i.e. no need for sync between multiple devices).
- A task consists of a title and a textual content, images and other media types are out of the scope.

## Features and Implementation Details
- Users can create and delete tasks in the main screen.
- Users can modify and delete a task in the task details screen.
- There is no manual save operation, task detail screen autosaves periodically.
- Although this is a simple project, VIPER design pattern was chosen as it is commonly used by community and corporates. 
- Core Data was used as local storage.
defmodule ToDoTasks do
  import List, only: [replace_at: 3, delete_at: 2]

  def run do
    tasks = []
    loop(tasks)
  end

  def loop(tasks) do
    IO.puts("Choose an action: ")
    IO.puts("1. Add task")
    IO.puts("2. Edit task")
    IO.puts("3. Delete task")
    IO.puts("4. List task")
    IO.puts("5. Quit")

    data = IO.gets("Enter choice: ") |> String.trim() |> String.to_integer()

    tasks =
      case data do
        1 -> add_task(tasks)
        2 -> edit_task(tasks)
        3 -> delete_task(tasks)
        4 -> list_task(tasks)
        5 -> tasks
        _ ->
          IO.puts("Invalid input\n")
          tasks
      end
    if data != 5 do
      loop(tasks)
    else
      IO.puts("Good bye")
    end
  end

  def add_task(tasks) do
    task = IO.gets("Enter a task: ") |> String.trim()
    tasks ++ [task]
  end

  def edit_task(tasks) do
    index = IO.gets("Enter the number of the task you want to edit: ") |> String.trim() |> String.to_integer()

    tasks =
      case Enum.at(tasks, index - 1) do
        nil ->
          IO.puts("Task not found\n")
          tasks
        _task ->
          new_task = IO.gets("Enter a new description for the task: ") |> String.trim()
          replace_at(tasks, index - 1, new_task)
      end
    tasks
  end

  def delete_task(tasks) do
    index = IO.gets("Enter the number of the task you want to delete: ") |> String.trim() |> String.to_integer()

    tasks =
      case Enum.at(tasks, index - 1) do
        nil ->
          IO.puts("Task not found\n")
          tasks
        _task ->
          delete_at(tasks, index - 1)
      end

    tasks
  end

  def list_task(tasks) do
    Enum.with_index(tasks, fn task, index ->
      IO.puts("#{index + 1}. #{task}")
    end)

    tasks
  end
end

ToDoTasks.run()

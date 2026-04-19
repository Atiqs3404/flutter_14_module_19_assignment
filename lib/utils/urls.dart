class Urls {
  static String baseUrl = "https://todo-restapi-crud-render.onrender.com";

  static String getAllTask = "$baseUrl/get_all_todo";

  static String createTask = "$baseUrl/create_todo";

  static String deleteTask(String id) => "$baseUrl/delete_todo_by_id/$id";

  static String updateTask(String id) => "$baseUrl/update_todo_by_id/$id";
}

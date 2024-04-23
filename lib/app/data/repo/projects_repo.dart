import 'package:time_sheets/app/data/models/project.dart';

class ProjectsRepo {
  Project createProject(Map<String, dynamic> json) {
    return Project.fromJson(json);
  }

  Project editProject(Project project, Map<String, dynamic> json) {
    return project.copyWith(
      name: json['name'],
      description: json['description'],
    );
  }

  List<Project> getProjects(List<dynamic> json) {
    return json.map((project) => Project.fromJson(project)).toList();
  }
}

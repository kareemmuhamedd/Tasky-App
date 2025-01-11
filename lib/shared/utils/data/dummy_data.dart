import '../../../features/create_task/model/task_model.dart';

final dummyObject = TaskModel(
  image: "https://via.placeholder.com/150",
  // Placeholder image URL
  title: "Loading title...",
  // Placeholder title
  desc: "Loading description...",
  // Placeholder description
  priority: "Loading...",
  // Placeholder priority
  status: "Loading...",
  // Placeholder status
  userId: "000000000000000000000000",
  // Placeholder user ID
  id: "000000000000000000000000",
  // Placeholder item ID
  createdAt: DateTime.now(),
  // Current timestamp
  updatedAt: DateTime.now(),
  // Current timestamp
  version: 0, // Default version
);

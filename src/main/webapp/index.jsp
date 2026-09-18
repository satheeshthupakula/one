<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TaskFlow App</title>

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Segoe UI", Arial, sans-serif;
    }

    body {
      background: #f5f7fb;
      color: #222;
    }

    .app {
      display: flex;
      min-height: 100vh;
    }

    /* Sidebar */
    .sidebar {
      width: 240px;
      background: #111827;
      color: white;
      padding: 25px 15px;
      position: fixed;
      height: 100vh;
    }

    .logo {
      font-size: 24px;
      font-weight: bold;
      text-align: center;
      margin-bottom: 35px;
    }

    .logo span {
      color: #6366f1;
    }

    .menu a {
      display: block;
      color: #cbd5e1;
      text-decoration: none;
      padding: 14px 15px;
      margin: 5px 0;
      border-radius: 8px;
      transition: 0.3s;
    }

    .menu a:hover,
    .menu a.active {
      background: #4f46e5;
      color: white;
    }

    /* Main */
    .main {
      margin-left: 240px;
      width: calc(100% - 240px);
      padding: 30px;
    }

    .topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      gap: 20px;
    }

    .topbar h1 {
      font-size: 28px;
    }

    .search {
      padding: 12px 16px;
      width: 250px;
      border: 1px solid #ddd;
      border-radius: 10px;
      outline: none;
    }

    /* Cards */
    .cards {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
      margin-bottom: 30px;
    }

    .card {
      background: white;
      padding: 25px;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.06);
    }

    .card h3 {
      color: #64748b;
      font-size: 15px;
      margin-bottom: 10px;
    }

    .card p {
      font-size: 30px;
      font-weight: bold;
    }

    .blue {
      border-left: 5px solid #6366f1;
    }

    .green {
      border-left: 5px solid #22c55e;
    }

    .orange {
      border-left: 5px solid #f97316;
    }

    /* Tasks */
    .task-section {
      background: white;
      padding: 25px;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.06);
    }

    .task-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .add-btn {
      background: #4f46e5;
      color: white;
      border: none;
      padding: 10px 18px;
      border-radius: 8px;
      cursor: pointer;
    }

    .add-btn:hover {
      background: #3730a3;
    }

    .task {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px;
      border-bottom: 1px solid #eee;
    }

    .task:last-child {
      border-bottom: none;
    }

    .task-info h4 {
      margin-bottom: 5px;
    }

    .task-info p {
      color: #64748b;
      font-size: 13px;
    }

    .status {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 12px;
      background: #dcfce7;
      color: #15803d;
    }

    /* Mobile */
    @media (max-width: 800px) {

      .sidebar {
        width: 70px;
        padding: 20px 8px;
      }

      .logo {
        font-size: 18px;
      }

      .menu a {
        text-align: center;
        font-size: 0;
      }

      .menu a::first-letter {
        font-size: 20px;
      }

      .main {
        margin-left: 70px;
        width: calc(100% - 70px);
        padding: 20px;
      }

      .cards {
        grid-template-columns: 1fr;
      }

      .topbar {
        flex-direction: column;
        align-items: flex-start;
      }

      .search {
        width: 100%;
      }
    }
  </style>
</head>

<body>

  <div class="app">

    <!-- Sidebar -->
    <aside class="sidebar">
      <div class="logo">
        Task<span>Flow</span>
      </div>

      <nav class="menu">
        <a href="#" class="active">🏠 Dashboard</a>
        <a href="#">📋 Tasks</a>
        <a href="#">📊 Reports</a>
        <a href="#">👥 Team</a>
        <a href="#">⚙️ Settings</a>
      </nav>
    </aside>

    <!-- Main Content -->
    <main class="main">

      <div class="topbar">
        <div>
          <h1>Dashboard</h1>
          <p>Welcome back! Here's what's happening today.</p>
        </div>

        <input
          class="search"
          type="text"
          placeholder="🔍 Search tasks..."
          id="searchBox"
        >
      </div>

      <!-- Statistics -->
      <div class="cards">

        <div class="card blue">
          <h3>Total Tasks</h3>
          <p id="totalTasks">12</p>
        </div>

        <div class="card green">
          <h3>Completed</h3>
          <p id="completedTasks">8</p>
        </div>

        <div class="card orange">
          <h3>Pending</h3>
          <p id="pendingTasks">4</p>
        </div>

      </div>

      <!-- Task List -->
      <section class="task-section">

        <div class="task-header">
          <h2>Recent Tasks</h2>
          <button class="add-btn" onclick="addTask()">
            + Add Task
          </button>
        </div>

        <div id="taskList">

          <div class="task">
            <div class="task-info">
              <h4>Design Homepage</h4>
              <p>Due today</p>
            </div>
            <span class="status">Completed</span>
          </div>

          <div class="task">
            <div class="task-info">
              <h4>Update Database</h4>
              <p>Due tomorrow</p>
            </div>
            <span class="status">Completed</span>
          </div>

          <div class="task">
            <div class="task-info">
              <h4>Create Marketing Plan</h4>
              <p>Due Friday</p>
            </div>
            <span class="status"
              style="background:#ffedd5;color:#c2410c;">
              Pending
            </span>
          </div>

        </div>

      </section>

    </main>
  </div>

  <script>

    function addTask() {

      let taskName = prompt("Enter your task name:");

      if (taskName && taskName.trim() !== "") {

        const taskList = document.getElementById("taskList");

        const task = document.createElement("div");

        task.className = "task";

        task.innerHTML = `
          <div class="task-info">
            <h4>${taskName}</h4>
            <p>New task</p>
          </div>

          <span class="status"
            style="background:#ffedd5;color:#c2410c;">
            Pending
          </span>
        `;

        taskList.appendChild(task);

        updateTaskCount();
      }
    }

    function updateTaskCount() {

      const tasks =
        document.querySelectorAll(".task").length;

      document.getElementById("totalTasks").textContent = tasks;
    }

    // Search tasks
    document
      .getElementById("searchBox")
      .addEventListener("input", function() {

        const search = this.value.toLowerCase();

        document.querySelectorAll(".task").forEach(task => {

          const text = task.textContent.toLowerCase();

          task.style.display =
            text.includes(search) ? "flex" : "none";

        });

      });

  </script>

</body>
</html>

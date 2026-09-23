<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Standalone HTML App</title>

  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f6f8;
      margin: 0;
      padding: 40px;
    }

    .app {
      max-width: 500px;
      margin: auto;
      background: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    h1 {
      color: #333;
    }

    input {
      width: 100%;
      padding: 12px;
      box-sizing: border-box;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
    }

    button {
      padding: 12px 20px;
      background: #007bff;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    button:hover {
      background: #0056b3;
    }

    #result {
      margin-top: 20px;
      font-size: 18px;
      color: #222;
    }
  </style>
</head>

<body>

  <div class="app">
    <h1>My Standalone App</h1>

    <p>Enter your name:</p>

    <input
      type="text"
      id="name"
      placeholder="Enter your name"
    >

    <button onclick="showMessage()">
      Submit
    </button>

    <div id="result"></div>
  </div>

  <script>
    function showMessage() {
      const name = document.getElementById("name").value;

      if (name.trim() === "") {
        document.getElementById("result").textContent =
          "Please enter your name.";
        return;
      }

      document.getElementById("result").textContent =
        "Hello, " + name + "! Welcome to the app.";
    }
  </script>

</body>
</html>

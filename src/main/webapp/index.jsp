<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Application</title>

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }

    body {
      background: #f4f7fb;
      color: #333;
    }

    header {
      background: #4f46e5;
      color: white;
      padding: 20px;
      text-align: center;
    }

    .container {
      max-width: 500px;
      margin: 40px auto;
      background: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }

    h2 {
      margin-bottom: 20px;
      text-align: center;
    }

    label {
      display: block;
      margin: 15px 0 5px;
      font-weight: bold;
    }

    input, textarea, select {
      width: 100%;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 16px;
    }

    textarea {
      height: 100px;
      resize: vertical;
    }

    button {
      width: 100%;
      margin-top: 20px;
      padding: 13px;
      background: #4f46e5;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      cursor: pointer;
    }

    button:hover {
      background: #3730a3;
    }

    #message {
      margin-top: 15px;
      text-align: center;
      color: green;
      font-weight: bold;
    }
  </style>
</head>

<body>

  <header>
    <h1>My Application</h1>
    <p>Simple and user-friendly</p>
  </header>

  <div class="container">
    <h2>Application Form</h2>

    <form id="applicationForm">

      <label for="name">Full Name</label>
      <input type="text" id="name" placeholder="Enter your name" required>

      <label for="email">Email</label>
      <input type="email" id="email" placeholder="Enter your email" required>

      <label for="category">Category</label>
      <select id="category" required>
        <option value="">Select an option</option>
        <option>Student</option>
        <option>Employee</option>
        <option>Business</option>
      </select>

      <label for="messageText">Message</label>
      <textarea id="messageText" placeholder="Write something..."></textarea>

      <button type="submit">Submit Application</button>

      <div id="message"></div>
    </form>
  </div>

  <script>
    document.getElementById("applicationForm").addEventListener("submit", function(event) {
      event.preventDefault();

      document.getElementById("message").textContent =
        "Application submitted successfully!";

      this.reset();
    });
  </script>

</body>
</html>

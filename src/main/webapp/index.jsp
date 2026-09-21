<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KYC Transaction Audit</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            color: #222;
        }

        header {
            background: #172b4d;
            color: white;
            padding: 20px 30px;
        }

        header h1 {
            margin: 0;
        }

        header p {
            margin: 6px 0 0;
            color: #cbd5e1;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .filters {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: end;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        label {
            font-weight: bold;
            font-size: 14px;
        }

        input, select {
            padding: 10px;
            border: 1px solid #ccd3dc;
            border-radius: 5px;
        }

        button {
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .primary {
            background: #2563eb;
            color: white;
        }

        .secondary {
            background: #64748b;
            color: white;
        }

        .success {
            background: #16a34a;
            color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th {
            background: #172b4d;
            color: white;
            text-align: left;
            padding: 12px;
        }

        td {
            padding: 11px;
            border-bottom: 1px solid #e5e7eb;
        }

        tr:hover {
            background: #f8fafc;
        }

        .pass {
            color: #15803d;
            font-weight: bold;
        }

        .fail {
            color: #dc2626;
            font-weight: bold;
        }

        .pending {
            color: #d97706;
            font-weight: bold;
        }

        .summary {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .summary-box {
            flex: 1;
            min-width: 180px;
            padding: 18px;
            border-radius: 7px;
            background: #f8fafc;
            border-left: 5px solid #2563eb;
        }

        .summary-box h3 {
            margin: 0;
            font-size: 14px;
            color: #64748b;
        }

        .summary-box p {
            margin: 8px 0 0;
            font-size: 25px;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #64748b;
        }

        @media (max-width: 800px) {
            table {
                font-size: 12px;
            }

            th, td {
                padding: 7px;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>KYC Transaction Audit</h1>
    <p>Verify KYC completion before transaction processing</p>
</header>

<div class="container">

    <!-- Filters -->
    <div class="card">

        <h2>Audit Filters</h2>

        <div class="filters">

            <div class="field">
                <label for="userId">User ID</label>
                <input
                    type="text"
                    id="userId"
                    placeholder="e.g. U001">
            </div>

            <div class="field">
                <label for="role">Role</label>
                <select id="role">
                    <option value="ALL">All</option>
                    <option value="PAYER">Payer</option>
                    <option value="PAYEE">Payee</option>
                </select>
            </div>

            <div class="field">
                <label for="result">Result</label>
                <select id="result">
                    <option value="ALL">All</option>
                    <option value="PASS">Pass</option>
                    <option value="FAIL">Fail</option>
                </select>
            </div>

            <button class="primary" onclick="runAudit()">
                Run Audit
            </button>

            <button class="secondary" onclick="resetAudit()">
                Reset
            </button>

            <button class="success" onclick="exportCSV()">
                Export CSV
            </button>

        </div>

    </div>

    <!-- Summary -->
    <div class="card">

        <h2>Audit Summary</h2>

        <div class="summary">

            <div class="summary-box">
                <h3>Total Records</h3>
                <p id="totalRecords">0</p>
            </div>

            <div class="summary-box">
                <h3>Passed</h3>
                <p id="passedRecords">0</p>
            </div>

            <div class="summary-box">
                <h3>Failed</h3>
                <p id="failedRecords">0</p>
            </div>

            <div class="summary-box">
                <h3>Distinct Users</h3>
                <p id="distinctUsers">0</p>
            </div>

        </div>

    </div>

    <!-- Results -->
    <div class="card">

        <h2>Audit Results</h2>

        <table>

            <thead>
            <tr>
                <th>Transaction ID</th>
                <th>User ID</th>
                <th>Role</th>
                <th>KYC Date</th>
                <th>Transaction Date</th>
                <th>KYC Status</th>
                <th>Result</th>
            </tr>
            </thead>

            <tbody id="resultTable">
            </tbody>

        </table>

        <div id="emptyMessage" class="empty">
            Click "Run Audit" to generate the audit report.
        </div>

    </div>

</div>


<script>

    /*
     * Sample KYC data
     */
    const kycData = [
        {
            userId: "U001",
            kycDate: "2026-09-01T10:00:00",
            status: "VERIFIED"
        },
        {
            userId: "U002",
            kycDate: "2026-09-02T11:00:00",
            status: "VERIFIED"
        },
        {
            userId: "U003",
            kycDate: "2026-09-10T12:00:00",
            status: "VERIFIED"
        },
        {
            userId: "U004",
            kycDate: "2026-09-20T12:00:00",
            status: "PENDING"
        }
    ];


    /*
     * Sample transaction data
     */
    const transactions = [
        {
            id: "T001",
            payer: "U001",
            payee: "U002",
            date: "2026-09-05T10:00:00"
        },
        {
            id: "T002",
            payer: "U002",
            payee: "U003",
            date: "2026-09-11T10:00:00"
        },
        {
            id: "T003",
            payer: "U003",
            payee: "U001",
            date: "2026-09-12T15:00:00"
        },
        {
            id: "T004",
            payer: "U004",
            payee: "U001",
            date: "2026-09-21T10:00:00"
        }
    ];


    let auditResults = [];


    /*
     * Find KYC record for user
     */
    function findKyc(userId) {

        return kycData.find(
            kyc => kyc.userId === userId
        );

    }


    /*
     * Main audit function
     */
    function runAudit() {

        const userFilter =
            document.getElementById("userId")
                .value
                .trim()
                .toUpperCase();

        const roleFilter =
            document.getElementById("role").value;

        const resultFilter =
            document.getElementById("result").value;


        auditResults = [];


        /*
         * Convert every transaction into
         * two audit records:
         *
         * PAYER
         * PAYEE
         */
        transactions.forEach(transaction => {

            const users = [

                {
                    userId: transaction.payer,
                    role: "PAYER"
                },

                {
                    userId: transaction.payee,
                    role: "PAYEE"
                }

            ];


            users.forEach(user => {

                const kyc = findKyc(user.userId);


                let result = "FAIL";


                if (
                    kyc &&
                    kyc.status === "VERIFIED" &&
                    new Date(kyc.kycDate)
                        < new Date(transaction.date)
                ) {

                    result = "PASS";

                }


                auditResults.push({

                    transactionId: transaction.id,

                    userId: user.userId,

                    role: user.role,

                    kycDate:
                        kyc
                            ? kyc.kycDate
                            : null,

                    transactionDate:
                        transaction.date,

                    kycStatus:
                        kyc
                            ? kyc.status
                            : "NOT FOUND",

                    result: result

                });

            });

        });


        /*
         * Apply filters
         */
        auditResults = auditResults.filter(row => {

            const matchesUser =
                !userFilter ||
                row.userId === userFilter;

            const matchesRole =
                roleFilter === "ALL" ||
                row.role === roleFilter;

            const matchesResult =
                resultFilter === "ALL" ||
                row.result === resultFilter;

            return (
                matchesUser &&
                matchesRole &&
                matchesResult
            );

        });


        displayResults();

    }


    /*
     * Display audit results
     */
    function displayResults() {

        const table =
            document.getElementById("resultTable");

        const empty =
            document.getElementById("emptyMessage");


        table.innerHTML = "";


        if (auditResults.length === 0) {

            empty.style.display = "block";

        } else {

            empty.style.display = "none";

        }


        auditResults.forEach(row => {

            const tr =
                document.createElement("tr");


            const resultClass =
                row.result === "PASS"
                    ? "pass"
                    : "fail";


            tr.innerHTML = `

                <td>${row.transactionId}</td>

                <td>${row.userId}</td>

                <td>${row.role}</td>

                <td>
                    ${formatDate(row.kycDate)}
                </td>

                <td>
                    ${formatDate(row.transactionDate)}
                </td>

                <td>
                    ${row.kycStatus}
                </td>

                <td class="${resultClass}">
                    ${row.result}
                </td>

            `;


            table.appendChild(tr);

        });


        updateSummary();

    }


    /*
     * Update summary boxes
     */
    function updateSummary() {

        const total =
            auditResults.length;


        const passed =
            auditResults.filter(
                x => x.result === "PASS"
            ).length;


        const failed =
            auditResults.filter(
                x => x.result === "FAIL"
            ).length;


        const users =
            new Set(
                auditResults.map(
                    x => x.userId
                )
            );


        document.getElementById(
            "totalRecords"
        ).textContent = total;


        document.getElementById(
            "passedRecords"
        ).textContent = passed;


        document.getElementById(
            "failedRecords"
        ).textContent = failed;


        document.getElementById(
            "distinctUsers"
        ).textContent = users.size;

    }


    /*
     * Format date
     */
    function formatDate(date) {

        if (!date) {
            return "-";
        }

        return new Date(date)
            .toLocaleString();

    }


    /*
     * Reset filters and results
     */
    function resetAudit() {

        document.getElementById(
            "userId"
        ).value = "";

        document.getElementById(
            "role"
        ).value = "ALL";

        document.getElementById(
            "result"
        ).value = "ALL";


        auditResults = [];

        document.getElementById(
            "resultTable"
        ).innerHTML = "";


        document.getElementById(
            "emptyMessage"
        ).style.display = "block";


        updateSummary();

    }


    /*
     * Export results as CSV
     */
    function exportCSV() {

        if (auditResults.length === 0) {

            alert(
                "Please run the audit first."
            );

            return;
        }


        let csv =
            "Transaction ID,User ID,Role,KYC Date,Transaction Date,KYC Status,Result\n";


        auditResults.forEach(row => {

            csv += [

                row.transactionId,
                row.userId,
                row.role,
                row.kycDate || "",
                row.transactionDate,
                row.kycStatus,
                row.result

            ].join(",") + "\n";

        });


        const blob =
            new Blob(
                [csv],
                { type: "text/csv" }
            );


        const url =
            URL.createObjectURL(blob);


        const link =
            document.createElement("a");


        link.href = url;

        link.download =
            "kyc-audit-report.csv";


        link.click();


        URL.revokeObjectURL(url);

    }

</script>

</body>
</html>

<?php
/**
 * Quick Database Connection Verification Script
 *
 * Usage:
 *   CLI:     php test_db_connection.php
 *   Browser: http://localhost/test_db_connection.php
 */

header('Content-Type: text/plain; charset=utf-8');

echo "=== BMS Database Connection Diagnostic ===\n\n";

// Load .env first if present
$envPath = __DIR__ . '/.env';
if (file_exists($envPath)) {
    $lines = file($envPath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        $line = trim($line);
        if ($line === '' || $line[0] === '#') continue;
        $parts = explode('=', $line, 2);
        if (count($parts) === 2 && getenv(trim($parts[0])) === false) {
            putenv(trim($parts[0]) . '=' . trim($parts[1], " \t\n\r\0\x0B\"'"));
        }
    }
}

$host = getenv('DB_HOST') ?: 'localhost';
$port = getenv('DB_PORT') ?: '3306';
$db   = getenv('DB_NAME') ?: 'bms_unified';
$user = getenv('DB_USER') ?: 'root';
$ca   = getenv('DB_SSL_CA') ?: '';

echo "Host:        {$host}\n";
echo "Port:        {$port}\n";
echo "Database:    {$db}\n";
echo "User:        {$user}\n";
echo "SSL CA:      " . ($ca ?: 'None (ca.pem not specified)') . "\n";
if ($ca) {
    echo "CA Exists:   " . (file_exists($ca) || file_exists(__DIR__ . '/' . $ca) ? 'YES' : 'NO (ca.pem not found!)') . "\n";
}
echo "\nAttempting connection...\n";

require_once __DIR__ . '/shared/db.php';

try {
    $pdo = Database::getDB();
    $stmt = $pdo->query("SELECT VERSION() AS ver, NOW() AS db_time, DATABASE() AS cur_db");
    $info = $stmt->fetch(PDO::FETCH_ASSOC);

    echo "Status:      SUCCESS!\n";
    echo "DB Version:  " . $info['ver'] . "\n";
    echo "Current DB:  " . $info['cur_db'] . "\n";
    echo "DB Time:     " . $info['db_time'] . "\n";

    // Check table count
    $tables = $pdo->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
    echo "Tables Found (" . count($tables) . "): " . implode(', ', array_slice($tables, 0, 10)) . (count($tables) > 10 ? '...' : '') . "\n";
} catch (Throwable $e) {
    echo "Status:      FAILED\n";
    echo "Error:       " . $e->getMessage() . "\n\n";
    echo "Troubleshooting Tips for Aiven / Cloud MySQL:\n";
    echo "1. Verify DB_HOST and DB_PORT match the 'Overview' page in Aiven Console.\n";
    echo "2. Download 'ca.pem' from Aiven Console and place it in the project root directory.\n";
    echo "3. Ensure your Aiven service is powered ON and state is 'Running'.\n";
    echo "4. Check that your user has privileges on the database.\n";
}

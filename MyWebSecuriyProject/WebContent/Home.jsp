<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>File Encryption Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card">
            <div class="card-body">
                <h2 class="card-title">File Encryption Service</h2>
                
                <form action="EncryptServlet" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="file" class="form-label">Choose a file:</label>
                        <input type="file" class="form-control" name="file" id="file" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="encryptionAlgorithm" class="form-label">Select encryption algorithm:</label>
                        <select class="form-select" name="encryptionAlgorithm" id="encryptionAlgorithm" required>
                            <option value="AES">AES</option>
                            <option value="RSA">RSA</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="hashAlgorithm" class="form-label">Select hash algorithm:</label>
                        <select class="form-select" name="hashAlgorithm" id="hashAlgorithm" required>
                            <option value="SHA-256">SHA-256</option>
                            <option value="MD5">MD5</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Encrypt File</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
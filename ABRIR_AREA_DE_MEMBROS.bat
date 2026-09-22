@echo off
title FUTFORCE VIP Members Area - Local Server
echo =======================================================
echo     FUTFORCE VIP Members Area - Local Server
echo =======================================================
echo.
echo Access URL: http://localhost:8091/area-de-membros.html
Keep this window open while using the members area.
Opening in your browser now...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "& { cd '%~dp0'; $http = [System.Net.HttpListener]::new(); $http.Prefixes.Add('http://localhost:8091/'); $http.Start(); Start-Process 'http://localhost:8091/area-de-membros.html'; while ($http.IsListening) { $context = $http.GetContext(); $request = $context.Request; $response = $context.Response; $path = $request.Url.LocalPath; if ($path -eq '/') { $path = '/area-de-membros.html' }; $localPath = Join-Path $pwd.Path $path; if (Test-Path $localPath -PathType Leaf) { $bytes = [System.IO.File]::ReadAllBytes($localPath); $response.ContentLength64 = $bytes.Length; if ($path.EndsWith('.html')) { $response.ContentType = 'text/html; charset=utf-8' } elseif ($path.EndsWith('.css')) { $response.ContentType = 'text/css' } elseif ($path.EndsWith('.js')) { $response.ContentType = 'application/javascript' } elseif ($path.EndsWith('.png')) { $response.ContentType = 'image/png' } elseif ($path.EndsWith('.jpg') -or $path.EndsWith('.jpeg')) { $response.ContentType = 'image/jpeg' } elseif ($path.EndsWith('.webp')) { $response.ContentType = 'image/webp' }; $response.OutputStream.Write($bytes, 0, $bytes.Length) } else { $response.StatusCode = 404 }; $response.OutputStream.Close() } }"

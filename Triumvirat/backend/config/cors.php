<?php

return [

    // Cross-Origin Resource Sharing (CORS) Configuration

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['*'],

    'allowed_origins' => array_values(array_filter(array_map(static function ($origin) {
        return is_string($origin) ? rtrim($origin, '/') : $origin;
    }, [
        env('FRONTEND_URL'),
        'https://triumvirat-frontend-w59q.onrender.com',
        'triumvirat-frontend.onrender.com',
        'http://localhost:5173',
        'http://127.0.0.1:5173',
        'http://localhost:3000',
        'http://127.0.0.1:3000',
    ]))),

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => true,

];

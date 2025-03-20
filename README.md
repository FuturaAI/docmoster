# DocMost with Supabase

This repository contains a Docker Compose setup for running DocMost with Supabase as the database provider.

## Overview

DocMost is an open-source document collaboration tool, and this setup connects it to a Supabase PostgreSQL database instead of using the default bundled PostgreSQL container.

## Prerequisites

- Docker and Docker Compose installed on your system
- A Supabase account with a project created
- Database credentials for your Supabase project

## Configuration

The `docker-compose.yml` file includes the following services:

1. **DocMost** - The main application container
2. **Redis** - Required for caching and session management

## Quick Start

1. Clone this repository:
   ```bash
   git clone <your-repository-url>
   cd <repository-directory>
   ```

2. Create a `.env` file in the root directory with the following variables:
   ```
   APP_SECRET=your-strong-secret-key
   SUPABASE_PROJECT=your-project-reference
   SUPABASE_PASSWORD=your-database-password
   ```

3. The `docker-compose.yml` file is already configured to use these environment variables:
   ```yaml
   services:
     docmost:
       image: docmost/docmost:latest
       depends_on:
         - redis
       environment:
         APP_URL: "http://localhost:3000"
         APP_SECRET: ${APP_SECRET}
         DATABASE_URL: postgresql://postgres.${SUPABASE_PROJECT}:${SUPABASE_PASSWORD}@aws-0-eu-central-1.pooler.supabase.com:5432/postgres
         REDIS_URL: "redis://redis:6379"
       ports:
         - "3000:3000"
       restart: unless-stopped
       volumes:
         - docmost:/app/data/storage

     redis:
       image: redis:7.2-alpine
       restart: unless-stopped
       volumes:
         - redis_data:/data

   volumes:
     docmost:
     redis_data:
   ```

4. Start the containers:
   ```bash
   docker-compose up -d
   ```

5. Access DocMost at http://localhost:3000

## Environment Variables

Create a `.env` file with the following variables:

```
# Security Configuration
APP_SECRET=your-strong-secret-key

# Supabase Configuration
SUPABASE_PROJECT=your-project-reference
SUPABASE_PASSWORD=your-database-password

# Optional Configuration
# NODE_ENV=production
# SMTP_HOST=
# SMTP_PORT=
# SMTP_USER=
# SMTP_PASS=
# MAIL_FROM=
```

## Volumes

The setup uses two persistent volumes:
- `docmost`: Stores uploaded files and application data at `/app/data/storage`
- `redis_data`: Stores Redis data

## Notes on Supabase Integration

- This setup uses a direct connection to the Supabase database (port 5432)
- For high-traffic deployments, consider using the connection pooler:
  ```
  DATABASE_URL=postgresql://postgres.${SUPABASE_PROJECT}:${SUPABASE_PASSWORD}@aws-0-eu-central-1.pooler.supabase.com:6543/postgres?pgbouncer=true
  ```

## Securing Your Configuration

- Add `.env` to your `.gitignore` file to prevent accidentally committing credentials
- Consider using Docker secrets for production deployments
- You can create a `.env.example` file with placeholder values for documentation purposes

## Troubleshooting

- If you encounter connection issues, verify your Supabase credentials and network settings
- Ensure your Supabase project allows connections from external sources
- Check Docker logs for detailed error messages:
  ```bash
  docker-compose logs docmost
  ```

## Security Considerations

- Never commit your `.env` file with real credentials to a public repository
- Consider using environment variables or Docker secrets for sensitive information in production
- Regularly update your DocMost image for security patches

## Maintenance

- To update DocMost to the latest version:
  ```bash
  docker-compose pull
  docker-compose up -d
  ```

## Resources

- [DocMost Documentation](https://docmost.com/docs/)
- [Supabase Documentation](https://supabase.com/docs)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
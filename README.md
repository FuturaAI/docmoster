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

2. Update the `DATABASE_URL` in the `docker-compose.yml` file with your Supabase credentials:
   ```yaml
   DATABASE_URL: postgresql://postgres.<your-project-ref>:<your-password>@aws-0-eu-central-1.pooler.supabase.com:5432/postgres
   ```

3. Update the `APP_SECRET` with a strong, unique value:
   ```yaml
   APP_SECRET: "<your-secret-key>"
   ```

4. Start the containers:
   ```bash
   docker-compose up -d
   ```

5. Access DocMost at http://localhost:3000

## Environment Variables

- `APP_URL`: The URL where the application will be accessed
- `APP_SECRET`: Secret key for session encryption (should be a strong, random string)
- `DATABASE_URL`: Connection string to your Supabase PostgreSQL database
- `REDIS_URL`: Connection string for Redis

## Volumes

The setup uses two persistent volumes:
- `docmost`: Stores uploaded files and application data
- `redis_data`: Stores Redis data

## Notes on Supabase Integration

- This setup uses a direct connection to the Supabase database (port 5432)
- For high-traffic deployments, consider using the connection pooler:
  ```
  postgresql://postgres.<project-ref>:<password>@aws-0-eu-central-1.pooler.supabase.com:6543/postgres?pgbouncer=true
  ```

## Troubleshooting

- If you encounter connection issues, verify your Supabase credentials and network settings
- Ensure your Supabase project allows connections from external sources
- Check Docker logs for detailed error messages:
  ```bash
  docker-compose logs docmost
  ```

## Security Considerations

- Never commit your `docker-compose.yml` with real credentials to a public repository
- Consider using environment variables or Docker secrets for sensitive information
- Regularly update your DocMost image for security patches

## Maintenance

- To update DocMost to the latest version:
  ```bash
  docker-compose pull
  docker-compose up -d
  ```

## Resources

- [DocMost Documentation](https://docs.docmost.com/)
- [Supabase Documentation](https://supabase.com/docs)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
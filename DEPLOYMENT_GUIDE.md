# Asthana Live - Deployment Guide for Hostinger

## Overview
This guide will help you deploy Asthana Live to your Hostinger hosting account.

## Prerequisites
- Hostinger hosting account with Node.js support
- SSH access to your Hostinger server
- Firebase project credentials
- Google Maps API key

## Step 1: Download Your Project from Replit

### Option A: Download via Replit Shell
1. Open the Shell in Replit (bottom panel)
2. Run these commands to create a zip file:
   ```bash
   cd /home/runner/workspace
   zip -r asthana-live.zip . -x "node_modules/*" -x ".git/*" -x "*.log"
   ```
3. Download the zip file:
   - In the Files panel, find `asthana-live.zip`
   - Right-click and select "Download"

### Option B: Download via Git
1. In Replit Shell:
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   ```
2. Then download as zip (Option A)

## Step 2: Prepare Your Hostinger Server

### Requirements
Your Hostinger plan must support:
- Node.js 18+ (check in Hostinger control panel)
- PostgreSQL database (if you plan to add persistence)
- SSH access
- At least 1GB RAM recommended

### Access Your Server
1. Log into Hostinger control panel
2. Navigate to "Advanced" → "SSH Access"
3. Enable SSH if not already enabled
4. Note your SSH credentials (host, port, username)

## Step 3: Upload and Setup

### Upload Files
1. Using Hostinger File Manager or FTP:
   - Upload the extracted project files to your domain's root directory (e.g., `public_html` or `htdocs`)
   
2. Or using SSH/SCP:
   ```bash
   scp -P [port] -r /path/to/project [username]@[host]:~/public_html/
   ```

### SSH into Server
```bash
ssh -p [port] [username]@[host]
```

### Navigate to Project
```bash
cd ~/public_html
```

### Install Dependencies
```bash
npm install
```

## Step 4: Environment Configuration

Create a `.env` file in the project root:

```bash
nano .env
```

Add these environment variables:

```env
# Server Configuration
NODE_ENV=production
PORT=5000

# Session Secret (generate a random string)
SESSION_SECRET=your-random-secret-here-min-32-chars

# Firebase Configuration
VITE_FIREBASE_API_KEY=your-firebase-api-key
VITE_FIREBASE_APP_ID=your-firebase-app-id
VITE_FIREBASE_PROJECT_ID=your-firebase-project-id

# Google Maps API Key
VITE_GOOGLE_MAPS_API_KEY=AIzaSyBnREfFU6wAmMMQOWIU8Fld2upjgywk-t8

# Database (if using PostgreSQL)
DATABASE_URL=postgresql://user:password@localhost:5432/asthana_live
```

Save the file (Ctrl+O, Enter, Ctrl+X)

## Step 5: Build the Application

```bash
npm run build
```

This creates optimized production files.

## Step 6: Setup Process Manager (PM2)

Install PM2 to keep your app running:

```bash
npm install -g pm2
```

Create a PM2 ecosystem file:

```bash
nano ecosystem.config.js
```

Add this content:

```javascript
module.exports = {
  apps: [{
    name: 'asthana-live',
    script: './server/index.ts',
    interpreter: 'node',
    interpreter_args: '--loader tsx',
    env: {
      NODE_ENV: 'production',
      PORT: 5000
    },
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G'
  }]
}
```

Start the application:

```bash
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

## Step 7: Configure Reverse Proxy (Apache/Nginx)

### For Apache (Hostinger typically uses Apache):

Create/edit `.htaccess` in your domain root:

```apache
<IfModule mod_rewrite.c>
  RewriteEngine On
  
  # Redirect all requests to Node.js app on port 5000
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule ^(.*)$ http://localhost:5000/$1 [P,L]
</IfModule>

# Enable mod_proxy
<IfModule mod_proxy.c>
  ProxyPreserveHost On
  ProxyPass / http://localhost:5000/
  ProxyPassReverse / http://localhost:5000/
</IfModule>
```

## Step 8: Setup Firebase for Production

1. Go to Firebase Console (https://console.firebase.google.com)
2. Select your project
3. Add your Hostinger domain to authorized domains:
   - Go to Authentication → Settings → Authorized domains
   - Add your domain (e.g., `yourdomain.com`)

4. Update Firebase Storage CORS:
   ```bash
   gsutil cors set cors.json gs://your-project-id.appspot.com
   ```

Create `cors.json`:
```json
[
  {
    "origin": ["https://yourdomain.com"],
    "method": ["GET", "POST", "PUT", "DELETE"],
    "maxAgeSeconds": 3600
  }
]
```

## Step 9: Verify Deployment

1. Visit your domain: `https://yourdomain.com`
2. Check if the application loads
3. Test key features:
   - Login/Register
   - Photo upload
   - Office Gallery
   - Real-time updates

## Troubleshooting

### App Not Starting
```bash
# Check PM2 logs
pm2 logs asthana-live

# Check if port 5000 is available
netstat -tulpn | grep 5000

# Restart app
pm2 restart asthana-live
```

### Module Not Found Errors
```bash
# Clean install
rm -rf node_modules package-lock.json
npm install
```

### Permission Issues
```bash
# Fix file permissions
chmod -R 755 /path/to/project
chown -R username:username /path/to/project
```

### Database Connection Issues
- Verify DATABASE_URL in .env
- Check if PostgreSQL is running
- Ensure database exists and user has proper permissions

## Alternative: Using Hostinger's App Installer

Some Hostinger plans offer Node.js app deployment through their control panel:

1. Hostinger Control Panel → "Website" → "Auto Installer"
2. Look for Node.js application option
3. Upload your built files
4. Configure environment variables through the panel

## Performance Optimization

1. **Enable Compression**:
   - Already configured in the Express server

2. **Use CDN for Static Assets**:
   - Consider Cloudflare (free plan available)

3. **Database Optimization**:
   - Use connection pooling
   - Add indexes to frequently queried fields

4. **Monitoring**:
   ```bash
   # Monitor resource usage
   pm2 monit
   
   # View app status
   pm2 status
   ```

## Updating Your Application

When you make changes:

1. Download updated code from Replit
2. Upload to server
3. Install new dependencies (if any):
   ```bash
   npm install
   ```
4. Rebuild:
   ```bash
   npm run build
   ```
5. Restart:
   ```bash
   pm2 restart asthana-live
   ```

## Security Checklist

- [ ] Change SESSION_SECRET to a unique random string
- [ ] Use HTTPS (SSL certificate - Hostinger provides free SSL)
- [ ] Keep Firebase API keys secure in .env
- [ ] Set proper file permissions (755 for directories, 644 for files)
- [ ] Configure firewall rules if available
- [ ] Regular backups of database and uploaded photos
- [ ] Keep Node.js and npm packages updated

## Support

If you encounter issues:
1. Check PM2 logs: `pm2 logs asthana-live`
2. Check Apache/Nginx error logs (in Hostinger control panel)
3. Verify all environment variables are set correctly
4. Ensure Node.js version compatibility (18+)

## Important Notes

⚠️ **Firebase Storage**: Photos uploaded by users will be stored in Firebase Storage, not on your Hostinger server. Ensure your Firebase project has proper storage rules configured.

⚠️ **Real-time Features**: WebSocket connections for real-time updates may require additional configuration on some Hostinger plans.

⚠️ **Resource Limits**: Check your Hostinger plan's resource limits (RAM, CPU) to ensure they can handle your expected traffic.

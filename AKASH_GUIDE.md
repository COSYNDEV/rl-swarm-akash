# Gensyn Testnet Node Deployment Guide on Akash Network

## Prerequisites
- A funded Akash account (can use credit card or crypto wallet like Keplr)
- AKT tokens for deployment (not required if you use credit card)

## Deployment Steps

1. **Access Akash Console**
   - Go to [console.akash.network](https://console.akash.network)
   - Sign in to your account or connect your wallet

2. **Start Deployment**
   - Click on "Deploy"
   - Select "Run Custom Container"
   - Switch to YAML view

3. **Configure Deployment**
   - Copy the deployment [YAML](/deploy.yml) repository
   - Make sure to use the latest version of the Docker image (check packages for latest version)
   - Configure your preferred model size (0.5, 1.5, 7, 32, 72)
   - Choose between small or large swarm (recommended: large swarm for A100/H100)

4. **Select Provider**
   - Review available providers with A100/H100 GPUs
   - Select your preferred provider
   - Accept the bid

5. **Wait for Deployment**
   - The deployment process may take a few minutes
   - The container image will be pulled (may be faster if cached)
   - Monitor the deployment status

6. **Access the Node**
   - Once deployed, go to the leases section
   - Click on the provided URL
   - If you see a security warning:
     - Click on "Advanced"
     - Proceed to the site
   - Sign in with your email
   - Wait for verification email
   - Complete the sign-in process

7. **Verify Operation**
   - The node will start downloading the model
   - It will attempt to connect to the swarm
   - If it crashes during connection:
     - Wait and sign in again
     - The process will retry automatically
   - To verify GPU usage:
     - Check GPU utilization (should be around 99%)
     - Verify VRAM usage (typically 40GB for 32B model)

## Important Notes
- Always backup your `swarm.pem` file from inside the Akash deployment
- This backup allows you to move to a different provider if needed
- The deployment can be restored using the backup file

## Troubleshooting
- Keep your `swarm.pem` file secure as it's crucial for redeployment (See [Backup & restore your swarm.pem file from inside the Akash Deployment](/README.md#backup-your-swarmpem-file-from-inside-the-akash-deployment))

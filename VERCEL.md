# Vercel deployment

This project uses the community PHP runtime configured in `vercel.json`.

## Deploy

1. Import the repository into Vercel with the project root set to this directory.
2. Add the variables from `.env.example` under **Project Settings > Environment Variables**.
3. Provision a hosted MySQL database and import one of the `bms_unified*.sql` dumps.
4. Deploy with the Vercel dashboard or `vercel --prod`.

The root URL redirects to the tenant sign-in page. Admin pages remain available under `/Admin/login.php`.

## Important limitations

- Vercel functions are stateless. PHP sessions need a shared session store or a deployment where the runtime's session handling is reliable across instances.
- The local `uploads/` directory is not persistent on Vercel. Move room images and payment proofs to object storage (for example, Vercel Blob or S3-compatible storage) before relying on uploads in production.
- Scheduled reminders require a Vercel Cron job or another external scheduler that calls `/Admin/cron_reminders.php`; the local cron script is not run automatically by Vercel.
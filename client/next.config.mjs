/** @type {import('next').NextConfig} */
const nextConfig = {
  // Remove standalone output for Vercel deployment
  // output: 'standalone',
  experimental: {
    outputFileTracingRoot: undefined,
  },
};

export default nextConfig;

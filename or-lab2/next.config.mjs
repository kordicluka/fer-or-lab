/** @type {import('next').NextConfig} */
const nextConfig = {
  webpack: (config, { isServer }) => {
    config.module.rules.push({
      test: /\.json$/,
      type: "javascript/auto",
      use: [
        {
          loader: "file-loader",
          options: {
            name: "[name].[ext]",
            publicPath: "/_next/static/files",
            outputPath: `${isServer ? "../" : ""}static/files`,
          },
        },
      ],
    });
    return config;
  },
};

export default nextConfig;

# --- Base stage ---
FROM node:20-alpine 

RUN addgroup app && adduser -S -G app app

USER app

WORKDIR /app

# Copy package files and npmrc if present
COPY package*.json ./
# COPY .npmrc* ./

# Install dependencies
# RUN apk add --no-cache python3 make g++ \
#     && npm ci --only=production --unsafe-perm \
#     && npm cache clean --force \
#     && apk del python3 make g++

USER root

RUN npm install

# Copy source code
COPY . .

# Create non-root user
# RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
# RUN chown -R nodejs:nodejs /app
# USER nodejs

EXPOSE 5173

CMD npm run dev

# HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
#     CMD node -e "require('http').get('http://localhost:3000/health', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) }).on('error', () => { process.exit(1) })"

# # --- Development stage ---
# FROM base AS development
# USER root
# RUN npm ci --unsafe-perm && npm cache clean --force
# USER nodejs
# CMD ["npm", "run", "dev"]

# # --- Production stage ---
# FROM base AS production
# CMD ["npm", "start"]

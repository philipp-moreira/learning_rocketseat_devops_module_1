# stage #1 - build
FROM node:20-alpine3.21 AS build

WORKDIR /usr/src/app

# because i'm using npm like package manager, i can use the character '*' to including in image the files 'package.json' and 'package-lock.json'
COPY package*.json ./

# Another good practice is to have a COPY statement for each folder.
# Here I am not using it, because the application is node and I am using 'npm' as package manager. 
# In this case, if I were using 'yarn', there would be a difference in this line, like for example: 'COPY .yarn ./.yarn'

# changing argument from statement to production context
RUN npm install --omit=dev

COPY . . 

RUN npm run build

# stage #2 - run
FROM node:20-alpine3.21 AS run

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/tsconfig.json ./tsconfig.json
COPY --from=build /usr/src/app/package*.json ./
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["npm", "run", "start"]

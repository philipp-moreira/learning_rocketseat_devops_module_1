FROM node:20-alpine3.21

WORKDIR /usr/src/app

# because i'm using npm like package manager, i can use the character '*' to including in image the files 'package.json' and 'package-lock.json'
COPY package*.json ./

# Another good practice is to have a COPY statement for each folder.
# Here I am not using it, because the application is node and I am using 'npm' as package manager. 
# In this case, if I were using 'yarn', there would be a difference in this line, like for example: 'COPY .yarn ./.yarn'


RUN npm install

COPY . .
RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]

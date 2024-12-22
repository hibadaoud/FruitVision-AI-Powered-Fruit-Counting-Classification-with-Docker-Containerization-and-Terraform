  // check-mongo.js
  const mongoose = require('mongoose');
  require('dotenv').config();

  const mongoUri = process.env.MONGO_BASE_URI ;
  options = {
    user: process.env.MONGO_USERNAME,
    pass: process.env.MONGO_PASSWORD,
    dbName: process.env.DB_Test_NAME,
    connectTimeoutMS: 10000, // Connection timeout in milliseconds
    family: 4, // Force IPv4
    authSource: 'admin', // Necessary for authentication in GitLab CI
  }; 
  const connect =mongoose.connect(mongoUri, options )
  .then(() => {
    console.log('MongoDB connection successful');
    process.exit(0); // Exit with success
  })
  .catch((err) => {
    console.error('MongoDB connection failed:', process.env.MONGO_BASE_URI);
    console.error('MongoDB connection failed:', err.message);
    console.error('Full error details:', err);
    process.exit(1); // Exit with failure
  }); 

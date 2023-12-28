const express = require('express');
const app = express();
const cloudinary = require('cloudinary').v2;
const User = require("./Schema/User")
const Post = require("./Schema/BlogPost")
// const sharp = require('sharp');
const port = 4000; // You can choose any available port
const mongoose = require("mongoose");
const BlogPost = require('./Schema/BlogPost');
// mongoose.connect("")
// Middleware to parse JSON data

mongoose.connect('mongodb+srv://mubashir:smiu123@cluster0.yrrns.mongodb.net/blog?retryWrites=true&w=majority')
  .then(() => {
    mongooseConnected = true;
    console.log('Connected to MongoDB');
  })
  .catch((error) => {
    mongooseConnected = false;
    console.error('Error connecting to MongoDB:', error);
  });

cloudinary.config({
  cloud_name: 'dgixhggt0',
  api_key: '562691868772357',
  api_secret: '8OZ2vxLiWd_f3hVMDM-mBlIloA0',
});

function generateUniqueId() {
  const timestamp = new Date().getTime().toString(36);
  const randomString = Math.random().toString(36).substring(2, 8);

  return `${timestamp}-${randomString}`;
}
let mongooseConnected = false;


app.use(express.json());
app.use(express.urlencoded({ extended: true }))


// Define a route for /signin
app.post('/signin', async (req, res) => {
  if (!mongooseConnected) return res.status(500).send("Database error")
  
  const user = await User.findOne({
    $or: [
      { email: req.body.email },
      { username: req.body.username }
    ]
  });

  // console.log(user)
  if (user == null) {

    res.status(404).send("User not found")
  }else {
    console.log(user);
    if (user.password == req.body.password) {

      res.status(200).json({username: user.username, id: user.id, email: user.email})
    }else {
      res.status(401).send("Incorrect Password")

    }
    // console.log()
  }
  // res.send("ok")
});

app.post("/updateLikes", async (req, res) => {
  // console.log(req.body)
  const postId = req.body.postid;
  const authorId = req.body.authorid;
  
  const result = await BlogPost.updateOne(
    { id: postId },
    req.body.operation === "remove" ? { $pull: { likes: authorId } } : {$addToSet: {likes: authorId}}
  );
  
  console.log(`Author id ${authorId}, Operation: ${req.body.operation}`);
  if (result.nModified > 0) {
    res.status(200).send("Removed")
    // console.log(`Removed like for post with id ${postId}`);
  } else {
    console.log(`Author with id ${authorId} has not liked the post`);
    res.status(201).send("Author with id "+authorId+" has not liked the post")
  }
})

app.post("/createpost", async (req, res) => {
  const {author, authorid, description, title, text, img} = req.body;
  if (!mongooseConnected) return res.status(500).send("Database error")
  const uniqueId = generateUniqueId();
  try {
    const post = new Post({author: author, authorid: authorid, description: description, img: img, text: text, title: title, id: uniqueId , likes: [authorid]})

    await post.save();
    // const result = await cloudinary.uploader.upload(req.body.image, {
    //   folder: 'posts', // Optional: Specify a folder in your Cloudinary account
    // });

    // res.json({ message: 'Image uploaded successfully', data: result.secure_url });
  } catch (error) {
    console.error('Error uploading image:', error);
    res.status(500).json({ message: 'Internal Server Error' });
  }
  const retrievedPost = await Post.findOne({ id: uniqueId }).exec();
  res.status(200).json(retrievedPost)
})


app.get("/getall", async (req, res) => {
  if (!mongooseConnected) return res.status(500).send("Database error")

    const posts = await Post.find();
    
    res.json(posts);
})


app.get("/", (req, res) => {
  res.send("Home")
})

app.post('/deletePost', async (req, res) => {
  if (!mongooseConnected) return res.status(500).send("Database error")

  console.log(req.body);

})


app.post('/signup', async (req, res) => {
  if (!mongooseConnected) return res.status(500).send("Database error")

  const user = new User({
    email: req.body.email,
    username: req.body.username,
    password: req.body.password,
    id: generateUniqueId(),
  });

  // Save the new blog post to the database
  await user.save();

  // console.log(user, "saved");

  res.status(200).send("User Signed up")
});

// Start the server
app.listen("4000", () => {
  console.log(`Server is running on port ${port}`);
});
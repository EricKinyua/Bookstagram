const assert = require("assert");
const firebase = require('@firebase/testing');

const PROJECT_ID = 'bookstagram-ea9bf';
const myID = "user_abc";
const theirID = "user_xyz";
const myAuth = {uid: myID, email: "abc@gmail.com"}
const theirAuth = {uid: theirID, email: "xyz@gmail.com"}

function getFirestore(auth) {
    return firebase.initializeTestApp({projectId: PROJECT_ID, auth: auth}).firestore();
}

function getAdminFirestore() {
    return firebase.initializeAdminApp({projectId: PROJECT_ID}).firestore();
}

before(async () => {
    await firebase.clearFirestoreData({projectId: PROJECT_ID});
});

describe("Bookstagram", () => {
    it ("Understands basic arithmetic", () => {
        assert.equal(1+1,2)
    })
    
    it("Can't allow unauthorized users to create a user document", async () => {
        const db = getFirestore(null)
        const userDoc = db.collection('users').doc('doc')
        firebase.assertFails(userDoc.set({foo: 'bar'}))
    })

    it("Can't allow authorized users to create a user document if they are not owners", async () => {
        const db = getFirestore(myAuth)
        const userDoc = db.collection('users').doc('doc')
        firebase.assertFails(userDoc.set({foo: 'bar'}))
    })

    it("Can allow authorized users to create a user document if they are owners", async () => {
        const db = getFirestore(myAuth)
        const userDoc = db.collection('users').doc('user_abc')
        firebase.assertSucceeds(userDoc.set({foo: 'bar'}))
    })

    it("Can't allow unauthorized users to read your document", async () => {
        const db = getFirestore(null)
        const userDoc = db.collection('users').doc(myID)
        firebase.assertFails(userDoc.get())
    })

    it("Can allow authorized users to read their document", async () => {
        const db = getFirestore(myAuth)
        const userDoc = db.collection('users').doc(myID)
        firebase.assertSucceeds(userDoc.get())
    })

    it("Can't allow unauthorized users to update your document", async () => {
        const db = getFirestore(null)
        const userDoc = db.collection('users').doc(myID)
        firebase.assertFails(userDoc.get())
    })

    it("Can allow authorized users to update their document", async () => {
        const db = getFirestore(myAuth)
        const userDoc = db.collection('users').doc(myID)
        firebase.assertSucceeds(userDoc.update({foo: 'bar'}))
    })

    it("Can't allow invalid users to create a post", async () => {
        const db = getFirestore(null)
        const postDoc = db.collection('posts').doc('post_one')
        firebase.assertFails(postDoc.set({foo: 'bar'}))
    })

    
    
    it("Can allow valid users to create a post", async () => {
        const db = getFirestore(myAuth)
        const postDoc = db.collection('posts').doc('post_one')
        //Simulate user presence
        const admin = getAdminFirestore()
        const userDoc = admin.collection('users').doc(myID)
        firebase.assertSucceeds(postDoc.set({author: myID}))
    })

    it("Can't allow non-authors to edit posts", async () => {
        const db = getFirestore(theirAuth)
        const postDoc = db.collection('posts').doc('post_one')
        firebase.assertFails(postDoc.update({title: 'New Title'}))
    })

    it("Can allow authors to edit posts", async () => {
        const db = getFirestore(myAuth)
        const postDoc = db.collection('posts').doc('post_one')
        firebase.assertSucceeds(postDoc.update({title: 'New Title'}))
    })

    it("Can't allow non-authors to delete posts", async () => {
        const db = getFirestore(theirAuth)
        const postDoc = db.collection('posts').doc('post_one')
        firebase.assertFails(postDoc.delete())
    })

    it("Can allow authors to delete their posts", async () => {
        const db = getFirestore(myAuth)
        const postDoc = db.collection('posts').doc('post_one')
        firebase.assertSucceeds(postDoc.delete())
    })
    
})
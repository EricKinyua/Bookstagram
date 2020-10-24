import * as functions from 'firebase-functions'
import {db} from './index'

export const onCreatePost = functions.region('europe-west3').firestore
    .document('/posts/{post}')
    .onCreate(async snapshot => {
        const author: string = snapshot.get('author')
        const id: string = snapshot.id

        try {
            //Retrieve details of author -> name and photoUrl
            const authorDoc = await db.collection('users').doc(author).get()
            const name: string = authorDoc.get('name')
            const photo: string | null = authorDoc.get('photoUrl')

            //Add those details to the post under 'user'
            await db.collection('posts').doc(id).update({
                user: {
                    name: name,
                    photoUrl: photo
                }
            })

            console.log('The post has been added successfully')
        } catch (error) {
            console.error(error)
        }
    })
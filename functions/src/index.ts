import * as superadmin from 'firebase-admin'

superadmin.initializeApp()

import * as posts from './posts'

export const db = superadmin.firestore()

exports.PostCreated = posts.onCreatePost



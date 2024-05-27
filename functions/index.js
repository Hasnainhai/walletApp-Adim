const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const firestore = admin.firestore();

exports.scheduleSubscriptionUpdate = functions.firestore
    .document('subscriptionRequests/{uuid}')
    .onUpdate(async (change, context) => {
        const newValue = change.after.data();
        const previousValue = change.before.data();
        const uuid = context.params.uuid;

        // Check if subscription status changed to "Active"
        if (newValue.subscribtionStatus === 'Active' && previousValue.subscribtionStatus !== 'Active') {
            const startDateTimestamp = newValue.startDate;
            const durationString = newValue.subscriptionDuration;
            const durationMonths = parseInt(durationString, 10);
            const userId = newValue.userId;

            if (isNaN(durationMonths)) {
                console.error(`Invalid duration for subscription request ${uuid}`);
                return;
            }

            // Convert Firestore Timestamp to JavaScript Date
            const startDate = startDateTimestamp.toDate();

            // Calculate the end date by adding the duration in months
            const endDate = new Date(startDate);
            endDate.setMonth(endDate.getMonth() + durationMonths);

            // Schedule the function to run at the end date
            const scheduleTimestamp = endDate.toISOString();

            // Create a task document to be processed later
            const taskRef = firestore.collection('tasks').doc();
            await taskRef.set({
                userId: userId,
                uuid: uuid,
                scheduleTimestamp: scheduleTimestamp
            });

            console.log(`Scheduled subscription update for user ${userId} and request ${uuid} on ${scheduleTimestamp}`);

            return null;
        }

        return null;
    });

// Cloud Task to process the scheduled subscription update
exports.processScheduledSubscriptionUpdate = functions.pubsub.schedule('every 1 minutes').onRun(async (context) => {
    const now = new Date().toISOString();
    const tasksQuerySnapshot = await firestore.collection('tasks').where('scheduleTimestamp', '<=', now).get();

    tasksQuerySnapshot.forEach(async (doc) => {
        const taskData = doc.data();
        const userId = taskData.userId;
        const uuid = taskData.uuid;

        try {
            // Log current task being processed
            console.log(`Processing subscription update for user ${userId} and request ${uuid}`);

            // Update the user's category to "Normal"
            await firestore.collection('users').doc(userId).update({ category: 'Normal' });
            console.log(`Updated user ${userId}'s category to Normal`);

            // Delete the subscription request document
            await firestore.collection('subscriptionRequests').doc(uuid).delete();
            console.log(`Deleted subscription request ${uuid}`);

            // Delete the corresponding document in the user's subscriptionRequests subcollection
            await firestore.collection('users').doc(userId).collection('subscriptionRequests').doc(uuid).delete();
            console.log(`Deleted subscription request ${uuid} from user's subcollection`);

            // Delete the task document
            await firestore.collection('tasks').doc(doc.id).delete();
            console.log(`Deleted task document ${doc.id}`);

            console.log(`Subscription update completed for user ${userId} and request ${uuid}`);
        } catch (error) {
            console.error(`Error processing scheduled subscription update for user ${userId} and request ${uuid}:`, error);
        }
    });

    return null;
});

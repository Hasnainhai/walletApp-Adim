const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const firestore = admin.firestore();

exports.scheduleSubscriptionUpdate = functions.firestore
    .document("subscriptionRequests/{uuid}")
    .onUpdate(async (change, context) => {
      const newValue = change.after.data();
      const previousValue = change.before.data();
      const uuid = context.params.uuid;

      if (
        newValue.subscribtionStatus === "Active" &&
      previousValue.subscribtionStatus !== "Active"
      ) {
        const startDateTimestamp = newValue.startDate;
        const durationString = newValue.subscriptionDuration;
        const durationMonths = parseInt(durationString, 10);
        const userId = newValue.userId;

        if (isNaN(durationMonths)) {
          console.error(`Invalid duration for subscription request ${uuid}`);
          return null;
        }

        const startDate = startDateTimestamp.toDate();
        const endDate = new Date(startDate);
        endDate.setMonth(endDate.getMonth() + durationMonths);
        const scheduleTimestamp = endDate.toISOString();

        const taskRef = firestore.collection("tasks").doc();
        await taskRef.set({
          userId: userId,
          uuid: uuid,
          scheduleTimestamp: scheduleTimestamp,
        });

        console.log(
            `Scheduled subscription update for user ${userId} and request ` +
        `${uuid} on ${scheduleTimestamp}`,
        );

        return null;
      }

      return null;
    });

exports.processScheduledSubscriptionUpdate = functions.pubsub
    .schedule("every 1 minutes")
    .onRun(async (context) => {
      const now = new Date().toISOString();
      const tasksQuerySnapshot = await firestore
          .collection("tasks")
          .where("scheduleTimestamp", "<=", now)
          .get();

      tasksQuerySnapshot.forEach(async (doc) => {
        const taskData = doc.data();
        const userId = taskData.userId;
        const uuid = taskData.uuid;

        try {
          console.log(
              `Processing subscription update for user ${userId} and request ` +
          `${uuid}`,
          );

          await firestore.collection("users").doc(userId).update({
            category: "Normal",
          });
          console.log(`Updated user ${userId}'s category to Normal`);

          await firestore.collection("subscriptionRequests").doc(uuid).delete();
          console.log(`Deleted subscription request ${uuid}`);

          await firestore
              .collection("users")
              .doc(userId)
              .collection("subscriptionRequests")
              .doc(uuid)
              .delete();
          console.log(
              `Deleted subscription request ${uuid} from user's subcollection`,
          );

          await firestore.collection("tasks").doc(doc.id).delete();
          console.log(`Deleted task document ${doc.id}`);
        } catch (error) {
          console.error(
              `Error processing scheduled subscription update for user ` +
          `${userId} and request ${uuid}:`,
              error,
          );
        }
      });

      return null;
    });

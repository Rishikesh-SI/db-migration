-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_track_user_activity_pts track_user_activity_pts_pk
-- Type: CONSTRAINT

-- Name: zeven_track_user_activity_pts track_user_activity_pts_pk; Type: CONSTRAINT; Schema: zeven; Owner: -
--

ALTER TABLE ONLY zeven.zeven_track_user_activity_pts
    ADD CONSTRAINT track_user_activity_pts_pk PRIMARY KEY (userid, articleid, activityid, sportid, categoryid, sub_categoryid, asset_type_id);


--

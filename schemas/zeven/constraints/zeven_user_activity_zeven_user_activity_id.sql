-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_activity zeven_user_activity_id
-- Type: CONSTRAINT

-- Name: zeven_user_activity zeven_user_activity_id; Type: CONSTRAINT; Schema: zeven; Owner: -
--

ALTER TABLE ONLY zeven.zeven_user_activity
    ADD CONSTRAINT zeven_user_activity_id PRIMARY KEY (user_activity_id);


--

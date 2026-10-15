-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_user_activity stn_user_activity_id
-- Type: CONSTRAINT

-- Name: stn_user_activity stn_user_activity_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_user_activity
    ADD CONSTRAINT stn_user_activity_id PRIMARY KEY (user_activity_id);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_user_activity ppb_user_activity_id
-- Type: CONSTRAINT

-- Name: ppb_user_activity ppb_user_activity_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_user_activity
    ADD CONSTRAINT ppb_user_activity_id PRIMARY KEY (user_activity_id);


--

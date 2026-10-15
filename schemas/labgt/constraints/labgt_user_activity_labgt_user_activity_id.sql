-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_user_activity labgt_user_activity_id
-- Type: CONSTRAINT

-- Name: labgt_user_activity labgt_user_activity_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_user_activity
    ADD CONSTRAINT labgt_user_activity_id PRIMARY KEY (user_activity_id);


--

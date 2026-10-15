-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_user_activity labtkr_user_activity_id
-- Type: CONSTRAINT

-- Name: labtkr_user_activity labtkr_user_activity_id; Type: CONSTRAINT; Schema: labtkr_beta; Owner: -
--

ALTER TABLE ONLY labtkr_beta.labtkr_user_activity
    ADD CONSTRAINT labtkr_user_activity_id PRIMARY KEY (user_activity_id);


--

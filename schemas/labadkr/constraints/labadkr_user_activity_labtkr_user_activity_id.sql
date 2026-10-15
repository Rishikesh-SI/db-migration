-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_user_activity labtkr_user_activity_id
-- Type: CONSTRAINT

-- Name: labadkr_user_activity labtkr_user_activity_id; Type: CONSTRAINT; Schema: labadkr; Owner: -
--

ALTER TABLE ONLY labadkr.labadkr_user_activity
    ADD CONSTRAINT labtkr_user_activity_id PRIMARY KEY (user_activity_id);


--

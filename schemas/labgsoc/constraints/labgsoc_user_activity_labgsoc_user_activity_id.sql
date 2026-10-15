-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_user_activity labgsoc_user_activity_id
-- Type: CONSTRAINT

-- Name: labgsoc_user_activity labgsoc_user_activity_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_user_activity
    ADD CONSTRAINT labgsoc_user_activity_id PRIMARY KEY (user_activity_id);


--

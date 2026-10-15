-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_user_activity labrao_user_activity_id
-- Type: CONSTRAINT

-- Name: labrao_user_activity labrao_user_activity_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_user_activity
    ADD CONSTRAINT labrao_user_activity_id PRIMARY KEY (user_activity_id);


--

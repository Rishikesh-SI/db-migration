-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_user_activity labpbl_user_activity_id
-- Type: CONSTRAINT

-- Name: labpbl_user_activity labpbl_user_activity_id; Type: CONSTRAINT; Schema: labpbl; Owner: -
--

ALTER TABLE ONLY labpbl.labpbl_user_activity
    ADD CONSTRAINT labpbl_user_activity_id PRIMARY KEY (user_activity_id);


--

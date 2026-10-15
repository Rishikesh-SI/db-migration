-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_user_activity labsrk_user_activity_id
-- Type: CONSTRAINT

-- Name: labsrk_user_activity labsrk_user_activity_id; Type: CONSTRAINT; Schema: labsrk; Owner: -
--

ALTER TABLE ONLY labsrk.labsrk_user_activity
    ADD CONSTRAINT labsrk_user_activity_id PRIMARY KEY (user_activity_id);


--

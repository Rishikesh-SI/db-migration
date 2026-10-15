-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_user_activity cfc_user_activity_id
-- Type: CONSTRAINT

-- Name: cfc_user_activity cfc_user_activity_id; Type: CONSTRAINT; Schema: cfc; Owner: -
--

ALTER TABLE ONLY cfc.cfc_user_activity
    ADD CONSTRAINT cfc_user_activity_id PRIMARY KEY (user_activity_id);


--

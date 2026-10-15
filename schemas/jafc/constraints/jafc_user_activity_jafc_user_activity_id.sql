-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_user_activity jafc_user_activity_id
-- Type: CONSTRAINT

-- Name: jafc_user_activity jafc_user_activity_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_user_activity
    ADD CONSTRAINT jafc_user_activity_id PRIMARY KEY (user_activity_id);


--

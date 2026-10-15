-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_user_activity labjfc_user_activity_id
-- Type: CONSTRAINT

-- Name: labjfc_user_activity labjfc_user_activity_id; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.labjfc_user_activity
    ADD CONSTRAINT labjfc_user_activity_id PRIMARY KEY (user_activity_id);


--

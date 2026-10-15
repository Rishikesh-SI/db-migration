-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_user_activity labboost_user_activity_id
-- Type: CONSTRAINT

-- Name: labboost_user_activity labboost_user_activity_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_user_activity
    ADD CONSTRAINT labboost_user_activity_id PRIMARY KEY (user_activity_id);


--

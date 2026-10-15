-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_branded_survey_response uq_branded_survey_user_survey
-- Type: CONSTRAINT

-- Name: labrr_branded_survey_response uq_branded_survey_user_survey; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_branded_survey_response
    ADD CONSTRAINT uq_branded_survey_user_survey UNIQUE (user_guid, survey_id);


--

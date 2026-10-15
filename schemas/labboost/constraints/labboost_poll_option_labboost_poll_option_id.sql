-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_poll_option labboost_poll_option_id
-- Type: CONSTRAINT

-- Name: labboost_poll_option labboost_poll_option_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_poll_option
    ADD CONSTRAINT labboost_poll_option_id PRIMARY KEY (poll_option_id);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_poll_response labboost_poll_response_id
-- Type: CONSTRAINT

-- Name: labboost_poll_response labboost_poll_response_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_poll_response
    ADD CONSTRAINT labboost_poll_response_id PRIMARY KEY (poll_response_id);


--

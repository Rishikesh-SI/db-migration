-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_poll_response labets_poll_response_id
-- Type: CONSTRAINT

-- Name: labets_poll_response labets_poll_response_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_poll_response
    ADD CONSTRAINT labets_poll_response_id PRIMARY KEY (poll_response_id);


--

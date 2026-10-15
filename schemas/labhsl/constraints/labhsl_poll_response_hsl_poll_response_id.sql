-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_poll_response hsl_poll_response_id
-- Type: CONSTRAINT

-- Name: labhsl_poll_response hsl_poll_response_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_poll_response
    ADD CONSTRAINT hsl_poll_response_id PRIMARY KEY (poll_response_id);


--

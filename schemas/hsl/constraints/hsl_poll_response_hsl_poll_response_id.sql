-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_poll_response hsl_poll_response_id
-- Type: CONSTRAINT

-- Name: hsl_poll_response hsl_poll_response_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_poll_response
    ADD CONSTRAINT hsl_poll_response_id PRIMARY KEY (poll_response_id);


--

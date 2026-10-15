-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_poll_response labpr_poll_response_id
-- Type: CONSTRAINT

-- Name: labpr_poll_response labpr_poll_response_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_poll_response
    ADD CONSTRAINT labpr_poll_response_id PRIMARY KEY (poll_response_id);


--

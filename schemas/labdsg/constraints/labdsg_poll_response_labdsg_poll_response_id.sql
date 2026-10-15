-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_poll_response labdsg_poll_response_id
-- Type: CONSTRAINT

-- Name: labdsg_poll_response labdsg_poll_response_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_poll_response
    ADD CONSTRAINT labdsg_poll_response_id PRIMARY KEY (poll_response_id);


--

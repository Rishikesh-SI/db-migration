-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_poll_response labbsc_poll_response_id
-- Type: CONSTRAINT

-- Name: labbsc_poll_response labbsc_poll_response_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_poll_response
    ADD CONSTRAINT labbsc_poll_response_id PRIMARY KEY (poll_response_id);


--

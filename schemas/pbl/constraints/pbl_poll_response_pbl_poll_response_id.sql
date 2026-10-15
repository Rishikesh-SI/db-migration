-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_poll_response pbl_poll_response_id
-- Type: CONSTRAINT

-- Name: pbl_poll_response pbl_poll_response_id; Type: CONSTRAINT; Schema: pbl; Owner: -
--

ALTER TABLE ONLY pbl.pbl_poll_response
    ADD CONSTRAINT pbl_poll_response_id PRIMARY KEY (poll_response_id);


--

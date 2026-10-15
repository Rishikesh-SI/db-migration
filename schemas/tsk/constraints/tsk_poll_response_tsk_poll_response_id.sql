-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_poll_response tsk_poll_response_id
-- Type: CONSTRAINT

-- Name: tsk_poll_response tsk_poll_response_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_poll_response
    ADD CONSTRAINT tsk_poll_response_id PRIMARY KEY (poll_response_id);


--

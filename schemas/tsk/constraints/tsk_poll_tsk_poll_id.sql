-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_poll tsk_poll_id
-- Type: CONSTRAINT

-- Name: tsk_poll tsk_poll_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_poll
    ADD CONSTRAINT tsk_poll_id PRIMARY KEY (poll_id);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_poll_option tsk_poll_option_id
-- Type: CONSTRAINT

-- Name: tsk_poll_option tsk_poll_option_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_poll_option
    ADD CONSTRAINT tsk_poll_option_id PRIMARY KEY (poll_option_id);


--

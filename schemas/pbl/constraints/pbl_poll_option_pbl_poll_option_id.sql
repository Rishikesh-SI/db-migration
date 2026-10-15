-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_poll_option pbl_poll_option_id
-- Type: CONSTRAINT

-- Name: pbl_poll_option pbl_poll_option_id; Type: CONSTRAINT; Schema: pbl; Owner: -
--

ALTER TABLE ONLY pbl.pbl_poll_option
    ADD CONSTRAINT pbl_poll_option_id PRIMARY KEY (poll_option_id);


--
